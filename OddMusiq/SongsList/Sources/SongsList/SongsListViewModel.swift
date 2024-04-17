import UseCaseProtocol
import Entities
import Combine
import Foundation
import PlayerService

class SongsListViewModel: ObservableObject {
    @Published var items: [SongViewState]
    @Published var state: ViewState
    /// Represents active loading bages with process. Only for observation.
    @Published
    var loadingProcesses: [Song.Identity: CurrentValueSubject<Float, Never>] = [:]
    
    init(items: [SongViewState] = [], state: ViewState = .loading, interactor: SongsListInteractor? = nil) {
        self.items = items
        self.state = state
        self.interactor = interactor
        interactor?.viewModel = self
    }
    
    enum ViewState {
        case error(String)
        case songs
        case loading
    }
    
    /// this holds all the logic and responsible for any mutations of the state. Could be nill for Preview stage
    var interactor: SongsListInteractor?
    
    @MainActor
    func onWillAppear() {
        interactor?.onWillAppear()
    }
    
    @MainActor
    func onSelectItem(at index: Int) {
        interactor?.onSelectItem(at: index)
    }
}

class SongViewState {
    var song: Song
    var status: SongViewStatus
    var downloadedSong: DownloadedSongAudio?
    init(song: Song, status: SongViewStatus) {
        self.song = song
        self.status = status
    }
}

enum SongViewStatus {
    case unloaded
    case loading(Float)
    case paused
    case playing
}

class SongsListInteractor {
    var songsUseCase: SongsUseCaseProtocol
    var downloadedAudioUseCase: DownloadedSongsUseCaseProtocol
    var loadAudioUseCase: DownloadSongAudioUseCaseProtocol
    var playerService: PlayerServiceProtocol
    weak var viewModel: SongsListViewModel!

    init(songsUseCase: SongsUseCaseProtocol,
         playerService: PlayerServiceProtocol,
         downloadedSongsUseCase: DownloadedSongsUseCaseProtocol,
         loadAudioUseCase: DownloadSongAudioUseCaseProtocol) {
        self.songsUseCase = songsUseCase
        self.playerService = playerService
        self.downloadedAudioUseCase = downloadedSongsUseCase
        self.loadAudioUseCase = loadAudioUseCase
    }

    var playingItem: SongViewState? {
        didSet {
            guard let downloadedSong = playingItem?.downloadedSong else {
                assertionFailure("there nothing to play")
                return
            }
            if oldValue?.song.id == downloadedSong.id {
                playerService.resume()
            } else {
                try! playerService.play(item: downloadedSong)
            }
        }
    }
    
    @MainActor
    func onWillAppear() {
        viewModel.state = .loading
        Task { @MainActor in
            do {
                let cachedSongs = try? await songsUseCase.execute(cached: true)
                viewModel.items = cachedSongs?.map { songViewState(for: $0) } ?? []
                viewModel.state = .songs
                
                let upstreamSongs = try await songsUseCase.execute(cached: false)
                viewModel.items = upstreamSongs.map { songViewState(for: $0) }
                viewModel.state = .songs
            } catch let error {
                viewModel.state = .error(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func onSelectItem(at index: Int) {
        let item = viewModel.items[index]
        if case .loading = item.status {
            return print("did select loading item")
        }
        
        switch item.status {
        case .playing:
            // togle play/pause
            item.status = .paused
            playerService.pause()
        case .paused:
            playingItem?.status = .paused
            item.status = .playing
            playingItem = item
        case .unloaded:
            item.status = .loading(0)
            self.startDownloading(item: item, viewModel: viewModel)
        case .loading(_):
            break; // do nothing
        }
        viewModel.state = .songs
    }
    
    private func songViewState(for song: Song) -> SongViewState {
        let state = SongViewState(song: song, status: .unloaded)
        if let playingItem, song.id == playingItem.song.id {
            state.status = .playing
        } else if let downloadedSong = self.downloadedAudioUseCase.execute(songId: song.id) {
            state.downloadedSong = downloadedSong
            state.status = .paused
        } else if let progress = viewModel.loadingProcesses[song.id] {
            state.status = .loading(progress.value)
        } else {
            state.status = .unloaded
        }
        return state
    }
    
    private func startDownloading(item: SongViewState, viewModel: SongsListViewModel) {
        let progressSubject = CurrentValueSubject<Float, Never>(0)
        Task { @MainActor in
            do {
                let _ = try await self.loadAudioUseCase.execute(song: item.song, progress: progressSubject)
                viewModel.items = viewModel.items.map { $0.song }.map { songViewState(for: $0) }
                viewModel.state = .songs
            } catch let error {
                item.status = .unloaded
                viewModel.state = .error(error.localizedDescription)
                print("loading of audio finished with error: \(error)")
            }
            viewModel.loadingProcesses[item.song.id] = nil
        }
        viewModel.loadingProcesses[item.song.id] = progressSubject
    }
}

extension DownloadedSongAudio: PlayableItem { }

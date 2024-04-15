import UseCaseProtocol
import Entities
import Combine
import Foundation

final class SongsListViewModel: ObservableObject {
    
    enum State {
        case error(String)
        case songs
        case loading
    }
    
    @MainActor
    @Published var items: [SongViewState] = []
    
    @MainActor
    @Published var state: State = .loading
    
    var songsUseCase: SongsUseCaseProtocol

    init(songsUseCase: SongsUseCaseProtocol) {
        self.songsUseCase = songsUseCase
    }
    
    @MainActor
    func onWillAppear() {
        state = .loading
        Task { @MainActor in
            do {
                let cachedSongs = try await songsUseCase.execute(cached: true)
//                try await Task.sleep(nanoseconds: 1_000_000_000)
                self.items = cachedSongs.map { SongViewState(song: $0, status: .paused) }
                state = .songs
                
                let updatedSongs = try await songsUseCase.execute(cached: false)
                self.items = updatedSongs.map { SongViewState(song: $0, status: .unloaded) }
                state = .songs
                
//                try await Task.sleep(nanoseconds: 1_000_000_000)
//                self.items = songs.map { SongViewState(song: $0, status: .unloaded) }
//                self.items = songs.map { SongViewState(song: $0, status: .loading(0.4)) }
                state = .songs
            } catch let error {
                state = .error(error.localizedDescription)
            }
            
        }
    }
}

struct SongViewState {
    var song: Song
    var status: SongViewStatus
}

enum SongViewStatus {
    case unloaded
    case loading(Float)
    case paused
    case playing
}

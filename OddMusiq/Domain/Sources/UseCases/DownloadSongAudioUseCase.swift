import Entities
import RepositoryProtocol
import UseCaseProtocol
import Combine

public final class DownloadSongAudioUseCase: DownloadSongAudioUseCaseProtocol {
    var repository: SongsAudioRepositoryProtocol
    init(repository: SongsAudioRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(song: Song, progress: CurrentValueSubject<Float, Never>) async throws -> DownloadedSongAudio {
        try await repository.download(song: song, progress: progress)
    }
}

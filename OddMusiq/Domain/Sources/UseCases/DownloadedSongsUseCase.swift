import Entities
import RepositoryProtocol
import UseCaseProtocol

public final class DownloadedSongsUseCase: DownloadedSongsUseCaseProtocol {
    var repository: SongsAudioRepositoryProtocol
    init(repository: SongsAudioRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(songId: Song.Identity) -> DownloadedSongAudio? {
        return repository.downloadedSongAudio(songId: songId)
    }
}

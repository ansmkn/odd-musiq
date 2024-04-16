import Entities
import Combine

public protocol SongsAudioRepositoryProtocol {
    func download(song: Song, progress: CurrentValueSubject<Float, Never>) async throws -> DownloadedSongAudio
    func downloadedSongAudio(songId: Song.Identity) -> DownloadedSongAudio?
}

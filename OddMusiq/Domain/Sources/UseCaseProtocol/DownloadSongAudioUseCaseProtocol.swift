import Entities
import Combine

/// Start loading a will return current progress of loading on everty next event
public protocol DownloadSongAudioUseCaseProtocol {
    func execute(song: Song, progress: CurrentValueSubject<Float, Never>) async throws -> DownloadedSongAudio
}

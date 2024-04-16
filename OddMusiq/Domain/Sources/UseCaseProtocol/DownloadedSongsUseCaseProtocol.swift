import Foundation
import Entities

public protocol DownloadedSongsUseCaseProtocol {
    func execute(songId: Song.Identity) -> DownloadedSongAudio?
}

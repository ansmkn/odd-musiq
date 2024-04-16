import Foundation

public struct DownloadedSongAudio {
    public typealias FileURL = URL
    public var id: Song.Identity
    public var fileURL: FileURL
    public init(id: Song.Identity, fileURL: FileURL) {
        self.id = id
        self.fileURL = fileURL
    }
}

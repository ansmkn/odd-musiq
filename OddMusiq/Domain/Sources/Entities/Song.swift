import Foundation

public struct Song: Decodable {
    public typealias Identity = String
    public var id: Identity
    public var name: String
    public var audioURL: URL
    
    public init(id: Identity, name: String, audioURL: URL) {
        self.id = id
        self.name = name
        self.audioURL = audioURL
    }
}

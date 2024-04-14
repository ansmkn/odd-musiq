
import Foundation

public struct Song: Decodable {
    public var id: String
    public var name: String
    public var audioURL: URL
}

import Foundation

public protocol PlayableItem {
    var fileURL: URL { get }
}

public protocol PlayerServiceProtocol {
    func play(item: PlayableItem) throws
    func pause()
    func resume()
}


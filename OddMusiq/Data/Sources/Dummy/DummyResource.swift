import Foundation

public struct DummyResource: RawDataRepresentable {
    var fileURL: URL
    
    init(fileURL: URL) {
        self.fileURL = fileURL
    }
    
    public func asRawData() throws -> Data {
        try Data(contentsOf: fileURL)
    }
}

public protocol RawDataRepresentable {
    func asRawData() throws -> Data
}

public extension DummyResource {
    static var songsResource: DummyResource {
        let url = Bundle.module.url(forResource: "songs.json", withExtension: nil)!
        return DummyResource(fileURL: url)
    }
}

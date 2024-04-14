import XCTest
@testable import Repositories
import Dummy
import Entities

final class SongsRepositoryTests: XCTestCase {
    
    var dummyNetworkService: DummyNetworkService!
    var sut: SongsRepository!

    override func setUpWithError() throws {
        dummyNetworkService = DummyNetworkService(mockResources: [
            URL(string: "/Songs.json")!: DummyResource.songsResource
        ])
        sut = SongsRepository(networkService: dummyNetworkService)
    }

    override func tearDownWithError() throws {
        dummyNetworkService = nil
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDummyNetworkParsing() async throws {
        let lastSong = try await sut.songs().last!
        XCTAssert(lastSong.audioURL.absoluteString.hasSuffix("id=42"))
    }
}

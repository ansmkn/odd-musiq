
import XCTest
@testable import SongsList

final class SongsListTests: XCTestCase {
    
    override func setUpWithError() throws {
        container = Container()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        container = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

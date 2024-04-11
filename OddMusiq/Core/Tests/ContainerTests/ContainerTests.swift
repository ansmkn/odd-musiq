
import XCTest
import ContainerTestUtils
@testable import Container

final class ContainerTests: XCTestCase {
    var container: Container!
    

    override func setUpWithError() throws {
        container = Container()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        container = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSimpleRegistry() {
        container.register(MyProtocol.self) { _ in
            MyClass()
        }
        
        let proto: MyProtocol? = container.resolve()
        
        XCTAssertNotNil(proto)
    }
    
    func testRegistryOverriding() throws {
        let myObject = MyClass()
        
        container.register(MyProtocol.self) { _ in
            MyClass()
        }
        
        container.register(MyProtocol.self) { _ in
            myObject
        }
        
        let resolvedObject: MyProtocol = try container.tryResolve()
        
        XCTAssertTrue(resolvedObject === myObject)
    }
    
    func testThreadSafety() throws {
        let criticalArea = {
            self.container.register(MyProtocol.self) { _ in
                MyClass()
            }
            _ = self.container.resolve(MyProtocol.self)
        }
        
        let expectation = XCTestExpectation(description: "Concurrent registration")

        let group = DispatchGroup()

        // Perform 1000 increments from different threads
        for _ in 0..<1000 {
            DispatchQueue.global().async(group: group) {
                criticalArea()
            }
        }

        group.notify(queue: .main) {
            XCTAssertFalse(self.container.registry.isEmpty)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }
    
    func testRegistryCapacity() throws {
        for _ in 0..<1000 {
            container.register(MyProtocol.self) { _ in
                MyClass()
            }
        }
        XCTAssertTrue(self.container.registry.count == 1)
    }
}

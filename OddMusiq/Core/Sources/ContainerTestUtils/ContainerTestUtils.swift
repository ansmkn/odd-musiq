import Container

public protocol MyProtocol: AnyObject {
    func myFunc()
}

public class MyClass: MyProtocol {
    public init() {}
    public func myFunc() {}
}

public class MyAssembly: ContainerAssembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MyProtocol.self) { _ in
            MyClass()
        }
    }
}

import Foundation

public protocol ContainerAssembly {
    func assemble(container: Container)
}

public class Assembler {
    public var container = Container()
    public var assemblies: [ContainerAssembly]
    
    public init(assemblies: [ContainerAssembly]) {
        self.assemblies = assemblies
    }
    
    @discardableResult
    public func register() -> Container {
        for assemble in assemblies {
            assemble.assemble(container: container)
        }
        return container
    }
}

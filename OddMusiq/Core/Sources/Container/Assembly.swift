import Foundation

public protocol ContainerAssembly {
    func assemble(container: Container)
}

public class Assembler {
    public var container = Container()
    
    public init() {}
    
    @discardableResult
    public func apply(assemblies: [ContainerAssembly]) -> Container {
        for assemble in assemblies {
            assemble.assemble(container: container)
        }
        return container
    }
}

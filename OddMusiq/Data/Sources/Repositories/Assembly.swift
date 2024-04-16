import Container
import RepositoryProtocol

public class RepositoriesAssembly: ContainerAssembly {
    public init() { }
    
    public func assemble(container: Container) {
        container.register(SongsRepositoryProtocol.self) { container in
            SongsRepository(networkService: container.resolve()!)
        }
        
        container.register(SongsAudioRepositoryProtocol.self) { container in
            SongsAudioRepository(networkService: container.resolve()!)
        }
    }
}

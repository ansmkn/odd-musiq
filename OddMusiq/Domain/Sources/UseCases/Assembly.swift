import Container
import UseCaseProtocol

public class UseCasesAssembly: ContainerAssembly {
    public init() { }
    
    public func assemble(container: Container) {
        container.register(SongsUseCaseProtocol.self) { container in
            SongsUseCase(repository: container.resolve()!)
        }
        
        container.register(DownloadSongAudioUseCaseProtocol.self) { container in
            DownloadSongAudioUseCase(repository: container.resolve()!)
        }
        
        container.register(DownloadedSongsUseCaseProtocol.self) { container in
            DownloadedSongsUseCase(repository: container.resolve()!)
        }

    }
}

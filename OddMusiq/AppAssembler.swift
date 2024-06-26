import Container
import Repositories
import UseCases
import SongsList
import FeatureToggles
import NetworkService
import Environment
import AVFoundation
import PlayerService

extension Assembler {

    static var appAssembler: Assembler {
        let serviceAssemblies = [
            ServiceAssembler()
        ]
        
        let dataAssemblies = [
            RepositoriesAssembly(),
        ]
        
        let domainAssemblies = [
            UseCasesAssembly()
        ]
        
        let presentationAssembiles = [
            SongsListAssembly(modernUI: FeatureToggles.modernUI.isEnabled)
        ]
        
        /// Order is important
        return Assembler(assemblies:
            serviceAssemblies + dataAssemblies + domainAssemblies + presentationAssembiles
        )
    }

    class ServiceAssembler: ContainerAssembly {
        func assemble(container: Container) {
            container.register(NetworkConfiguration.self) { container in
                NetworkConfiguration(name: Environment.current.rawValue, baseURL: EnvironmentVariables.current.baseURL)
            }

            container.register(NetworkServiceProtocol.self) { container in
                NetworkService(configuration: container.resolve()!)
            }
            
            container.register(PlayerServiceProtocol.self) { container in
                PlayerService(avPlayer: AVPlayer())
            }
        }
    }
}

import Container

public class SongsListAssembly: ContainerAssembly {
    var modernUI: Bool
    
    public init(modernUI: Bool) {
        self.modernUI = modernUI
    }
    
    public func assemble(container: Container) {
        container.register(SongsListCoordinator.self) { _ in
            SongsListCoordinator(container: container)
        }
        
        container.register(SongsListViewModel.self) { container in
            SongsListViewModel(songsUseCase: container.resolve()!)
        }
        
        if modernUI {
            container.register(SongsListViewInput.self) { _ in
                SongsListViewHosting()
            }
        } else {
            #if canImport(UIKit)
            container.register(SongsListViewInput.self) { container in
                SongsListViewController(viewModel: container.resolve()!)
            }
            #else
            preconditionFailure("Legacy ui for macos is not supported")
            #endif
        }
        
    }
}


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
        
        container.register(SongsListInteractor.self) { container in
            SongsListInteractor(songsUseCase: container.resolve()!,
                                playerService: container.resolve()!,
                                downloadedSongsUseCase: container.resolve()!,
                                loadAudioUseCase: container.resolve()!)
        }
        
        container.register(SongsListViewModel.self) { container in
            // TODO: Some type miscast occured when inferring optional type. Do not use force unwrapping in cases like this.
            SongsListViewModel(interactor: container.resolve())
        }
        
        if modernUI {
            container.register(SongsListViewInput.self) { container in
                SongsListViewHosting(container: container)
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


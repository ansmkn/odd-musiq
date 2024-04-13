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
        if modernUI {
            container.register(SongsListViewInput.self) { _ in
                SongsListViewHosting()
            }
        } else {
            container.register(SongsListViewInput.self) { _ in
                SongsListViewController()
            }
        }
        
    }
}


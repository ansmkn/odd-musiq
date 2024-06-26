import Coordinator
import Container
import Router

public class SongsListCoordinator: Coordinator {
    public var router: Router?
    
    let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    public func start() {
        showSongsList()
    }
    
    func showSongsList() {
        let module: SongsListViewInput = container.resolve()!
        router?.route(to: module)
    }
}

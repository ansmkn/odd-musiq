import Container
import Coordinator
import Repositories
import UseCases
import SongsList
import Router

@MainActor class AppCoordinator: Coordinator {
    let appAssembler: Assembler
    let appContainer: Container
    
    var router: Router

    init(router: Router) {
        self.appAssembler = Assembler.appAssembler
        self.appContainer = appAssembler.register()
        self.router = router
    }
    
    func start() {
        print("this is start point of the app")
        runSongListFlow()
    }
    
    func runSongListFlow() {
        let songListCoordinator: SongsListCoordinator = appContainer.resolve()!
        songListCoordinator.router = router
        songListCoordinator.start()
    }
}

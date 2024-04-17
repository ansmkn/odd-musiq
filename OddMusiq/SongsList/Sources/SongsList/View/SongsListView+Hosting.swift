import SwiftUI
import UseCaseProtocol
import Entities
import Router
import Container

class SongsListViewHosting: SongsListViewInput {
    var container: Container
    init(container: Container) {
        self.container = container
    }
}

extension SongsListViewHosting: SwiftUIDestination {
    func view() -> any View {
        SongsListView(viewModel: container.resolve()!)
    }
}

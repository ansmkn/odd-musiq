import SwiftUI
import UseCaseProtocol
import Entities
import Router

class SongsListViewHosting: SongsListViewInput {
}

extension SongsListViewHosting: SwiftUIDestination {
    func view() -> any View {
        SongsListView()
    }
}

struct SongsListView: View {
    
//    @MainActor
//    @ObservedObject
//    var viewModel: SongsListViewModel = SongsListViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
//            Text("is analytics enabled: \(viewModel.isAnalyticsEnabled)")
//            Text("assembly is resolved with: \(viewModel.songsUseCase != nil)")
        }
        .padding()
    }
}

#Preview {
    SongsListView()
}


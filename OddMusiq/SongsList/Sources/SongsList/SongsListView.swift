import SwiftUI
import Router

class SongsListViewHosting: SongsListViewInput {
}

extension SongsListViewHosting: SwiftUIDestination {
    func view() -> any View {
        SongsListView()
    }
}

final class SongsListViewModel: ObservableObject {
    
    @Published var val: String = ""

    @MainActor
    init() {
    }
    
//    func songs() async throws -> [Song] {
//        fatalError()
//    }
}

struct SongsListView: View {
    
    @MainActor
    @ObservedObject
    var viewModel: SongsListViewModel = SongsListViewModel()
    
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


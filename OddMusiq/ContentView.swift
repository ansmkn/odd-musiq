import SwiftUI
import Entities
import UseCaseProtocol
import FeatureToggles

final class ContentViewModel: ObservableObject {
    var songsUseCase: SongsUseCaseProtocol?
    
    var isAnalyticsEnabled: Bool = FeatureToggles.analytics.isEnabled
    
    @MainActor
    init() {
//        songsUseCase = OddMusiqApp.appContainer.resolve(SongsUseCaseProtocol.self)
    }
    
    func songs() async throws -> [Song] {
        fatalError()
    }
}

struct ContentView: View {
    
    @MainActor
    @ObservedObject
    var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("is analytics enabled: \(viewModel.isAnalyticsEnabled)")
            Text("assembly is resolved with: \(viewModel.songsUseCase != nil)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

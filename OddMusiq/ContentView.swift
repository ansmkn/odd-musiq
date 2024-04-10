//
//  ContentView.swift
//  OddMusiq
//
//  Created by Alexandr Semakin on 09.04.2024.
//

import SwiftUI
import Entities
import UseCases
import FeatureToggles

final class ContentViewModel {
    var songsUseCase: SongsUseCase!
    
    var isAnalyticsEnabled: Bool = FeatureToggles.analytics.isEnabled
    
    func songs() async throws -> [Song] {
        fatalError()
    }
}

struct ContentView: View {
    
    var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("is analytics enabled: \(viewModel.isAnalyticsEnabled)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

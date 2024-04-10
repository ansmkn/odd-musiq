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
    
    var featureToggles: FeatureToggles = .analytics
    
    func songs() async throws -> [Song] {
        fatalError()
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

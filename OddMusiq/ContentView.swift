//
//  ContentView.swift
//  OddMusiq
//
//  Created by Alexandr Semakin on 09.04.2024.
//

import SwiftUI
import Entities
import UseCases

class ContentViewModel {
    var songsUseCase: SongsUseCase!
    
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

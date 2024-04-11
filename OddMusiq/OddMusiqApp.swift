import SwiftUI
import Container
import Repositories
import UseCases

@main
struct OddMusiqApp: App {
    
    @MainActor
    static let appAssembler: Assembler = {
        var assembly = Assembler()
        assembly.apply(assemblies: [
            RepositoriesAssembly(),
            UseCasesAssembly()
        ])
        return assembly
    }()
    
    @MainActor
    static var appContainer: Container {
        appAssembler.container
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

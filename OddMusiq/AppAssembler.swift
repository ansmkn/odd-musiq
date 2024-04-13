import Container
import Repositories
import UseCases
import SongsList
import FeatureToggles

extension Assembler {

    static var appAssembler: Assembler {
        let dataAssemblies = [
            RepositoriesAssembly(),
        ]
        
        let domainAssemblies = [
            UseCasesAssembly()
        ]
        
        let presentationAssembiles = [
            SongsListAssembly(modernUI: FeatureToggles.modernUI.isEnabled)
        ]
        
        /// Order is important
        return Assembler(assemblies:
            dataAssemblies + domainAssemblies + presentationAssembiles
        )
    }
}

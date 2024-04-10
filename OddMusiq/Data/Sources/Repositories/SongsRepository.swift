import Entities
import RepositoryProtocol

public class SongsRepository: SongsRepositoryProtocol {
    
    public func songs() async throws -> [Song] {
        fatalError()
    }
}

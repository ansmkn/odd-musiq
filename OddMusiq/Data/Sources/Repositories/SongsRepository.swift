import Entities
import RepositoryProtocol

public final class SongsRepository: SongsRepositoryProtocol {
    
    public func songs() async throws -> [Song] {
        fatalError()
    }
}

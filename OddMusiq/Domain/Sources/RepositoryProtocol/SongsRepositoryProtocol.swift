import Entities

public protocol SongsRepositoryProtocol {
    func songs() async throws -> [Song]
}

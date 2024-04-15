import Entities

public protocol SongsRepositoryProtocol {
    func songs(onlyCached: Bool) async throws -> [Song]
}

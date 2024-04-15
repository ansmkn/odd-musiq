import Entities

public protocol PersistedSongsUseCaseProtocol {
    func execute() async throws -> [Song]?
}

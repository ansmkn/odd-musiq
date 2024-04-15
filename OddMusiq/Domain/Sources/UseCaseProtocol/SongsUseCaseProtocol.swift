import Entities

public protocol SongsUseCaseProtocol {
    func execute(cached: Bool) async throws -> [Song]
}

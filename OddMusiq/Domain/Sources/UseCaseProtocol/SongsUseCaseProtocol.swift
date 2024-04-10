import Entities

public protocol SongsUseCaseProtocol {
    func execute() async throws -> [Song]
}

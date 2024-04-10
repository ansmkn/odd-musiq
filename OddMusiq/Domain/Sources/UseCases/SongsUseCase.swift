
import Entities
import RepositoryProtocol
import UseCaseProtocol

public final class SongsUseCase: SongsUseCaseProtocol {

    private let repository: SongsRepositoryProtocol

    public init(repository: SongsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() async throws -> [Song] {
        try await repository.songs()
    }
}

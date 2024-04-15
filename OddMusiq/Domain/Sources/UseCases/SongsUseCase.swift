
import Entities
import RepositoryProtocol
import UseCaseProtocol

final class SongsUseCase: SongsUseCaseProtocol {

    private let repository: SongsRepositoryProtocol

    init(repository: SongsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(cached: Bool) async throws -> [Song] {
        try await repository.songs(onlyCached: cached)
    }
}

import Entities
import RepositoryProtocol
import NetworkService
import Foundation

public final class SongsRepository: SongsRepositoryProtocol {
    
    var networkService: NetworkService
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    public func songs() async throws -> [Song] {
        try await networkService.perform(query: SongsRequest())
    }
}


struct SongsRequest: NetworkRequest {
    typealias Query = EmptyQuery
    typealias ResponseType = [Song]
    
    func makeURL(for configuration: NetworkConfiguration) throws -> URL {
        URL(string: "\(configuration.baseURL)Songs.json")!
    }
}

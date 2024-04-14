import Entities
import RepositoryProtocol
import NetworkService
import Foundation

public final class SongsRepository: SongsRepositoryProtocol {
    
    var networkService: NetworkServiceProtocol
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    public func songs() async throws -> [Song] {
        try await networkService.perform(query: SongsRequest()).data
    }
}


struct SongsRequest: APINetworkRequest {
    struct Response: Decodable {
        var data: [Song]
    }
    typealias Query = EmptyQuery
    typealias ResponseType = Response
    
    func makeURL(for configuration: NetworkConfiguration) throws -> URL {
        URL(string: "\(configuration.baseURL)Songs.json")!
    }
}

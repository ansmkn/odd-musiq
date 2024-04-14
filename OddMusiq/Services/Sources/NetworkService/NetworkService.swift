import Foundation

public protocol NetworkServiceProtocol {
    func perform<T: APINetworkRequest>(query: T) async throws -> T.ResponseType
}

public struct NetworkConfiguration {
    public var name: String
    public var baseURL: URL
    public init(name: String, baseURL: URL) {
        self.name = name
        self.baseURL = baseURL
    }
}

public class NetworkService: NetworkServiceProtocol {
    var configuration: NetworkConfiguration
//    var configuration: URLSessionConfiguration = .default
    var urlSession: URLSession = .shared
    
    public init(configuration: NetworkConfiguration) {
        self.configuration = configuration
    }
    
    public func perform<T: APINetworkRequest>(query: T) async throws -> T.ResponseType {
        let url = try query.makeURL(for: configuration)
        let request = URLRequest(url: url)
        let (data, _) = try await urlSession.data(for: request)
        let decoder = query.decoder()
        return try decoder.decode(T.ResponseType.self, from: data)
    }
}

public protocol APINetworkRequest {
    /// could be logged, hide sensive data
    associatedtype Query: CustomDebugStringConvertible
    associatedtype ResponseType: Decodable
    
    func makeURL(for configuration: NetworkConfiguration) throws -> URL
    func decoder() -> JSONDecoder
}

public extension APINetworkRequest {
    func decoder() -> JSONDecoder {
        return JSONDecoder()
    }
}

public struct EmptyQuery: CustomDebugStringConvertible {
    public var debugDescription: String {
        return ""
    }
}

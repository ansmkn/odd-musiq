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
        var request = URLRequest(url: url)
        if let policy = query.cachePolicy() {
            request.cachePolicy = policy.urlCachePolicy
        }
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
    
    /// If nil will be used protocolCachePolicy
    func cachePolicy() -> NetworkCachePolicy?
}

public extension APINetworkRequest {
    func decoder() -> JSONDecoder {
        JSONDecoder()
    }
    
    func cachePolicy() -> NetworkCachePolicy? {
        nil
    }
}

public struct EmptyQuery: CustomDebugStringConvertible {
    public var debugDescription: String {
        return ""
    }
}

public enum NetworkCachePolicy {
    case returnCacheDataDontLoad
    case reloadRevalidatingCacheData
    
    var urlCachePolicy: URLRequest.CachePolicy {
        switch self {
        case .reloadRevalidatingCacheData:
            return .reloadRevalidatingCacheData
        case .returnCacheDataDontLoad:
            return .returnCacheDataDontLoad
        }
    }
}

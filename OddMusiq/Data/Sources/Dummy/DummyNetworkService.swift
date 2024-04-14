import Foundation
import NetworkService

public class DummyNetworkService: NetworkServiceProtocol {
    
    enum Error: Swift.Error {
        case noResource(for: URL)
    }
    
    var configuration: NetworkConfiguration
    
    var mockResources: [URL: RawDataRepresentable]
    public init(mockResources: [URL : RawDataRepresentable]) {
        self.mockResources = mockResources
        self.configuration = NetworkConfiguration(name: "test", baseURL: URL(string: "/")!)
    }
    
    public func perform<T>(query: T) async throws -> T.ResponseType where T : APINetworkRequest {
        let url = try query.makeURL(for: configuration)
        guard let resource = mockResources[url] else {
            throw Error.noResource(for: url)
        }
        let data = try resource.asRawData()
        
        return try query.decoder().decode(T.ResponseType.self, from: data)
    }
    
}

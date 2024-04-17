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
    
    public func perform<T: APINetworkRequest>(request: T) async throws -> T.ResponseType {
        let url = try request.makeURL(for: configuration)
        guard let resource = mockResources[url] else {
            throw Error.noResource(for: url)
        }
        let data = try resource.asRawData()
        
        return try request.decoder().decode(T.ResponseType.self, from: data)
    }
    
    public func loadFile<T>(request: T, progress: ProgressCallback?) async throws -> URL where T : DownloadDataRequest {
        fatalError("not supported for stubs")
    }
    
    
}

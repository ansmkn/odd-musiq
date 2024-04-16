import Foundation

public typealias ProgressCallback = (Float) -> Void

public protocol NetworkServiceProtocol {
    func perform<T: APINetworkRequest>(request: T) async throws -> T.ResponseType
    func loadFile<T: DownloadDataRequest>(request: T, progress: ProgressCallback?) async throws -> URL
}

public struct NetworkConfiguration {
    public var name: String
    public var baseURL: URL
    public init(name: String, baseURL: URL) {
        self.name = name
        self.baseURL = baseURL
    }
}

struct NetworkServiceError: Swift.Error, LocalizedError {
    
    var errorMessage: String
    init(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    var errorDescription: String? {
        errorMessage
    }

    var failureReason: String? {
        nil
    }

    var recoverySuggestion: String? {
        nil
    }
}

public class NetworkService: NetworkServiceProtocol {
    var configuration: NetworkConfiguration
//    var configuration: URLSessionConfiguration = .default
    var urlSession: URLSession = .shared
    
    public init(configuration: NetworkConfiguration) {
        self.configuration = configuration
    }
    
    public func perform<T: APINetworkRequest>(request: T) async throws -> T.ResponseType {
        let url = try request.makeURL(for: configuration)
        var urlRequest = URLRequest(url: url)
        if let policy = request.cachePolicy() {
            urlRequest.cachePolicy = policy.urlCachePolicy
        }
        let (data, _) = try await urlSession.data(for: urlRequest)
        let decoder = request.decoder()
        return try decoder.decode(T.ResponseType.self, from: data)
    }
    
//    var downloadDelegate: DummyDownloadDelegate?
    
    public func loadFile<T: DownloadDataRequest>(request: T, progress: ProgressCallback?) async throws -> URL {
        let url = try request.makeURL(for: configuration)
        let urlRequest = URLRequest(url: url)
        let donwloadDelegate = DummyDownloadDelegate(progress: progress)
//        self.downloadDelegate = donwloadDelegate
        
        let task = urlSession.downloadTask(with: urlRequest)
        task.delegate = donwloadDelegate

        return try await withUnsafeThrowingContinuation { continuation in
            donwloadDelegate.onComplete = { url in
                do {
                    try FileManager.default.moveItem(at: url, to: request.destinationFileURL)
                    continuation.resume(returning: url)
                } catch let error {
                    continuation.resume(throwing: error)
                }
                
            }
            donwloadDelegate.onError = { url in
                continuation.resume(throwing: url)
            }
            task.resume()
        }
    }
}

class DummyDownloadDelegate: NSObject, URLSessionDownloadDelegate {
    typealias OnErrorCallback = (Error) -> ()
    typealias OnCompleteCallback = (URL) -> Void
    var onProgress: ProgressCallback?
    var onError: OnErrorCallback?
    var onComplete: OnCompleteCallback?
    
    init(progress: ProgressCallback?) {
        self.onProgress = progress
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("did finish downloading to location: \(location.absoluteString)")
        onComplete?(location)
        onComplete = nil
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        print("did receive block \(totalBytesWritten)")
        onProgress?(progress)
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("did resume donwloadin offset: \(fileOffset)\t expected: \(expectedTotalBytes)")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error {
            onError?(error)
            onError = nil
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        print("redirection cause: \(response.statusCode)")
        
        completionHandler(request)
        guard response.statusCode == 303 else {
            onError?(NetworkServiceError("Catch unexpected redirection while downloading the resource"))
            onError = nil
            task.cancel()
            return
        }
    }
}

public protocol DownloadDataRequest {
    func makeURL(for configuration: NetworkConfiguration) throws -> URL
    
    var destinationFileURL: URL { get }
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

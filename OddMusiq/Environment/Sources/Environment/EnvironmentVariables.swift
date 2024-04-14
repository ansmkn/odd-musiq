import Foundation

public struct EnvironmentVariables {
    public var environment: Environment
    
    public init(environment: Environment) {
        self.environment = environment
    }
    
    public var analyticsKey: String {
        switch environment {
        case .unitTesting, .sandbox:
            ""
        case .beta:
            "beta analytics key"
        case .production:
            "production analytics key"
        }
    }
    
    public var baseURL: URL {
        URL(string: "https://gist.githubusercontent.com/Lenhador/a0cf9ef19cd816332435316a2369bc00/raw/a1338834fc60f7513402a569af09ffa302a26b63/")!
    }
    
    public static let current = EnvironmentVariables(environment: .current)
}

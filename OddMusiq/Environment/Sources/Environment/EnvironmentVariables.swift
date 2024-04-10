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
    
    public static let current = EnvironmentVariables(environment: .current)
}

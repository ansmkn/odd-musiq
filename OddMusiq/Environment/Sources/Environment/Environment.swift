import Foundation

public enum Environment: String {
    private static let appEnvironment = Bundle.main.infoDictionary?["APP_ENVIROMENT"] as? String

    case unitTesting
    case sandbox
    case beta
    case production

    public static let current: Environment = {
        guard let appEnvironment else {
            print("have no APP_ENVIRONMENT in Info.plist")
            return .sandbox
        }
        guard let knownEnv = Environment(rawValue: appEnvironment) else {
            print("Info.plist has unknown APP_ENVIRONMENT")
            return .sandbox
        }
        print("Environment: \(knownEnv)")
        return knownEnv
    }()
}

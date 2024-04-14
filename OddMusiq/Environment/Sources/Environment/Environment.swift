import Foundation

public enum Environment: String {
    case unitTesting
    case sandbox
    case beta
    case production

    public static var current: Environment {
        .sandbox
    }
}

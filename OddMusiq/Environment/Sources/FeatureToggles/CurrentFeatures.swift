import Foundation
import Environment

// TODO: could be replaces as fancy PropertyWrapper
enum CurrentFeatures {
    static var enabled: Set<FeatureToggles> {
        switch Environment.current {
        case .beta, .unitTesting, .sandbox:
            return [
                .analytics,
                .authorization,
//                .modernUI
            ]
        case .production:
            return []
        }
    }
}

import Foundation

public protocol FeatureAvailablity {
    var isEnabled: Bool { get }
}

extension FeatureToggles: FeatureAvailablity {
    public var isEnabled: Bool {
        return CurrentFeatures.enabled.contains(self)
    }
    
}

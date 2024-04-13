import Foundation

public protocol Coordinator {
//    var children: [Coordinator] { get }
    @MainActor
    func start()
}

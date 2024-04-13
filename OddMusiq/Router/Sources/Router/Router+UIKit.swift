#if canImport(UIKit)

import UIKit
import SwiftUI

public protocol UIKitDestination: Destination {
    func viewController() -> UIViewController
}

public class UIKitRouter: Router {
    weak var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func route(to destination: any Destination) {
        if let destination = destination as? UIKitDestination {
            navigationController?.setViewControllers([destination.viewController()], animated: false)
        } else if let destination = destination as? SwiftUIDestination {
            let view = AnyView(destination.view())
            let hosting = UIHostingController(rootView: view)
            navigationController?.setViewControllers([hosting], animated: false)
        } else {
            fatalError()
        }
    }
    
}

#endif

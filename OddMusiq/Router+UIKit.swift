import Router

#if canImport(UIKit)

import UIKit

class UIKitRouter: Router {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func route(to destination: any Destination) {
        fatalError()
    }
}

#endif

#if canImport(UIKit)
import UIKit

class SongsListViewController: UIViewController, SongsListViewInput {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
    }
}

import Router

extension SongsListViewController: UIKitDestination {
    func viewController() -> UIViewController {
        self
    }
}

#endif

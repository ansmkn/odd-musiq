#if canImport(UIKit)
import UIKit

extension UIViewController {
    func showError(errorMessage: String) {
        
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

#endif

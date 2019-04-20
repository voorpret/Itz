
import UIKit

extension UIAlertController {
    
    static func error(message: String) -> UIAlertController {
        let alert = UIAlertController(
            title: NSLocalizedString("Error", comment: "Alert's title"),
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("Ok", comment: "Button's title"),
            style: .default,
            handler: nil)
        )
        
        return alert
    }
    
    
}


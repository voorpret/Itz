
import UIKit

extension UILabel {
    
    convenience init(style: UIFont.TextStyle, color: UIColor = .kForeground) {
        self.init(frame: .zero)
        
        font = UIFont.preferredFont(forTextStyle: style)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        textColor = color
    }
    
    
}


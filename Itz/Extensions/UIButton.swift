
import UIKit

extension UIButton {
    
    convenience init(textStyle: UIFont.TextStyle, filled: Bool = true) {
        self.init(type: .system)
        
        titleLabel!.font = UIFont.preferredFont(forTextStyle: textStyle)
        titleLabel!.adjustsFontForContentSizeCategory = true
        titleLabel!.adjustsFontSizeToFitWidth = true
        
        if filled {
            tintColor = .kBackground
            backgroundColor = .kTint
            layer.cornerRadius = 8
        }
    }
    
    
}



import UIKit

final class RootViewController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [
            NewsViewController(newsService: GoogleNews())
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


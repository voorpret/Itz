
import UIKit

final class SpinnerView: UIView {
    
    private let activityView = UIActivityIndicatorView(style: .white)
    
    
    init() {
        super.init(frame: .zero)
        
        isHidden = true
        backgroundColor = .kBackground
        
        addSubview(activityView, constraints: [equal(\.centerYAnchor), equal(\.centerXAnchor)])
        (activityView.widthAnchor.constraint(equalToConstant: 44)).isActive = true
        (activityView.heightAnchor.constraint(equalTo: activityView.widthAnchor)).isActive = true
        activityView.layer.backgroundColor = UIColor.black.cgColor
        activityView.layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        activityView.startAnimating()
        isHidden = false
    }
    
    func stopAnimating() {
        activityView.stopAnimating()
        isHidden = true
    }
    
    
}


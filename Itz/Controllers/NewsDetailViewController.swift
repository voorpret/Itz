
import UIKit
import SafariServices

final class NewsDetailViewController: UIViewController {
    
    private let news: News
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel(style: .headline)
    private let descriptionTextView = UITextView()
    private let safariButton = UIButton(textStyle: .headline)
    
    
    init(news: News) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        news.image.flatMap { imageView.image = $0 }
        
        titleLabel.numberOfLines = 0
        news.title.flatMap { titleLabel.text = $0 }
        
        descriptionTextView.isUserInteractionEnabled = false
        descriptionTextView.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionTextView.adjustsFontForContentSizeCategory = true
        descriptionTextView.textColor = .kForeground
        news.description.flatMap { descriptionTextView.text = $0 }
        
        safariButton.setTitle("See in Safari", for: .normal)
        safariButton.addTarget(self, action: #selector(loadSafariController), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .kBackground
        
        view.addSubview(imageView, constraints: [
            equal(\.topAnchor, constant: 8),
            equal(\.leftAnchor),
            equal(\.rightAnchor)
        ])
        let imageHeight: CGFloat = imageView.image == nil ? 0 : 192
        (imageView.heightAnchor.constraint(equalToConstant: imageHeight)).isActive = true
        
        view.addSubview(titleLabel, constraints: [
            equal(\.leftAnchor, constant: 16),
            equal(\.rightAnchor, constant: -16),
        ])
        (titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8)).isActive = true
        (titleLabel.heightAnchor.constraint(equalToConstant: 72)).isActive = true
        
        view.addSubview(descriptionTextView, constraints: [
            equal(\.leftAnchor, constant: 16),
            equal(\.rightAnchor, constant: -16)
        ])
        (descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)).isActive = true
        
        view.addSubview(safariButton, constraints: [
            equal(\.leftAnchor, constant: 64),
            equal(\.rightAnchor, constant: -64),
            equal(\.bottomAnchor, \.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        (safariButton.heightAnchor.constraint(equalToConstant: 44)).isActive = true
        (safariButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16)).isActive = true
    }
    
    @objc private func loadSafariController() {
        guard let url = news.url else {
            let alert = UIAlertController.error(message: NSLocalizedString("Unable to retrieve URL", comment: "Alert's message"))
            present(alert, animated: true)
            return
        }
        let vc = SFSafariViewController(url: url)
        
        present(vc, animated: true)
    }
    
    
}


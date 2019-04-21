
import UIKit

final class NewsViewController: UIViewController {
    
    private let newsService: NewsService
    
    private var isNetworking = false
    private var news: [News] = []
    private let tableView = NewsTableView()
    private let spinnerView = SpinnerView()
    
    
    init(newsService: NewsService) {
        self.newsService = newsService
        super.init(nibName: nil, bundle: nil)
        
        tableView.newsDelegate = self
        
        title = NSLocalizedString("News", comment: "Controller's title")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchHeadlines))
        
        fetchHeadlines()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .kBackground
        
        view.addSubview(tableView, constraints: [
            equal(\.topAnchor),
            equal(\.leftAnchor),
            equal(\.rightAnchor),
            equal(\.bottomAnchor)
        ])
        view.addSubview(spinnerView, constraints: [
            equal(\.topAnchor),
            equal(\.leftAnchor),
            equal(\.rightAnchor),
            equal(\.bottomAnchor)
        ])
    }
    
    private func setNetworking(_ value: Bool) {
        isNetworking = value
        value ? spinnerView.startAnimating() : spinnerView.stopAnimating()
        navigationItem.rightBarButtonItems?.forEach { $0.isEnabled = !value }
    }
    
    @objc private func fetchHeadlines() {
        guard !isNetworking else { return }
        
        setNetworking(true)
        newsService.topHeadlines { [weak self] result in
            guard let this = self else { return }
            defer { this.setNetworking(false) }
            
            switch result {
            case let .success(news):
                this.news = news
                this.tableView.bind(news)
            case let .failure(error):
                print(error)
                let alert = UIAlertController.error(message: NSLocalizedString("Something went wrong", comment: "Alert's message"))
                
                this.present(alert, animated: true)
            }
        }
    }
    
    
}

extension NewsViewController: NewsTableViewDelegate {
    
    func didSelectNews(_ news: News) {
        show(NewsDetailViewController(news: news), sender: nil)
    }
    
    
}


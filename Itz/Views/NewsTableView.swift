
import UIKit

protocol NewsTableViewDelegate: AnyObject {
    
    func didSelectNews(_ news: News)
    
    
}

final class NewsTableView: UITableView {
    
    weak var newsDelegate: NewsTableViewDelegate?
    
    private let source = NewsTableViewDataSource()
    
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.id)
        dataSource = source
        delegate = source
        
        source.didSelectNews = { [weak self] news in
            self?.newsDelegate?.didSelectNews(news)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ news: [News]) {
        source.bind(news)
        reloadData()
    }
    
    
}


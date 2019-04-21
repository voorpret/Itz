
import UIKit

final class NewsTableView: UITableView {
    
    private let source = NewsTableViewDataSource()
    
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.id)
        dataSource = source
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ news: [News]) {
        source.bind(news)
        reloadData()
    }
    
    
}


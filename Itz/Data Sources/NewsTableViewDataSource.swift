
import UIKit

final class NewsTableViewDataSource: NSObject {
    
    private let httpClient = HTTPClient()
    
    private var models: [Model] = []
    
    
    func bind(_ news: [News]) {
        models = news.map { Model(news: $0) }
    }
    
    
}

extension NewsTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.id, for: indexPath) as! NewsTableViewCell
        
        cell.bind(title: models[indexPath.row].news.title, description: models[indexPath.row].news.description)
        
        guard let imageURL = models[indexPath.row].news.imageURL else {
            return cell
        }
        
        let id = models[indexPath.row].id
        cell.representedId = id
        
        switch models[indexPath.row].imageRequest {
        case .notRequested:
            models[indexPath.row].imageRequest = .fetching
            
            httpClient.execute(URLRequest(url: imageURL)) { [weak self] result in
                guard let this = self else { return }
                guard case let .success(data) = result,
                    let image = UIImage(data: data) else {
                        this.models[indexPath.row].imageRequest = .notAvailable
                        return
                }
                
                this.models[indexPath.row].imageRequest = .fetched(image)
                if cell.representedId == id {
                    cell.bind(image: image)
                }
            }
        case let .fetched(image):
            cell.bind(image: image)
        case .fetching, .notAvailable:
            break // Maybe some default image
        }
        
        return cell
    }
    
    
}

extension NewsTableViewDataSource {
    
    private struct Model {
        
        let id = UUID()
        let news: News
        var imageRequest: ImageRequest = .notRequested
        
        init(news: News) {
            self.news = news
        }
        
        
    }
    
    private enum ImageRequest {
        
        case notRequested
        case fetching
        case notAvailable
        case fetched(UIImage)
        
        
    }
    
    
}


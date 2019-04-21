
import UIKit

struct News: Codable {
    
    let title: String?
    let description: String?
    let url: URL?
    let imageURLString: String?
    var imageURL: URL? {
        return imageURLString == nil ? nil : URL(string: imageURLString!)
    }
    var image: UIImage?
    
    
}

extension News {
    
    enum CodingKeys: String, CodingKey {
        
        case title
        case description
        case url
        case imageURLString = "urlToImage"
        
        
    }
    
    
}



import UIKit

final class GoogleNews: NewsService {
    
    private static let key = "1836bd14395c40d883dff58a0b10177f"
    
    private let httpClient = HTTPClient()
    
    
    func topHeadlines(handler: @escaping (Result<[News], Error>) -> Void) {
        let url = type(of: self).urlComponents(
            endpoint: .topHeadlines,
            queryItems: [URLQueryItem(name: "country", value: "us")] // Harcoded
        ).url!
        let request = URLRequest(url: url)
        
        httpClient.execute(request) { [weak self] response in
            var result: Result<[News], Error> = .failure(NSError(
                domain: NSURLErrorDomain,
                code: NSURLErrorUnknown,
                userInfo: nil)
            )
            defer {
                handler(result)
            }
            
            do {
                let json = try response.decoded() as HeadlinesJSONResponse
                
                result = .success(json.articles)
            } catch {
                result = .failure(error)
            }
        }
    }
    
    
}

extension GoogleNews {
    
    private enum Endpoint: String {
        
        case topHeadlines = "/v2/top-headlines"
        
        
    }
    
    private static func urlComponents(endpoint: Endpoint, queryItems: [URLQueryItem] = []) -> URLComponents {
        var cmp = URLComponents()
        
        cmp.scheme = "https"
        cmp.host = "newsapi.org"
        cmp.path = endpoint.rawValue
        cmp.queryItems = [URLQueryItem(name: "apiKey", value: key)] + queryItems
        
        return cmp
    }
    
    
}

extension GoogleNews {
    
    private struct HeadlinesJSONResponse: Codable {
        
        let articles: [News]
        
        
    }
    
    
}


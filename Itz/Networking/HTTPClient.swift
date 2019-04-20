
import UIKit

final class HTTPClient {
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        
        return URLSession(configuration: config)
    }()
    
    
    func execute(_ request: URLRequest, handler: @escaping (Result<Data, Error>) -> Void) {
        let task = type(of: self).session.dataTask(with: request) { (data, response, error) in
            var result: Result<Data, Error> = .failure(NSError(
                domain: NSURLErrorDomain,
                code: NSURLErrorUnknown,
                userInfo: nil)
            )
            defer {
                DispatchQueue.main.async { handler(result) }
            }
            guard error == nil else {
                result = .failure(error!)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    result = .failure(NSError(
                        domain: NSURLErrorDomain,
                        code: NSURLErrorBadServerResponse,
                        userInfo: nil)
                    )
                    return
            }
            
            data.flatMap { result = .success($0) }
        }
        
        task.resume()
    }
    
    
}


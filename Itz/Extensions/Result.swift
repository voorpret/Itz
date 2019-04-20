
import UIKit

extension Result {
    
    func resolved() throws -> Success {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
    
    
}

extension Result where Success == Data {
    
    func decoded<T: Decodable>() throws -> T {
        let data = try resolved()
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    
}


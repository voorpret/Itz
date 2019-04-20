
protocol NewsService: AnyObject {
    
    init()
    
    func topHeadlines(handler: @escaping (Result<[News], Error>) -> Void)
    
    
}


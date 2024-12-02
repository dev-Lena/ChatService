
struct PaginationResponse<T: Decodable>: Decodable {
    let items: [T]
    let nextToken: String?
    let total: Int
    
    var hasMore: Bool {
        nextToken != nil
    }
}

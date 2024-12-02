struct PaginationRequest {
    let limit: Int
    let offset: Int
    var nextToken: String?
    
    init(limit: Int = 20, offset: Int = 0, nextToken: String? = nil) {
        self.limit = limit
        self.offset = offset
        self.nextToken = nextToken
    }
    
    var dictionary: [String: Any] {
        var params: [String: Any] = [
            "limit": limit,
            "offset": offset
        ]
        if let nextToken = nextToken {
            params["next_token"] = nextToken
        }
        return params
    }
}

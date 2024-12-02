enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingError(Error)
    case encodingError(Error)
}

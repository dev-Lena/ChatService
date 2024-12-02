enum MessageServiceError: Error {
    case invalidMessageId
    case messageNotFound
    case channelNotFound
    case invalidRequest
    
    var localizedDescription: String {
        switch self {
        case .invalidMessageId:
            return "Invalid message ID provided"
        case .messageNotFound:
            return "Message not found"
        case .channelNotFound:
            return "Channel not found"
        case .invalidRequest:
            return "Invalid request parameters"
        }
    }
}

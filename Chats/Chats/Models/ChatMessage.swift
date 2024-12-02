
struct ChatMessage: Identifiable, Codable {
    let messageId: String
    let channelId: String
    let text: String
    let createdAt: Date
    let author: ChatUser
    
    var id: String { messageId }
}

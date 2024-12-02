import Foundation
import Combine

final class MessageRepository {
    private let messageService: MessageServiceProtocol
    private var messageSubscriptions: [String: AnyCancellable] = [:]
    private let messageSubject = PassthroughSubject<ChatMessage, Never>()
    
    var messages: AnyPublisher<ChatMessage, Never> {
        messageSubject.eraseToAnyPublisher()
    }
    
    init(messageService: MessageServiceProtocol) {
        self.messageService = messageService
    }
    
    func sendMessage(channelId: String, text: String) async throws -> ChatMessage {
        let message = try await messageService.sendMessage(channelId: channelId, text: text)
        messageSubject.send(message)
        return message
    }
    
    func fetchMessages(channelId: String, pagination: PaginationRequest) async throws -> [ChatMessage] {
        try await messageService.fetchMessages(channelId: channelId, pagination: pagination)
    }
}

struct SendMessageRequest: Encodable {
    let text: String
}

struct UpdateMessageRequest: Encodable {
    let text: String
}

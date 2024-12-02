import Foundation

protocol MessageServiceProtocol {
    func sendMessage(channelId: String, text: String) async throws -> ChatMessage
    func fetchMessages(channelId: String, pagination: PaginationRequest) async throws -> [ChatMessage]
    func deleteMessage(messageId: String) async throws
    func updateMessage(messageId: String, text: String) async throws -> ChatMessage
}

final class MessageService: MessageServiceProtocol {
    private let networkClient: NetworkClient
    private let baseURL: URL
    
    init(networkClient: NetworkClient, baseURL: URL) {
        self.networkClient = networkClient
        self.baseURL = baseURL
    }
    
    func sendMessage(channelId: String, text: String) async throws -> ChatMessage {
        let request = SendMessageRequest(text: text)
        return try await networkClient.request(
            .post,
            path: "/channels/\(channelId)/messages",
            query: nil,
            body: request
        )
    }
    
    func fetchMessages(channelId: String, pagination: PaginationRequest) async throws -> [ChatMessage] {
        let response: PaginationResponse<ChatMessage> = try await networkClient.request(
            .get,
            path: "/channels/\(channelId)/messages",
            query: pagination.dictionary,
            body: nil
        )
        return response.items
    }
    
    func deleteMessage(messageId: String) async throws {
        try await networkClient.requestWithoutResponse(
            .delete,
            path: "/messages/\(messageId)",
            query: nil,
            body: nil
        )
    }
    
    func updateMessage(messageId: String, text: String) async throws -> ChatMessage {
        let request = UpdateMessageRequest(text: text)
        return try await networkClient.request(
            .patch,
            path: "/messages/\(messageId)",
            query: nil,
            body: request
        )
    }
}

extension MessageService {
    func validateMessageId(_ messageId: String) throws {
        guard !messageId.isEmpty else {
            throw MessageServiceError.invalidMessageId
        }
    }
    
    func validateChannelId(_ channelId: String) throws {
        guard !channelId.isEmpty else {
            throw MessageServiceError.channelNotFound
        }
    }
}

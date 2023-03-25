//
//  ChatGPTViewModel.swift
//  GPT
//
//  Created by Catalin Palade on 24/03/2023.
//

import SwiftUI
import OpenAISwift

class ChatGPTViewModel: ObservableObject {
    
    enum State {
        case loading
        case loaded
    }
    
    var openAI: OpenAISwift
    
    @Published var state: State = .loaded
    @Published var chats: [ChatMessage] = []
    
    init() {
        let apiKey: String = ProcessInfo.processInfo.environment["OPENAI_API_KEY"]!
        self.openAI = OpenAISwift(authToken: apiKey)
    }
    
    func sendNewPrompt(_ prompt: String) {
        state = .loading
        let newChat = ChatMessage(role: .user, content: prompt)
        
        chats.append(newChat)
        
        Task {
            await getGPTResponse(chats: chats)
        }
    }
    
    @MainActor
    private func getGPTResponse(chats: [ChatMessage]) async {
        do {
            let result = try await openAI.sendChat(with: chats)
            if let chat = result.choices.first {
                self.chats.append(chat.message)
            }
            self.state = .loaded
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

//
//  MainViewModel.swift
//  GPT
//
//  Created by Catalin Palade on 24/03/2023.
//

import SwiftUI
import OpenAISwift

class MainViewModel: ObservableObject {
    
    enum State {
        case loading
        case loaded
    }
    
    var openAI: OpenAISwift
    
    @Published var state: State = .loaded
    @Published var chats: [CustomChatMessages] = []
    
    init() {
        let apiKey: String = ProcessInfo.processInfo.environment["OPENAI_API_KEY"]!
        self.openAI = OpenAISwift(authToken: apiKey)
    }
    
    func sendNewPrompt(_ prompt: String) {
        state = .loading
        let newChat = ChatMessage(role: .user, content: prompt)
        
        chats.append(CustomChatMessages(chat: newChat))
        
        Task {
            await getGPTResponse(chats: chats)
        }
    }
    
    @MainActor
    private func getGPTResponse(chats: [CustomChatMessages]) async {
        do {
            let gptChats = chats.map({ $0.chat })
            let result = try await openAI.sendChat(with: gptChats)
            if let chat = result.choices.first {
                self.chats.append(CustomChatMessages(chat: chat.message))
            }
            self.state = .loaded
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

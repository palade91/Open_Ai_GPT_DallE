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
    
    @Published var state: State = .loaded
    @Published var chats: [ChatMessage] = []
    
    init() {
        chats = retriveChats()
    }
    
    func sendNewPrompt(_ prompt: String) {
        state = .loading
        let newChat = ChatMessage(role: .user, content: prompt)
        
        chats.append(newChat)
        
        saveChats(chats)
        
        Task {
            await getGPTResponse(chats: chats)
        }
    }
    
    @MainActor
    private func getGPTResponse(chats: [ChatMessage]) async {
        do {
            let result = try await OpenAIUseCase.shared.openAI.sendChat(with: chats)
            if let chat = result.choices?.first {
                self.chats.append(chat.message)
                self.saveChats(self.chats)
            }
            self.state = .loaded
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // User Defaults
    private let chatKey: String = "ChatGPT_messages"
    private let defaults = UserDefaults.standard
    
    private func saveChats(_ chats: [ChatMessage]) {
        removeChatsFromUserDefaults()
        do {
            try UserDefaultsUseCase.shared.set(object: chats, forKey: chatKey)
        } catch let error {
            if let error = error as? UserDefaultsError {
                print(error.errorDescription)
            }
        }
    }
    
    private func retriveChats() -> [ChatMessage] {
        do {
            return try UserDefaultsUseCase.shared.get(forKey: chatKey, castTo: [ChatMessage].self)
        } catch let error {
            if let error = error as? UserDefaultsError {
                print(error.errorDescription)
            }
            return []
        }
    }
    
    private func removeChatsFromUserDefaults() {
        UserDefaultsUseCase.shared.clearAll(forKey: chatKey)
    }
    
    func clearChats() {
        removeChatsFromUserDefaults()
        chats.removeAll()
    }
}

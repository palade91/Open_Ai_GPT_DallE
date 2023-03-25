//
//  CustomChatMessages.swift
//  GPT
//
//  Created by Catalin Palade on 25/03/2023.
//

import Foundation
import OpenAISwift

struct CustomChatMessages: Hashable {
    let id: UUID = UUID()
    let chat: ChatMessage
    
    public static func == (lhs: CustomChatMessages, rhs: CustomChatMessages) -> Bool {
        return lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

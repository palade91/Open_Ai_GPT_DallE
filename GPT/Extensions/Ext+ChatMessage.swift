//
//  Ext+ChatMessage.swift
//  GPT
//
//  Created by Catalin Palade on 25/03/2023.
//

import Foundation
import OpenAISwift

extension ChatMessage: Hashable {
    public static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        lhs.content == rhs.content
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(content)
    }
}

extension ChatMessage {
    static var id: String = UUID().uuidString
}

//
//  OpenAIUseCase.swift
//  GPT
//
//  Created by Catalin Palade on 26/03/2023.
//

import Foundation
import OpenAISwift

class OpenAIUseCase {
    
    static let shared: OpenAIUseCase = OpenAIUseCase()
    
    var openAI: OpenAISwift
    
    private init() {
        let apiKey: String = ProcessInfo.processInfo.environment["OPENAI_API_KEY"]!
        self.openAI = OpenAISwift(authToken: apiKey)
    }
}

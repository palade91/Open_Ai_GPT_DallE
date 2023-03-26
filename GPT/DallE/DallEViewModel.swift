//
//  DallEViewModel.swift
//  GPT
//
//  Created by Catalin Palade on 26/03/2023.
//

import SwiftUI
import OpenAISwift

class DallEViewModel: ObservableObject {
    
    enum State {
        case loading
        case loaded
    }
    
    @Published var state: State = .loaded
    @Published var imageURL: String?
    
    init() { }
    
    func sendNewPrompt(_ prompt: String) {
        state = .loading
        
        OpenAIUseCase.shared.openAI
            .sendImages(with: prompt, numImages: 1, size: .size1024) { result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.imageURL = success.data?.first?.url
                        self.state = .loaded
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
    }
}

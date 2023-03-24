//
//  MainViewModel.swift
//  GPT
//
//  Created by Catalin Palade on 24/03/2023.
//

import SwiftUI
import OpenAIKit
import AsyncHTTPClient

class MainViewModel: ObservableObject {
    
    var apiKey: String {
        ProcessInfo.processInfo.environment["OPENAI_API_KEY"]!
    }
    var organization: String {
        ProcessInfo.processInfo.environment["OPENAI_ORGANIZATION"]!
    }
    
    var openAIClient: Client?
    
//    var openAISwift: OpenAISwift
    
    init() {
        setupOpenAIClient()
//        Task {
//            await callGpt()
//        }
    }
    
    enum ViewState: Equatable {
        case loading
        case loaded(String)
    }
    
    @Published var viewState: ViewState = .loading
    
    private func setupOpenAIClient() {
        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
        let configuration = Configuration(apiKey: apiKey, organization: organization)

        openAIClient = OpenAIKit.Client(httpClient: httpClient, configuration: configuration)
    }
    
    @MainActor
    private func callGpt() async {
        guard let openAIClient else { return }
        do {
            let completion = try await openAIClient.completions.create(
                model: Model.GPT3.davinci,
                prompts: ["Write a scary story in 6 words"]
            )
            
            self.viewState = .loaded(completion.choices.first?.text ?? "")
            
            completion.choices.forEach { choise in
                print(choise.text)
            }
            
        } catch let error as APIErrorResponse {
            print(error)
            self.viewState = .loaded("Error: \(error.localizedDescription)")
        } catch let error {
            print(error)
            self.viewState = .loaded("Error: \(error.localizedDescription)")
        }
        
    }
}


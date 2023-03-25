//
//  ChatView.swift
//  GPT
//
//  Created by Catalin Palade on 25/03/2023.
//

import SwiftUI
import OpenAISwift

struct ChatView: View {
    
    @ObservedObject var viewModel: ChatGPTViewModel
    
    @State private var prompt: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(viewModel.chats, id: \.self) { chat in
                        Text(chat.content)
                            .foregroundColor(chat.role == .assistant ? .yellow : Color(uiColor: .label))
                    }
                }
                .padding(.horizontal, 5)
                .animation(.default, value: viewModel.chats)
            }
            
            TextField("Enter prompt here", text: $prompt, axis: .vertical)
                .frame(minHeight: 30)
                .autocorrectionDisabled(true)
                .lineLimit(1...10)
                .background(Color(uiColor: UIColor.systemGray).opacity(0.3))
                .cornerRadius(4)
                .onChange(of: prompt) { newValue in
                    guard let lastChar = newValue.last else { return }
                    if lastChar == "\n" {
                        prompt.removeLast()
                        viewModel.sendNewPrompt(prompt)
                        prompt.removeAll()
                    }
                }
        }
        .background(Color(uiColor: UIColor.systemGray2).opacity(0.5))
        .cornerRadius(4)
        .padding(.all, 10)
    }
}

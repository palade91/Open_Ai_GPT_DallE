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
        VStack(alignment: .leading, spacing: 5) {
            ScrollView(.vertical, showsIndicators: false) {
                ScrollViewReader { scrollReader in
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(viewModel.chats.indices, id: \.self) { index in
                            let chat = viewModel.chats[index]
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(chat.role == .assistant ? "ChatGPT" : "You")
                                        .font(Font.title3)
                                        .fontWeight(Font.Weight.bold)
                                    Spacer()
                                    if chat.role == .assistant {
                                        Button {
                                            UIPasteboard.general.string = chat.content
                                        } label: {
                                            Image(systemName: "doc.on.doc")
                                                .resizable()
                                                .renderingMode(.template)
                                                .foregroundColor(Color(uiColor: .label))
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 20)
                                        }
                                    }
                                }
                                Text(chat.content)
                                    .font(Font.body)
                                    .fontWeight(Font.Weight.medium)
                            }
                            .id(index)
                            .padding(.all, 5)
                            .background(Color(uiColor: UIColor.systemGray2).opacity(0.5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(
                                        Color(uiColor: .label),
                                        lineWidth: 1
                                    )
                            )
                            .onChange(of: viewModel.chats) { chats in
                                scrollReader.scrollTo((chats.count - 1), anchor: .bottom)
                            }
                        }
                    }
                    .animation(.default, value: viewModel.chats)
                    
                }
            }
            
            HStack(alignment: .bottom, spacing: 5) {
                TextField("Enter prompt here", text: $prompt, axis: .vertical)
                    .frame(minHeight: 30)
                    .autocorrectionDisabled(true)
                    .lineLimit(1...10)
                    .background(Color(uiColor: UIColor.systemGray).opacity(0.5))
                    .cornerRadius(4)
                Button {
                    if !prompt.isEmpty {
                        viewModel.sendNewPrompt(prompt)
                        prompt.removeAll()
                    }
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(uiColor: .label))
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                }
            }
        }
        .padding(.all, 10)
    }
}

//
//  DallEImage.swift
//  GPT
//
//  Created by Catalin Palade on 26/03/2023.
//

import SwiftUI

struct DallEImage: View {
    
    @ObservedObject var viewModel: DallEViewModel
    
    @State private var prompt: String = ""
    @State private var description: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center) {
                Spacer()
                if let imageURL = viewModel.imageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { image in
                        VStack(alignment: .center, spacing: 10) {
                            Text(description)
                                .font(Font.title3)
                                .fontWeight(Font.Weight.medium)
                                .foregroundColor(Color(uiColor: .label))
                                .multilineTextAlignment(.center)
                                .lineLimit(5)
                            
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(alignment: .center)
                            
                            SaveButton(url: url)
                        }
                        
                    } placeholder: {
                        ActivityIndicator()
                    }
                }
                Spacer()
            }
            Spacer()
            PromptView(prompt: $prompt) {
                if !prompt.isEmpty {
                    description = prompt
                    viewModel.sendNewPrompt(prompt)
                    prompt.removeAll()
                }
            }
        }
        .padding(.all, 10)
    }
}

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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center) {
                Spacer()
                if let imageURL = viewModel.imageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(alignment: .center)
                    } placeholder: {
                        ActivityIndicator()
                    }
                }
                Spacer()
            }
            Spacer()
            PromptView(prompt: $prompt) {
                if !prompt.isEmpty {
                    viewModel.sendNewPrompt(prompt)
                    prompt.removeAll()
                }
            }
        }
        .padding(.all, 10)
    }
}

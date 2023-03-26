//
//  PromptView.swift
//  GPT
//
//  Created by Catalin Palade on 26/03/2023.
//

import SwiftUI

struct PromptView: View {
    
    @Binding var prompt: String
    var action: () -> Void
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            TextField("Enter prompt here", text: $prompt, axis: .vertical)
                .frame(minHeight: 30)
                .autocorrectionDisabled(true)
                .lineLimit(1...10)
                .background(Color(uiColor: UIColor.systemGray).opacity(0.5))
                .cornerRadius(4)
            Button {
                action()
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
}

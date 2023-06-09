//
//  DallEView.swift
//  GPT
//
//  Created by Catalin Palade on 25/03/2023.
//

import SwiftUI

struct DallEView: View {
    
    @StateObject private var viewModel = DallEViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Group {
                switch viewModel.state {
                case .loading:
                    ActivityIndicator()
                case .loaded:
                    Image("open_ai")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(uiColor: .label))
                        .frame(width: 50, height: 50)
                }
            }
            .animation(.default, value: viewModel.state)
            .frame(height: 50)
            
            DallEImage(viewModel: viewModel)
        }
        .frame(maxWidth: .greatestFiniteMagnitude,
               maxHeight: .greatestFiniteMagnitude)
        .background(Color.greenAI.edgesIgnoringSafeArea(.top))
    }
}

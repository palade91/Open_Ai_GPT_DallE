//
//  MainView.swift
//  GPT
//
//  Created by Catalin Palade on 24/03/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Image("open_ai")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color(uiColor: .label))
                    .frame(width: 50, height: 50)
                    .padding(.top, 60)
                Spacer()
            }
            switch viewModel.viewState {
            case .loading:
                ActivityIndicator()
            case .loaded(let string):
                Text(string)
                    .foregroundColor(Color(uiColor: .label))
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .greatestFiniteMagnitude,
               maxHeight: .greatestFiniteMagnitude)
        .background(CustomColor.greenAI)
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}

//
//  GPTTabView.swift
//  GPT
//
//  Created by Catalin Palade on 25/03/2023.
//

import SwiftUI

struct GPTTabView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
    }
    
    var body: some View {
        TabView {
            ChatGPTView()
                .tabItem {
                    Label("Chat GPT", systemImage: "character.bubble")
                }
            DallEView()
                .tabItem {
                    Label("Dall-E", systemImage: "photo.artframe")
                }
        }.tint(.greenAI)
    }
}

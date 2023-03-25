//
//  DallEView.swift
//  GPT
//
//  Created by Catalin Palade on 25/03/2023.
//

import SwiftUI

struct DallEView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
            Text("Dall-E")
        }
        .frame(maxWidth: .greatestFiniteMagnitude,
               maxHeight: .greatestFiniteMagnitude)
        .background(Color.greenAI.edgesIgnoringSafeArea(.top))
    }
}

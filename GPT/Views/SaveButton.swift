//
//  SaveButton.swift
//  GPT
//
//  Created by Catalin Palade on 27/03/2023.
//

import SwiftUI
import UIKit

struct SaveButton: View {
    
    let url: URL
    
    var body: some View {
        Button {
            saveImage()
        } label: {
            HStack(alignment: .center, spacing: 10) {
                Text("Save image to Photo Library")
                    .font(Font.body)
                    .fontWeight(Font.Weight.regular)
                    .foregroundColor(Color(uiColor: .label))
                
                Image(systemName: "square.and.arrow.down")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color(uiColor: .label))
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
            }
        }
    }
    
    private func saveImage() {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            }
        }
    }
}


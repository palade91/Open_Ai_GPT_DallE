//
//  ActivityIndicator.swift
//  GPT
//
//  Created by Catalin Palade on 24/03/2023.
//

import SwiftUI

struct ActivityIndicator: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(
                CircularProgressViewStyle(
                    tint: Color(uiColor: .label)
                )
            )
            .scaleEffect(1.5)
    }
}

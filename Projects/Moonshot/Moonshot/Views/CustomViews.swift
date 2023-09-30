//
//  CustomViews.swift
//  Moonshot
//
//  Created by Adam Tokarski on 30/09/2023.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
    }
}

struct BottomText: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.white.opacity(0.5))
    }
}

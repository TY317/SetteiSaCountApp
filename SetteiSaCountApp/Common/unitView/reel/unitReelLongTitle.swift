//
//  unitReelLongTitle.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct unitReelLongTitle: View {
    var titleText: String
    var titleFont: Font = .title2
    var titleHeight: CGFloat = 30
    var titleMaxWidth: CGFloat = 375
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: self.titleHeight)
                .frame(maxWidth: self.titleMaxWidth)
                .foregroundStyle(Color.columnTitle)
            Text(self.titleText)
                .font(self.titleFont)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    unitReelLongTitle(
        titleText: "チャンス目"
    )
}

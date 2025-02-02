//
//  unitResultHanrei.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/25.
//

import SwiftUI

struct unitResultHanrei: View {
    var rectangleColor: Color = .grayBack
    var rectangleWidth: CGFloat = 30
    var rectangleheight: CGFloat = 20
    var rectangleCornerRadius: CGFloat = 5
    var textBody: String = "：自分のプレイデータのみ"
    var textColor: Color = .secondary
    var textFont: Font = .footnote
    var spacerBool: Bool = true
    
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(self.rectangleColor)
                .frame(width: self.rectangleWidth, height: self.rectangleheight)
                .cornerRadius(self.rectangleCornerRadius)
            Text(self.textBody)
                .foregroundStyle(self.textColor)
                .font(self.textFont)
            if self.spacerBool {
                Spacer()
            }
        }
    }
}

#Preview {
    unitResultHanrei()
}

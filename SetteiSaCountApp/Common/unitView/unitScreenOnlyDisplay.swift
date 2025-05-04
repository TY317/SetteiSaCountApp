//
//  unitScreenOnlyDisplay.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/02.
//

import SwiftUI

struct unitScreenOnlyDisplay: View {
    var image: Image
    var upperBeltText: String = ""
    var upperBeltFont: Font = .body
    var upperBeltBool: Bool = true
    var upperBeltHeight: CGFloat = 20
    var upperBeltColor: Color = .white
    var upperBeltTextColor: Color = .black
    var lowerBeltText: String = ""
    var lowerBeltFont: Font = .body
    var lowerBeltBool: Bool = true
    var lowerBeltHeight: CGFloat = 20
    var lowerBeltColor: Color = .white
    var lowerBeltTextColor: Color = .black
    var body: some View {
        VStack(spacing: 0) {
            // //// 上の帯
            if self.upperBeltBool {
                ZStack {
                    Rectangle()
                        .frame(height: self.upperBeltHeight)
                        .foregroundStyle(self.upperBeltColor)
                    Text(self.upperBeltText)
                        .font(self.upperBeltFont)
                        .fontWeight(.bold)
                        .foregroundStyle(self.upperBeltTextColor)
                }
            }
            // //// イメージ
            self.image
                .resizable()
                .scaledToFit()
            
            // //// 下の帯
            if self.lowerBeltBool {
                ZStack {
                    Rectangle()
                        .frame(height: self.lowerBeltHeight)
                        .foregroundStyle(self.lowerBeltColor)
                    Text(self.lowerBeltText)
                        .font(self.lowerBeltFont)
                        .fontWeight(.bold)
                        .foregroundStyle(self.lowerBeltTextColor)
                }
            }
        }
//        .frame(height: 120)
    }
}

#Preview {
    unitScreenOnlyDisplay(
        image: Image("kaijiTonegawaRushDefault1"),
        upperBeltText: "パターン1",
        lowerBeltText: "デフォルト"
    )
//    .frame(height: 120)
}

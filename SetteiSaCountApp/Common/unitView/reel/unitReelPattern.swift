//
//  unitReelPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct unitReelPattern<Left: View, Center: View, Right: View>: View {
//    var titleHeight: CGFloat = 30
    var titleText: String?
    var titleFont: Font = .title2
    var leftReel: Left
    var centerReel: Center
    var rightReel: Right
    var titleHeight: CGFloat = 30
    let titleReelSpacing: CGFloat = 7
    var body: some View {
        VStack(spacing: self.titleReelSpacing) {
            if let titleText = self.titleText {
                // タイトル部分
                ZStack {
                    Rectangle()
                        .frame(height: self.titleHeight)
                        .frame(maxWidth: 180)
                        .foregroundStyle(Color.columnTitle)
                    Text(titleText)
                        .font(self.titleFont)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                }
            }
            
            // //// リール部分
            HStack(spacing: 0) {
                self.leftReel
                self.centerReel
                self.rightReel
            }
        }
    }
}

#Preview {
    unitReelPattern(
        titleText: "弱チェリー",
        leftReel: unitReelColumn(
            upper: unitReelReplay(),
            middle: unitReelBar(),
            lower: unitReelText(textBody: "🍒")
        ),
        centerReel: unitReelAny(),
        rightReel: unitReelColumn(
            upper: unitReelDefault(),
            middle: unitReelReplay(),
            lower: unitReelDefault()
        )
    )
}

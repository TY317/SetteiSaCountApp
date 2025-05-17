//
//  sbjTablePinchPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/17.
//

import SwiftUI

struct sbjTablePinchPattern: View {
    var body: some View {
        VStack {
            unitReelPattern(
                titleText: "ピンチ目",
                leftReel: unitReelColumn(
                    upper: unitReelText(textBody: "🔔"),
                    middle: unitReelText(textBody: "7",textColor: .blue),
                    lower: unitReelReplay()
                ),
                centerReel: unitReelColumn(
                    upper: unitReelDefault(),
                    middle: unitReelText(textBody: "🍒"),
                    lower: unitReelDefault()
                ),
                rightReel: unitReelColumn(
                    upper: unitReelDefault(),
                    middle: unitReelDefault(),
                    lower: unitReelText(textBody: "🔔")
                )
            )
            Text("右下がりに🔔・🍒・🔔が停止")
        }
    }
}

#Preview {
    sbjTablePinchPattern()
}

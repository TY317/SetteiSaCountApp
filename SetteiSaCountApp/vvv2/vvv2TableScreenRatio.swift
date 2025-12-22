//
//  vvv2TableScreenRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/22.
//

import SwiftUI

struct vvv2TableScreenRatio: View {
    @ObservedObject var vvv2: Vvv2
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "奇数＆高設定示唆 弱",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let maxWidth: CGFloat = 76
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.lowerBeltTextList,
                    contentFont: .headline,
                )
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: [
                        vvv2.ratioScreenDefault[0],
                        vvv2.ratioScreenBlue1[0],
                        vvv2.ratioScreenBlue2[0],
                        vvv2.ratioScreenRed1[0],
                        vvv2.ratioScreenRed2[0],
                        vvv2.ratioScreenPurple[0],
                        vvv2.ratioScreenSilver[0],
                        vvv2.ratioScreenGold[0],
                    ]
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: [
                        vvv2.ratioScreenDefault[1],
                        vvv2.ratioScreenBlue1[1],
                        vvv2.ratioScreenBlue2[1],
                        vvv2.ratioScreenRed1[1],
                        vvv2.ratioScreenRed2[1],
                        vvv2.ratioScreenPurple[1],
                        vvv2.ratioScreenSilver[1],
                        vvv2.ratioScreenGold[1],
                    ]
                )
                
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.lowerBeltTextList,
                    contentFont: .headline,
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: [
                        vvv2.ratioScreenDefault[2],
                        vvv2.ratioScreenBlue1[2],
                        vvv2.ratioScreenBlue2[2],
                        vvv2.ratioScreenRed1[2],
                        vvv2.ratioScreenRed2[2],
                        vvv2.ratioScreenPurple[2],
                        vvv2.ratioScreenSilver[2],
                        vvv2.ratioScreenGold[2],
                    ],
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: [
                        vvv2.ratioScreenDefault[3],
                        vvv2.ratioScreenBlue1[3],
                        vvv2.ratioScreenBlue2[3],
                        vvv2.ratioScreenRed1[3],
                        vvv2.ratioScreenRed2[3],
                        vvv2.ratioScreenPurple[3],
                        vvv2.ratioScreenSilver[3],
                        vvv2.ratioScreenGold[3],
                    ],
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: [
                        vvv2.ratioScreenDefault[4],
                        vvv2.ratioScreenBlue1[4],
                        vvv2.ratioScreenBlue2[4],
                        vvv2.ratioScreenRed1[4],
                        vvv2.ratioScreenRed2[4],
                        vvv2.ratioScreenPurple[4],
                        vvv2.ratioScreenSilver[4],
                        vvv2.ratioScreenGold[4],
                    ],
                    maxWidth: self.maxWidth,
                )
            }
        }
    }
}

#Preview {
    vvv2TableScreenRatio(
        vvv2: Vvv2(),
    )
    .padding(.horizontal)
}

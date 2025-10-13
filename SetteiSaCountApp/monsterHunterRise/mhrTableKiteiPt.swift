//
//  mhrTableKiteiPt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/15.
//

import SwiftUI

struct mhrTableKiteiPt: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "モードA",
                        "モードB",
                        "モードC",
                        "モードD"
                    ],
                    maxWidth: 70,
                    contentFont: .subheadline
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "百の位が偶数でクエストに期待",
                        "百の位が奇数でクエストに期待",
                        "百の位が偶数でクエストに期待",
                        "100Ptでクエストに期待"
                    ],
                    maxWidth: 300,
                    contentFont: .subheadline
                )
                unitTableString(
                    columTitle: "天井",
                    stringList: [
                        "600Pt",
                        "500Pt",
                        "600Pt",
                        "100Pt"
                    ],
                    maxWidth: 70,
                    contentFont: .subheadline
                )
            }
            .padding(.bottom)
            Text("[モードごとのゾーン期待度]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "ゾーン",
                    stringList: [
                        "100Pt",
                        "200Pt",
                        "300Pt",
                        "400Pt",
                        "500Pt",
                        "600Pt"
                    ],
                    titleFont: .body,
                    contentFont: .body
                )
                unitTablePercent(
                    columTitle: "モードA",
                    percentList: [0.8,30.1,0.4,30.1,0.4,38.2],
                    numberofDicimal: 1,
                )
//                unitTableString(
//                    columTitle: "モードA",
//                    stringList: [
//                        "▲",
//                        "◯",
//                        "▲",
//                        "◯",
//                        "▲",
//                        "天井"
//                    ],
//                    titleFont: .body,
//                    contentFont: .body
//                )
                unitTablePercent(
                    columTitle: "モードB",
                    percentList: [0.8,0.4,43.4,0.4,55.0,0],
                    numberofDicimal: 1,
                    colorList: [.tableBlue,.white,.tableBlue,.white,.tableBlue,.gray]
                )
//                unitTableString(
//                    columTitle: "モードB",
//                    stringList: [
//                        "▲",
//                        "▲",
//                        "◎",
//                        "▲",
//                        "天井",
//                        "-"
//                    ],
//                    titleFont: .body,
//                    contentFont: .body
//                )
                unitTablePercent(
                    columTitle: "モードC",
                    percentList: [0.8,28.9,6.3,28.9,6.3,28.8],
                    numberofDicimal: 1,
                )
//                unitTableString(
//                    columTitle: "モードC",
//                    stringList: [
//                        "▲",
//                        "◯",
//                        "△",
//                        "◯",
//                        "△",
//                        "天井"
//                    ],
//                    titleFont: .body,
//                    contentFont: .body
//                )
                unitTablePercent(
                    columTitle: "モードD",
                    percentList: [100,0,0,0,0,0],
                    numberofDicimal: 0,
                    colorList: [.tableBlue,.gray,.gray,.gray,.gray,.gray,]
                )
//                unitTableString(
//                    columTitle: "モードD",
//                    stringList: [
//                        "天井",
//                        "-",
//                        "-",
//                        "-",
//                        "-",
//                        "-"
//                    ],
//                    titleFont: .body,
//                    contentFont: .body
//                )
            }
            Text("期待度：◎ > ◯ > △ > ▲")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    mhrTableKiteiPt()
        .padding(.horizontal)
}

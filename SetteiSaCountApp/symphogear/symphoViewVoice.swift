//
//  symphoViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/18.
//

import SwiftUI

struct symphoViewVoice: View {
    var body: some View {
//        NavigationView {
            List {
                Text("AT終了画面で十字キーの下を押すと設定示唆ボイス")
                Text("上ボタンを押すとモード示唆アイコン")
                Text("どちらか片方しか確認できない")
//                Image("symphoVoice1")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "響",
                            "翼",
                            "クリス",
                            "調",
                            "切歌",
                            "未来",
                            "全員",
                        ],
                        maxWidth: 60,
                        lineList: [4,1,1,1,1,2,1],
                        contentFont: .body,
                        colorList: [
                            .white,
                            .tableBlue,
                            .white,
                            .tableBlue,
                            .white,
                            .tableBlue,
                            .white,
                        ]
                    )
                    unitTableString(
                        columTitle: "ボイス",
                        stringList: [
                            "結局わがままなんだよね",
                            "簡単には離さないよ",
                            "急いで戻らなきゃ",
                            "私が今を守ってみせますね",
                            "壁呼ばわりとは不躾な・・剣だ",
                            "どうなってやがる",
                            "何もできないもどかしさ",
                            "次があれば必ず",
                            "頑張るしかないわね",
                            "いつかきっと、嫌なことを全部解決してくれるんだから",
                            "パンパカパーン！デース！",
                        ],
                        contentFont: .subheadline,
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "ATモード：響以上",
                            "設定1 否定",
                            "設定2 否定",
                            "設定4 否定",
                            "ATモード：翼示唆",
                            "ATモード：クリス示唆",
                            "奇数示唆 弱",
                            "偶数示唆 弱",
                            "ATモード：ユニゾン以上",
                            "設定4 以上濃厚",
                            "設定6 濃厚",
                        ],
                        contentFont: .subheadline,
                    )
                }
                VStack {
                    Text("[調・切歌振り分け]")
                        .font(.title2)
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "奇数",
                                "偶数",
                            ]
                        )
                        unitTablePercent(
                            columTitle: "調",
                            percentList: [53,47]
                        )
                        unitTablePercent(
                            columTitle: "切歌",
                            percentList: [47,53]
                        )
                    }
                }
//                Image("symphoVoice2")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "シンフォギア 正義の歌",
                screenClass: screenClass
            )
        }
            .navigationTitle("AT終了後のボイス")
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .navigationTitle("AT終了後のボイス")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    symphoViewVoice()
}

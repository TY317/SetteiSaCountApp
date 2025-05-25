//
//  toloveru87TablePtSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/24.
//

import SwiftUI

struct toloveru87TablePtSisa: View {
    var body: some View {
        VStack {
            GroupBox {
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // 左or中
                        unitScreenOnlyDisplay(
                            image: Image("toloveru87EyeCatch1"),
                            upperBeltText: "ララ＆春菜",
                            lowerBeltText: "左or中 pt中〜大!?"
                        )
                        // 右
                        unitScreenOnlyDisplay(
                            image: Image("toloveru87EyeCatch2"),
                            upperBeltText: "モモ",
                            lowerBeltText: "右 pt中〜大!?"
                        )
                        // 左or中 140pt
                        unitScreenOnlyDisplay(
                            image: Image("toloveru87EyeCatch3"),
                            upperBeltText: "美柑＆セリーヌ",
                            lowerBeltText: "左or中 140pt以上!?",
                            lowerBeltFont: .subheadline
                        )
                        // 右
                        unitScreenOnlyDisplay(
                            image: Image("toloveru87EyeCatch4"),
                            upperBeltText: "メア＆ヤミ",
                            lowerBeltText: "右 140pt以上!?"
                        )
                        // 右
                        unitScreenOnlyDisplay(
                            image: Image("toloveru87EyeCatch5"),
                            upperBeltText: "ティアーユ＆ヤミ",
                            lowerBeltText: "100G以内当選示唆"
                        )
                        // 右
                        unitScreenOnlyDisplay(
                            image: Image("toloveru87EyeCatch6"),
                            upperBeltText: "女性4人",
                            lowerBeltText: "150G以内当選濃厚"
                        )
                        // 右
                        unitScreenOnlyDisplay(
                            image: Image("toloveru87EyeCatch7"),
                            upperBeltText: "白雪姫",
                            lowerBeltText: "ﾄﾗﾝｽﾎﾟｲﾝﾄMAX示唆"
                        )
                    }
                }
                .frame(height: 120)
            } label: {
                Text("[アイキャッチ]")
            }
            
            GroupBox {
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "ピンク",
                            "緑",
                            "紫"
                        ],
                        maxWidth: 100
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "左 140pt以上!?",
                            "中 140pt以上!?",
                            "右 140pt以上!?"
                        ],
                        maxWidth: 200
                    )
                }
            } label: {
                Text("[会話演出の文字色]")
            }
            
            GroupBox {
                HStack(spacing:0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "怪",
                            "近"
                        ],
                        maxWidth: 100
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "蓄積量 中〜大!?",
                            "140pt以上!?"
                        ],
                        maxWidth: 200
                    )
                }
            } label: {
                Text("[美柑看板の文字]")
            }

        }
    }
}

#Preview {
    toloveru87TablePtSisa()
        .padding(.horizontal)
}

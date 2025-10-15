//
//  toreveViewStartScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/14.
//

import SwiftUI

struct toreveViewStartScreen: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var toreve: Toreve
    
    var body: some View {
        List {
            Section {
                // 説明
                Text("・主に東卍アタックから東卍ラッシュへ戻る際に出現")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// 示唆の表
                VStack {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "白背景",
                                "緑背景",
                                "キャラ\n集合",
                            ],
                            maxWidth: 50,
                            lineList: [9,7,4],
                            contentFont: .body,
                            colorList: [.white, .tableGreen, .tableBlue],
                        )
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "武道(金髪)",
                                "千冬",
                                "三ツ谷",
                                "ドラケン",
                                "マイキー",
                                "3人",
                                "武道(黒髪)",
                                "稀咲",
                                "三ツ谷",
                                "ドラケン",
                                "マイキー",
                                "一虎",
                                "場地",
                                "パターン1",
                                "パターン2",
                                "パターン3",
                                "パターン4",
                            ],
                            maxWidth: 80,
                            lineList: [1,1,1,1,1,2,1,1,1,1,1,2,2],
                            contentFont: .subheadline,
                            colorList: [.white,.white,.white,.white,.white,.white,.white,.white,.tableGreen,.tableGreen,.tableGreen,.tableGreen,.tableGreen,.tableBlue,.tableBlue,.tableBlue,.tableBlue,]
                        )
                        unitTableString(
                            columTitle: "示唆",
                            stringList: [
                                "アタックレベル1/4/7時",
                                "アタックレベル2/5時",
                                "アタックレベル3/6時",
                                "ドラケンヒートアップ獲得時",
                                "マイキーヒートアップ獲得時",
                                "ドラケン＆マイキーヒートアップ獲得時",
                                "リベンジチャンス取得時",
                                "特殊モード濃厚",
                                "通常B以上濃厚",
                                "チャンス以上濃厚",
                                "天国濃厚",
                                "天国濃厚\n設定4 以上濃厚",
                                "天国濃厚\n設定6 濃厚",
                                "高設定示唆 弱",
                                "高設定示唆 強",
                                "設定2 以上濃厚",
                                "設定6 濃厚",
                            ],
                            maxWidth: 250,
                            lineList: [1,1,1,1,1,2,1,1,1,1,1,2,2],
                            contentFont: .subheadline,
                            colorList: [.white,.white,.white,.white,.white,.white,.white,.white,.tableGreen,.tableGreen,.tableGreen,.tableGreen,.tableGreen,.tableBlue,.tableBlue,.tableBlue,.tableBlue,]
                        )
                    }
                    Text("※ キャラ集合は上位AT中も同様の示唆")
                        .foregroundStyle(Color.secondary)
//                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 高設定示唆の絵
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // パターン1
                        unitScreenOnlyDisplay(
                            image: Image("toreveStartScreen1"),
                            upperBeltText: "パターン1",
                            lowerBeltText: "高設定示唆 弱",
                        )
                        // パターン2
                        unitScreenOnlyDisplay(
                            image: Image("toreveStartScreen2"),
                            upperBeltText: "パターン2",
                            lowerBeltText: "高設定示唆 強",
                        )
                        // パターン3
                        unitScreenOnlyDisplay(
                            image: Image("toreveStartScreen3"),
                            upperBeltText: "パターン3",
                            lowerBeltText: "設定2 以上濃厚",
                        )
                        // パターン4
                        unitScreenOnlyDisplay(
                            image: Image("toreveStartScreen4"),
                            upperBeltText: "パターン4",
                            lowerBeltText: "設定6 濃厚",
                        )
                    }
                }
                .frame(height: 120)
            } header: {
                Text("ラウンド開始画面")
            }
            
            // //// エピソード種類
            Section {
                Text("設定を示唆するエピソードあり")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "Zero",
                            "In those days",
                            "Man-crush",
                        ],
                        lineList: [2,2,2],
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "天国濃厚\n奇数＆高設定示唆",
                            "天国濃厚\n偶数＆高設定示唆",
                            "天国濃厚\n設定4 以上濃厚",
                        ],
                        lineList: [2,2,2],
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } header: {
                Text("エピソード種類")
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver391.toreveMenuStartScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("東卍ラッシュ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    toreveViewStartScreen(
//        ver391: Ver391(),
        toreve: Toreve(),
    )
}

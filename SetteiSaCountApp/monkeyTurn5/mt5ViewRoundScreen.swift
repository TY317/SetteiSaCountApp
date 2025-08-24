//
//  mt5ViewRoundScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/27.
//

import SwiftUI

struct mt5ViewRoundScreen: View {
//    @ObservedObject var ver370: Ver370
    @ObservedObject var mt5: Mt5
    let sinarioList: [String] = [
        "駆け出し",
        "遅咲き",
        "関東ガマシ",
        "ダービーキング",
        "ツケマイ巧者",
        "ギャンブラー",
        "紅一点",
        "洞口スペシャル",
        "艇界のヒロイン",
        "一般戦の鬼",
        "愛知の巨人",
        "最強のB2",
        "逆襲の艇王",
        "艇王",
    ]
    
    var body: some View {
        List {
            // //// シナリオ選択率
            Section {
                Text("設定差はありません\n稼働を楽しむための参考情報としてご利用ください")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                // 通常
                unitLinkButtonViewBuilder(sheetTitle: "通常時", linkText: "通常時") {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: self.sinarioList,
                        )
                        unitTablePercent(
                            columTitle: "シナリオ選択率",
                            percentList: [13.9,11.1,13.2,12.4,11.7,5.2,5.5,5.2,10.5,5.2,3.5,1.4,0.6,0.6],
                            numberofDicimal: 1,
                        )
                    }
                }
//                .popoverTip(tipVer370Mt5SinarioRatio())
                // 洞口滞在時
                unitLinkButtonViewBuilder(sheetTitle: "ライバルモード洞口滞在時", linkText: "ライバルモード洞口滞在時") {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: self.sinarioList,
                        )
                        unitTablePercent(
                            columTitle: "シナリオ選択率",
                            percentList: [0,0,0,0,0,18.8,18.8,25,0,18.8,14.1,2.1,0.6,1.6],
                            numberofDicimal: 1,
                        )
                    }
                }
            } header: {
                Text("シナリオ選択率")
            }
            
            Image("mt5RoundScreen")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver370.mt5MenuRoundScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンキーターン5",
                screenClass: screenClass
            )
        }
        .navigationTitle("ラウンド開始画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    mt5ViewRoundScreen(
//        ver370: Ver370(),
        mt5: Mt5(),
    )
}

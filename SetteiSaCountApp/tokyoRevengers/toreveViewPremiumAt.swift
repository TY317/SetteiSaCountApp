//
//  toreveViewPremiumAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/06.
//

import SwiftUI

struct toreveViewPremiumAt: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var toreve: Toreve
    @State var selectedKind: String = "リベンジチャンス"
    let kindList: [String] = ["リベンジチャンス", "天上天下唯我独尊"]
    let maxWidth: CGFloat = 100
    var body: some View {
        List {
            Section {
                // 注意事項
                VStack(alignment: .leading) {
                    Text("・突破時のフラグに応じて黒い衝動突入期待度が変化")
                    Text("・ハズレ、ベル、リプレイでの突破からの突入率に設定差あり")
                    Text("・ただし最終ゲームでレア役以外が成立して成功告知が行われた場合は、最終ゲームのフラグ不問抽選等の影響で下記の数値通りにとはいかないのでご注意ください")
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                
                // セグメントピッカー
                Picker("", selection: self.$selectedKind) {
                    ForEach(self.kindList, id: \.self) { kind in
                        Text(kind)
                    }
                }
                .pickerStyle(.segmented)
                .popoverTip(tipVer3110ToreveBurst())
                
                // リベンジチャンス
                if self.selectedKind == self.kindList[0] {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "ハズレ",
                            percentList: [50,-1,-1,-1,-1,60],
                            maxWidth: self.maxWidth,
                        )
                        unitTablePercent(
                            columTitle: "ベル・リプレイ",
                            percentList: [4,-1,-1,-1,-1,16],
//                            maxWidth: self.maxWidth,
                        )
                    }
                }
                
                // 天上天下
                else {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "ハズレ",
                            percentList: [12,-1,-1,-1,-1,28],
                            maxWidth: self.maxWidth,
                        )
                        unitTablePercent(
                            columTitle: "ベル・リプレイ",
                            percentList: [2,-1,-1,-1,-1,5],
//                            maxWidth: self.maxWidth,
                        )
                    }
                }
//                VStack(alignment: .leading) {
//                    Text("・天上天下唯我独尊 成功時の一部で当選")
//                    Text("・当選率に設定差あり")
//                    Text("・レア役以外で当選すれば高設定の期待大!?")
//                }
            } header: {
                Text("黒い衝動")
            }
            
//            unitAdBannerMediumRectangle()
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.toreveMenuBurstBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("東卍ラッシュバースト")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    toreveViewPremiumAt(
        toreve: Toreve(),
    )
    .environmentObject(commonVar())
}

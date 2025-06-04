//
//  toloveru87ViewHarlem.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import SwiftUI

struct toloveru87ViewHarlem: View {
    @ObservedObject var toloveru87: Toloveru87
    @State var isShowAlert = false
    
    var body: some View {
        List {
            // //// ボーナス3連での当選
            Section {
                unitLinkButton(
                    title: "ボーナス3連での上位当選について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "3連での上位当選について",
                            textBody1: "・3連での上位当選率が前作よりも上昇",
                            textBody2: "・設定2のみ数値公表あり",
//                            image1: Image("toloveruHarlem3renHit")
                            tableView: AnyView(toloveru87Table3renHarlem())
                        )
                    )
                )
            } header: {
                Text("ボーナス3連での上位当選")
            }
            // //// ウィスパー比率
            Section {
                // //// カウントボタン＆結果表示
                HStack {
                    unitCountButtonVerticalWithoutRatio(
                        title: "\nウィスパー",
                        count: $toloveru87.harlemWhisperCount,
                        color: .personalSummerLightPurple,
                        minusBool: $toloveru87.minusCheck
                    )
                    unitCountButtonVerticalWithoutRatio(
                        title: "愛すぷ\nラッシュ",
                        count: $toloveru87.harlemAisplush,
                        color: .personalSummerLightRed,
                        minusBool: $toloveru87.minusCheck
                    )
                    unitResultRatioPercent2Line(
                        title: "ウィスパー\n選択率",
                        color: .grayBack,
                        count: $toloveru87.harlemWhisperCount,
                        bigNumber: $toloveru87.harlemCountSum,
                        numberofDicimal: 0
                    )
                        .padding(.vertical)
                }
                // 参考情報リンク
                unitLinkButton(
                    title: "ウィスパー選択率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ウィスパー選択率",
                            textBody1: "・ハーレムモード中の枚数選択ゾーンでウィスパー演出が選択される確率に設定差あり",
//                            image1: Image("toloveruHarlemWhisper")
                            tableView: AnyView(toloveruTableWhisper())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(toloveru87View95Ci(
                    toloveru87: toloveru87, selection: 1)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("ウィスパー選択率")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ToLOVEるver8.7",
                screenClass: screenClass
            )
        }
        .navigationTitle("ハーレムモード")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $toloveru87.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: toloveru87.resetHarlem)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    toloveru87ViewHarlem(
        toloveru87: Toloveru87()
    )
}

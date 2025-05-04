//
//  toloveruViewHarlem.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/04.
//

import SwiftUI

struct toloveruViewHarlem: View {
//    @ObservedObject var toloveru = Toloveru()
    @ObservedObject var toloveru: Toloveru
    @State var isShowAlert = false
    
    var body: some View {
//        NavigationView {
            List {
                // //// ボーナス3連での当選
                Section {
                    unitLinkButton(title: "ボーナス3連での上位当選について", exview: AnyView(unitExView5body2image(title: "3連当選についての噂", textBody1: "・高設定ほどボーナス3連目での上位当選しにくいとの噂あり。設定6は数%程度との噂もあり。3連での上位当選が複数回確認されたら黄信号かも。", textBody2: "・設定2のみ数値公表あり（下図参照）", image1: Image("toloveruHarlem3renHit"))))
                } header: {
                    Text("ボーナス3連での上位当選")
                }
                // //// ウィスパー比率
                Section {
                    // //// カウントボタン＆結果表示
                    HStack {
                        unitCountButtonVerticalWithoutRatio(title: "\nウィスパー", count: $toloveru.harlemWhisperCount, color: .personalSummerLightPurple, minusBool: $toloveru.minusCheck)
                        unitCountButtonVerticalWithoutRatio(title: "愛すぷ\nラッシュ", count: $toloveru.harlemAisplush, color: .personalSummerLightRed, minusBool: $toloveru.minusCheck)
                        unitResultRatioPercent2Line(title: "ウィスパー\n選択率", color: .grayBack, count: $toloveru.harlemWhisperCount, bigNumber: $toloveru.harlemCountSum, numberofDicimal: 0)
                            .padding(.vertical)
                    }
                    // 参考情報リンク
                    unitLinkButton(title: "ウィスパー選択率について", exview: AnyView(unitExView5body2image(title: "ウィスパー選択率", textBody1: "・ハーレムモード中の枚数選択ゾーンでウィスパー演出が選択される確率に設定差あり", image1: Image("toloveruHarlemWhisper"))))
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(Ci95view: AnyView(toloveruView95Ci(toloveru: toloveru, selection: 1)))
                        .popoverTip(tipUnitButtonLink95Ci())
                } header: {
                    Text("ウィスパー選択率")
                }
            }
            .navigationTitle("ハーレムモード")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $toloveru.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: toloveru.resetHarlem)
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("ハーレムモード")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $toloveru.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: toloveru.resetHarlem)
//                        .popoverTip(tipUnitButtonReset())
//                }
//            }
//        }
    }
}

#Preview {
    toloveruViewHarlem(toloveru: Toloveru())
}

//
//  mt5ViewMedal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/22.
//

import SwiftUI
import TipKit

struct mt5ViewMedal: View {
//    @ObservedObject var mt5 = Mt5()
    @ObservedObject var mt5: Mt5
    @State var isShowAlert = false
    
    var body: some View {
//        NavigationView {
            List {
                Section {
                    HStack {
                        // 青メダルのカウント
                        unitCountButtonVerticalPercent(title: "青メダル", count: $mt5.blueMedalCount, color: .personalSummerLightBlue, bigNumber: $mt5.atCount, numberofDicimal: 1, minusBool: $mt5.minusCheck)
                        // 黄メダルのカウント
                        unitCountButtonVerticalPercent(title: "黄メダル", count: $mt5.yellowMedalCount, color: .personalSpringLightYellow, bigNumber: $mt5.atCount, numberofDicimal: 1, minusBool: $mt5.minusCheck, flushColor: Color.yellow)
                        // 黒メダルのカウント
                        unitCountButtonVerticalPercent(title: "黒メダル", count: $mt5.blackMedalCount, color: .gray, bigNumber: $mt5.atCount, numberofDicimal: 1, minusBool: $mt5.minusCheck)
                    }
                    // 参考情報リンク
                    unitLinkButton(title: "メダルについて", exview: AnyView(mt5ExViewMedal()))
                        .popoverTip(mt5TipBlackMedalRatioAdd())
                    unitLinkButton(title: "トロフィーについて", exview: AnyView(mt5ExViewTrofy()))
                    // 95%信頼区間グラフ
                    unitNaviLink95Ci(Ci95view: AnyView(mt5View95Ci(mt5: mt5, selection: 6)))
                        .popoverTip(tipUnitButtonLink95Ci())
                } header: {
                    Text("メダルのカウント")
                }
            }
            .navigationTitle("AT終了後のメダル")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $mt5.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: mt5.resetMedal, message: "このページのデータをリセットします")
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("AT終了後のメダル")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $mt5.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: mt5.resetMedal, message: "このページのデータをリセットします")
//                }
//            }
//        }
    }
}


// //////////////////////////
// ビュー：参考情報　メダルについて
// //////////////////////////
struct mt5ExViewMedal: View {
    var body: some View {
        unitExView5body2image(title: "メダルについて", textBody1: "・黄色メダル以上は示唆としてかなり大事らしい", textBody2: "・黄メダル30%以上が欲しい", textBody3: "・AT9回で青2回、黄2回で若干弱い というくらいの感触らしい", image1: Image("mt5Medal"), image2: Image("mt5BlackMedal"))
    }
}
// //////////////////
// Tip：黒メダル出現率の追加
// //////////////////
struct mt5TipBlackMedalRatioAdd: Tip {
    var title: Text {
        Text("情報追加")
    }
    var message: Text? {
        Text("黒メダルの出現率を追加")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// //////////////////////////
// ビュー：参考情報　トロフィーについて
// //////////////////////////
struct mt5ExViewTrofy: View {
    var body: some View {
        unitExView5body2image(title: "トロフィーについて", image1: Image("mt5Trofy"))
    }
}

#Preview {
    mt5ViewMedal(mt5: Mt5())
}

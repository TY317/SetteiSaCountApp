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
//    @ObservedObject var ver370: Ver370
    @ObservedObject var mt5: Mt5
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   //
    @State var isShowAlert = false
    @EnvironmentObject var common: commonVar
    
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
                    
                    // 青・黄比率
                    VStack {
                        Text("[青・黄比率]")
                        HStack {
                            // 青比率
                            unitResultRatioPercent2Line(
                                title: "青",
                                count: $mt5.blueMedalCount,
                                bigNumber: $mt5.medalCountBYSum,
                                numberofDicimal: 0,
                                spacerBool: false,
                            )
                            
                            // 黄比率
                            unitResultRatioPercent2Line(
                                title: "黄",
                                count: $mt5.yellowMedalCount,
                                bigNumber: $mt5.medalCountBYSum,
                                numberofDicimal: 0,
                                spacerBool: false,
                            )
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .popoverTip(tipVer430Mt5Medal())
                    // 参考情報リンク
                    unitLinkButton(title: "メダルについて", exview: AnyView(mt5ExViewMedal()))
                    unitLinkButtonViewBuilder(sheetTitle: "青・黄比率") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,4,5,6])
                            unitTablePercent(
                                columTitle: "青",
                                percentList: mt5.ratioMedalBYBlue
                            )
                            unitTablePercent(
                                columTitle: "黄",
                                percentList: mt5.ratioMedalBYYellow
                            )
                        }
                    }
                    unitLinkButton(title: "トロフィーについて", exview: AnyView(mt5ExViewTrofy()))
                    // 95%信頼区間グラフ
                    unitNaviLink95Ci(Ci95view: AnyView(mt5View95Ci(mt5: mt5, selection: 8)))
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        mt5ViewBayes(
//                            ver370: ver370,
                            mt5: mt5,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } header: {
                    Text("メダルのカウント")
                }
            }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mt5MenuMedalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンキーターン5",
                screenClass: screenClass
            )
        }
            .navigationTitle("AT終了後のメダル")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $mt5.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: mt5.resetMedal, message: "このページのデータをリセットします")
//                            .popoverTip(tipUnitButtonReset())
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
        unitExView5body2image(
            title: "メダルについて",
            textBody1: "・黄色メダル以上は示唆としてかなり大事らしい",
            textBody2: "・黄メダル30%以上が欲しい",
            textBody3: "・AT9回で青2回、黄2回で若干弱い というくらいの感触らしい",
//            image1: Image("mt5Medal"),
//            image2: Image("mt5BlackMedal")
            tableView: AnyView(mt5TableMedal())
        )
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
        unitExView5body2image(
            title: "トロフィーについて",
//            image1: Image("mt5Trofy")
            tableView: AnyView(mt5TableTrophy())
        )
    }
}

#Preview {
    mt5ViewMedal(
//        ver370: Ver370(),
        mt5: Mt5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

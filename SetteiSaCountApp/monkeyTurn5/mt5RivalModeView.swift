//
//  mt5RivalModeView.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/22.
//

import SwiftUI

struct mt5RivalModeView: View {
//    @ObservedObject var mt5 = Mt5()
    @ObservedObject var ver370: Ver370
    @ObservedObject var mt5: Mt5
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   //
    @State var isShowAlert = false
    
    var body: some View {
//        NavigationView {
            List {
                Section {
                    // //// カウントボタンの横並び
                    HStack {
                        // 蒲生カウントボタン
                        unitCountButtonVerticalPercent(title: "蒲生", count: $mt5.rivalGamoCount, color: .personalSummerLightRed, bigNumber: $mt5.atCountPlus1, numberofDicimal: 1, minusBool: $mt5.minusCheck)
                        // 浜岡カウントボタン
                        unitCountButtonVerticalPercent(title: "浜岡", count: $mt5.rivalHamaokaCount, color: .personalSpringLightYellow, bigNumber: $mt5.atCountPlus1, numberofDicimal: 1, minusBool: $mt5.minusCheck, flushColor: Color.yellow)
                        // 榎木カウントボタン
                        unitCountButtonVerticalPercent(title: "榎木", count: $mt5.rivalEnokiCount, color: .personalSummerLightPurple, bigNumber: $mt5.atCountPlus1, numberofDicimal: 1, minusBool: $mt5.minusCheck)
                    }
                    // 参考情報へのリンク：ライバルモード
                    unitLinkButton(title: "ライバルモードについて", exview: AnyView(mt5ExViewRival()))
                    // 参考情報へのリンク：舟券での示唆
                    unitLinkButton(title: "舟券での示唆", exview: AnyView(mt5ExViewFnaken()))
                    // 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(Ci95view: AnyView(mt5View95Ci(mt5: mt5, selection: 3)))
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        mt5ViewBayes(
                            ver370: ver370,
                            mt5: mt5,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } header: {
                    Text("ライバルモードカウント")
                }
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンキーターン5",
                screenClass: screenClass
            )
        }
            .navigationTitle("ライバルモード")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $mt5.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: mt5.resetRival, message: "このページのデータをリセットします")
//                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("ライバルモード")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $mt5.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: mt5.resetRival, message: "このページのデータをリセットします")
//                }
//            }
//        }
    }
}


// ///////////////////////////
// ビュー：参考情報　ライバルモード
// ///////////////////////////
struct mt5ExViewRival: View {
    var body: some View {
        unitExView5body2image(title: "ライバルモードについて", textBody1: "・蒲生、浜岡、榎木のライバルモードに設定差あり", textBody2: "・示唆が出ず見抜けないことも多いため、参考程度。あまり気にしなくてもいい", image1: Image("mt5RivalModeAnalysis"),image2: Image("mt5RivalMode"))
    }
}


// ////////////////////////
// ビュー：参考情報　舟券示唆
// ////////////////////////
struct mt5ExViewFnaken: View {
    var body: some View {
        unitExView5body2image(
            title: "舟券での示唆",
//            image1: Image("mt5Funaken")
            tableView: AnyView(mt5TableFunaken())
        )
    }
}

#Preview {
    mt5RivalModeView(
        ver370: Ver370(),
        mt5: Mt5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}

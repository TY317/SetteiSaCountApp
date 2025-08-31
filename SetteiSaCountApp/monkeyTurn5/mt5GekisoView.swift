//
//  mt5GekisoView.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/22.
//

import SwiftUI

struct mt5GekisoView: View {
//    @ObservedObject var mt5 = Mt5()
//    @ObservedObject var ver370: Ver370
    @ObservedObject var mt5: Mt5
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   //
    @State var isShowAlert = false
    
    var body: some View {
//        NavigationView {
            List {
                Section {
                    HStack {
                        //波多野Aのカウントボタン
                        unitCountButtonVerticalPercent(title: "波多野A", count: $mt5.hatanoACount, color: .personalSummerLightBlue, bigNumber: $mt5.hatanoCountSum, numberofDicimal: 0, minusBool: $mt5.minusCheck)
                        // 波多野Bのカウントボタン
                        unitCountButtonVerticalPercent(title: "波多野B", count: $mt5.hatanoBCount, color: .personalSpringLightYellow, bigNumber: $mt5.hatanoCountSum, numberofDicimal: 0, minusBool: $mt5.minusCheck, flushColor: Color.yellow)
                    }
                    // 参考情報へのリンク
                    unitLinkButton(title: "激走チャージ後のセリフ", exview: AnyView(mt5ExViewGekiso()))
                    // 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(Ci95view: AnyView(mt5View95Ci(mt5: mt5, selection: 2)))
                    
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
                    Text("波多野A,Bのカウント")
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
            .navigationTitle("激走チャージ後のセリフ")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $mt5.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: mt5.resetGekiso, message: "このページのデータをリセットします")
//                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("激走チャージ後のセリフ")
//        .navigationBarTitleDisplayMode(.inline)
//        
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $mt5.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: mt5.resetGekiso, message: "このページのデータをリセットします")
//                }
//            }
//        }
    }
}


// /////////////////////////////
// ビュー：参考情報　激走チャージ後セリフ
// /////////////////////////////
struct mt5ExViewGekiso: View {
    var body: some View {
        unitExView5body2image(
            title: "激走チャージ後のセリフ",
            textBody1: "・サブ液晶をタッチして確認。設定示唆とモード示唆",
            textBody2: "・デフォルトの波多野A、Bの振り分けに設定差あるため、この2つはカウント。設定5はこれでかなり見抜けるらしい",
//            image1: Image("mt5GekisoHatano"),
//            image2: Image("mt5GekisoAll")
            tableView: AnyView(mt5TableGekisoVoice())
        )
    }
}

#Preview {
    mt5GekisoView(
//        ver370: Ver370(),
        mt5: Mt5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}

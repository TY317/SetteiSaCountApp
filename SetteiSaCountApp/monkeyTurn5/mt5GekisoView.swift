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
    @EnvironmentObject var common: commonVar
    @State var selectedItem: String = "弱🍒・🍉"
    let itemList: [String] = ["弱🍒・🍉", "弱チャンス目", "強チャンス目"]
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 6
    @State var lazyVGridCount: Int = 3
    
    var body: some View {
//        NavigationView {
            List {
                Section {
                    HStack {
                        //波多野Aのカウントボタン
                        unitCountButtonVerticalPercent(title: "波多野A\n(落ち着くんだ…)", count: $mt5.hatanoACount, color: .personalSummerLightBlue, bigNumber: $mt5.hatanoCountSum, numberofDicimal: 0, minusBool: $mt5.minusCheck)
                        // 波多野Bのカウントボタン
                        unitCountButtonVerticalPercent(title: "波多野B\n(この気配は…)", count: $mt5.hatanoBCount, color: .personalSpringLightYellow, bigNumber: $mt5.hatanoCountSum, numberofDicimal: 0, minusBool: $mt5.minusCheck, flushColor: Color.yellow)
                    }
                    // 参考情報へのリンク
                    unitLinkButton(title: "激走チャージ後のセリフ", exview: AnyView(mt5ExViewGekiso()))
                    // 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(Ci95view: AnyView(mt5View95Ci(mt5: mt5, selection: 2)))
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        mt5ViewBayes(
                            mt5: mt5,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } header: {
                    Text("波多野A,Bのカウント")
                }
                
                // レア役でのEXアイテム獲得率
                Section {
                    // セグメントピッカー
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.itemList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // カウントボタン横並び
                    HStack {
                        // 弱チェリー、スイカ
                        if self.selectedItem == self.itemList[0] {
                            // 弱チェリー
                            unitCountButtonWithoutRatioWithFunc(
                                title: "弱🍒",
                                count: $mt5.rareItemCountJakuCherry,
                                color: .personalSummerLightRed,
                                minusBool: $mt5.minusCheck) {
                                    mt5.rareItemJakuSumFunc()
                                }
                            // ボート
                            unitCountButtonWithoutRatioWithFunc(
                                title: "🍉",
                                count: $mt5.rareItemCountSuika,
                                color: .personalSummerLightGreen,
                                minusBool: $mt5.minusCheck) {
                                    mt5.rareItemJakuSumFunc()
                                }
                            // アイテム獲得
                            unitCountButtonWithoutRatioWithFunc(
                                title: "アイテム獲得",
                                count: $mt5.rareItemCountJakuRareHit,
                                color: .personalSummerLightBlue,
                                minusBool: $mt5.minusCheck) {
                                    mt5.rareItemJakuSumFunc()
                                }
                        }
                        
                        // 弱チャンス目
                        else if self.selectedItem == self.itemList[1] {
                            // 弱チャンス目
                            unitCountButtonWithoutRatioWithFunc(
                                title: "弱チャンス目",
                                count: $mt5.rareItemCountJakuChance,
                                color: .personalSummerLightPurple,
                                minusBool: $mt5.minusCheck) {
                                    mt5.rareItemJakuSumFunc()
                                }
                            // アイテム獲得
                            unitCountButtonWithoutRatioWithFunc(
                                title: "アイテム獲得",
                                count: $mt5.rareItemCountJakuChanceHit,
                                color: .personalSummerLightBlue,
                                minusBool: $mt5.minusCheck) {
                                    mt5.rareItemJakuSumFunc()
                                }
                        }
                        
                        // 強チャンス目
                        else {
                            // 強チャンス目
                            unitCountButtonWithoutRatioWithFunc(
                                title: "強チャンス目",
                                count: $mt5.rareItemCountKyoChance,
                                color: .purple,
                                minusBool: $mt5.minusCheck) {
                                    mt5.rareItemJakuSumFunc()
                                }
                            // アイテム獲得
                            unitCountButtonWithoutRatioWithFunc(
                                title: "アイテム獲得",
                                count: $mt5.rareItemCountKyoChanceHit,
                                color: .blue,
                                minusBool: $mt5.minusCheck) {
                                    mt5.rareItemJakuSumFunc()
                                }
                        }
                    }
                    
                    // 確率結果
                    HStack {
                        // 弱チェリー、スイカ
                        unitResultRatioPercent2Line(
                            title: "弱🍒・🍉",
                            count: $mt5.rareItemCountJakuRareHit,
                            bigNumber: $mt5.rareItemCountJakuRareSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // 弱チャンス目
                        unitResultRatioPercent2Line(
                            title: "弱チャンス目",
                            count: $mt5.rareItemCountJakuChanceHit,
                            bigNumber: $mt5.rareItemCountJakuChance,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // 強チャンス目
                        unitResultRatioPercent2Line(
                            title: "強チャンス目",
                            count: $mt5.rareItemCountKyoChanceHit,
                            bigNumber: $mt5.rareItemCountKyoChance,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                    
                    // 参考情報）アイテム獲得率
                    unitLinkButtonViewBuilder(sheetTitle: "アイテム獲得率") {
                        mt5TableRareItem(mt5: mt5)
                    }
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        mt5ViewBayes(
                            mt5: mt5,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } header: {
                    Text("レア役でのアイテム獲得率")
                }
                unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
            }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mt5MenuGekisoBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンキーターン5",
                screenClass: screenClass
            )
        }
        // //// 画面の向き情報の取得部分
        .applyOrientationHandling(
            orientation: self.$orientation,
            lastOrientation: self.$lastOrientation,
            scrollViewHeight: self.$scrollViewHeight,
            spaceHeight: self.$spaceHeight,
            lazyVGridCount: self.$lazyVGridCount,
            scrollViewHeightPortrait: self.scrollViewHeightPortrait,
            scrollViewHeightLandscape: self.scrollViewHeightLandscape,
            spaceHeightPortrait: self.spaceHeightPortrait,
            spaceHeightLandscape: self.spaceHeightLandscape,
            lazyVGridCountPortrait: self.lazyVGridCountPortrait,
            lazyVGridCountLandscape: self.lazyVGridCountLandscape
        )
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
    .environmentObject(commonVar())
}

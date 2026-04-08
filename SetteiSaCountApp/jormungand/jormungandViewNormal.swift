//
//  jormungandViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import SwiftUI

struct jormungandViewNormal: View {
    @ObservedObject var jormungand: Jormungand
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    let itemList: [String] = ["チャンス目", "強🍒"]
    @State var selectedItem: String = "チャンス目"
    var body: some View {
        List {
            // ---- レア役からのCZ当選率
            Section {
                // 確率結果
                HStack {
                    // チャンス目
                    unitResultRatioPercent2Line(
                        title: "チャンス目",
                        count: $jormungand.rareCzCountChanceHit,
                        bigNumber: $jormungand.rareCzCountChance,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 強チェリー
                    unitResultRatioPercent2Line(
                        title: "強🍒",
                        count: $jormungand.rareCzCountKyoCherryHit,
                        bigNumber: $jormungand.rareCzCountKyoCherry,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                // 参考情報）レア役からのCZ当選率
                unitLinkButtonViewBuilder(sheetTitle: "レア役からのCZ当選率") {
                    jormungandTableRareCz(jormungand: jormungand)
                }
                // 参考情報）レア役停止形
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    jormungandTableKoyakuPattern()
                }
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("・通常時と高確時で確率が異なるため、通常時のカウントを推奨")
                    }
                    // セグメントピッカー
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.itemList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    HStack {
                        // ---- チャンス目
                        if self.selectedItem == self.itemList[0] {
                            // チャンス目
                            unitCountButtonWithoutRatioWithFunc(
                                title: "小役成立",
                                count: $jormungand.rareCzCountChance,
                                color: .personalSummerLightPurple,
                                minusBool: $jormungand.minusCheck) {
                                    
                                }
                            // CZ当選
                            unitCountButtonWithoutRatioWithFunc(
                                title: "CZ当選",
                                count: $jormungand.rareCzCountChanceHit,
                                color: .purple,
                                minusBool: $jormungand.minusCheck) {
                                    
                                }
                        }
                        // 強チェリー
                        else {
                            // 強チェリー
                            unitCountButtonWithoutRatioWithFunc(
                                title: "小役成立",
                                count: $jormungand.rareCzCountKyoCherry,
                                color: .personalSummerLightRed,
                                minusBool: $jormungand.minusCheck) {
                                    
                                }
                            // CZ当選
                            unitCountButtonWithoutRatioWithFunc(
                                title: "CZ当選",
                                count: $jormungand.rareCzCountKyoCherryHit,
                                color: .red,
                                minusBool: $jormungand.minusCheck) {
                                    
                                }
                        }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            jormungandView95Ci(
                                jormungand: jormungand,
                                selection: 3,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        jormungandViewBayes(
                            jormungand: jormungand,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("レア役からのCZ当選率")
            }
            
            // ---- 短縮天井
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "天井短縮",
                    count: $jormungand.tenjoCountHit,
                    bigNumber: $jormungand.tenjoCountSum,
                    numberofDicimal: 0
                )
                // 参考情報）天井短縮率
                unitLinkButtonViewBuilder(sheetTitle: "天井短縮率") {
                    Text("・当選時は天井が450Gに短縮される")
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "天井短縮",
                            percentList: jormungand.ratioTenjoCut
                        )
                    }
                }
                // ---- カウント
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("・設定変更後、恥の世紀終了後は天井短縮確定なのでカウント除外")
                    }
                    // カウントボタン横並び
                    HStack {
                        // 短縮なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "短縮なし",
                            count: $jormungand.tenjoCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $jormungand.minusCheck) {
                                jormungand.tenjoSumFunc()
                            }
                        // 短縮あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "短縮あり",
                            count: $jormungand.tenjoCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $jormungand.minusCheck) {
                                jormungand.tenjoSumFunc()
                            }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            jormungandView95Ci(
                                jormungand: jormungand,
                                selection: 5,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        jormungandViewBayes(
                            jormungand: jormungand,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("天井短縮率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.jormungandMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: jormungand.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
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
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $jormungand.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: jormungand.resetNormal)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        isFocused = false
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}

#Preview {
    jormungandViewNormal(
        jormungand: Jormungand(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

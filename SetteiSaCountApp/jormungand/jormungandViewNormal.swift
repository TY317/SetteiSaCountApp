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
    @State var selectedCard: String = "マオ"
    let selectList: [String] = [
        "マオ",
        "ウゴ",
        "トージョ",
        "ワイリ",
        "ヨナ",
        "レーム",
        "ルツ",
        "ヨナ＆ココ",
        "アール＆ココ",
        "バルメ＆ココ",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "次回CZモードC以上示唆 弱",
        "高設定示唆 強",
        "次回CZモードC以上示唆 強",
        "偶数設定濃厚",
        "次回CZモードD以上濃厚",
        "次回滅びの丘濃厚",
    ]
    let indexList: [Int] = [0,1,2,3,5,7]
    
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
            
            // ---- サブ液晶カード
            Section {
                DisclosureGroup {
                    // サークルピッカー
                    Picker("", selection: self.$selectedCard) {
                        ForEach(self.selectList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    
                    // 1. selectedCardがselectListの何番目にあるかを探す
                    if let currentIndex = selectList.firstIndex(of: selectedCard) {
                        // 登録対象
                        if self.indexList.contains(currentIndex) {
                            // //// 示唆＆登録ボタン
                            unitCountSubmitWithResult(
                                title: sisaText(item: self.selectedCard),
                                count: bindingVoice(item: self.selectedCard),
                                bigNumber: $jormungand.cardCountSum,
                                flushColor: flushColor(item: self.selectedCard),
                                minusCheck: $jormungand.minusCheck) {
                                    jormungand.cardSumFunc()
                                }
                        }
                        // 示唆のみ表示
                        else {
                            Text("\(self.sisaList[currentIndex])")
                            Text("登録")
                                .foregroundStyle(Color.secondary)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    
                    // スペース用の行
                    Text("")
                        .listRowBackground(Color(UIColor.systemGroupedBackground))
                        .listRowSeparator(.hidden)
                    
                    // カウント結果
                    ForEach(self.indexList, id: \.self) { index in
                        let card = self.selectList[index]
                        unitResultCountListPercent(
                            title: sisaText(item: card),
                            count: bindingVoice(item: card),
                            flashColor: flushColor(item: card),
                            bigNumber: $jormungand.cardCountSum
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("サブ液晶カード")
            }
//            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
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
    
    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return self.sisaList[0]
        case self.selectList[1]: return self.sisaList[1]
        case self.selectList[2]: return self.sisaList[2]
        case self.selectList[3]: return self.sisaList[3]
        case self.selectList[4]: return self.sisaList[4]
        case self.selectList[5]: return self.sisaList[5]
        case self.selectList[6]: return self.sisaList[6]
        case self.selectList[7]: return self.sisaList[7]
        case self.selectList[8]: return self.sisaList[8]
        case self.selectList[9]: return self.sisaList[9]
        default: return "???"
        }
    }
    
    private func bindingVoice(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $jormungand.cardCountDefault
        case self.selectList[1]: return $jormungand.cardCountKisu
        case self.selectList[2]: return $jormungand.cardCountGusu
        case self.selectList[3]: return $jormungand.cardCountHighJaku
        case self.selectList[4]: return $jormungand.cardCountModeCJaku
        case self.selectList[5]: return $jormungand.cardCountHighKyo
        case self.selectList[6]: return $jormungand.cardCountModeCKyo
        case self.selectList[7]: return $jormungand.cardCountGusuFix
        case self.selectList[8]: return $jormungand.cardCountModeD
        case self.selectList[9]: return $jormungand.cardCountHorobi
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .gray
        case self.selectList[1]: return .blue
        case self.selectList[2]: return .yellow
        case self.selectList[3]: return .green
        case self.selectList[5]: return .red
        case self.selectList[7]: return .brown
        default: return .clear
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

//
//  bioRe3ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import SwiftUI

struct bioRe3ViewNormal: View {
    @ObservedObject var bioRe3: BioRe3
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    let items: [String] = ["弱🍒・🍉","チャンス目・強🍒",]
    @State var selectedItem: String = "弱🍒・🍉"
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
    // 心音レベル：この値以上のindex(0〜5)が赤点灯。0=全点灯, 6=全消灯
    @State private var heartBoundary: Int = 0

    // 心音レベルボタンのタップ処理（左から順に消灯する単調なしきい値挙動）
    private func tapHeart(_ i: Int) {
        if i >= heartBoundary {
            heartBoundary = i + 1   // 点灯中をタップ→自分と左を消灯
        } else {
            heartBoundary = i       // 消灯中をタップ→自分と右を点灯
        }
    }

    var body: some View {
        List {
            // 小役関連
            Section {
                // 確率結果
                HStack {
                    // 弱レア→CZ
                    unitResultRatioPercent2Line(
                        title: "弱レア→CZ",
                        count: $bioRe3.jakuRareCountCzHit,
                        bigNumber: $bioRe3.jakuRareCountKoyakuSum,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // 強レア→CZ
                    unitResultRatioPercent2Line(
                        title: "強レア→CZ",
                        count: $bioRe3.kyoRareCountCzHit,
                        bigNumber: $bioRe3.kyoRareCountKoyakuSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 強レア→AT
                    unitResultRatioPercent2Line(
                        title: "強レア→AT",
                        count: $bioRe3.kyoRareCountAtHit,
                        bigNumber: $bioRe3.kyoRareCountKoyakuSum,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 直撃率
                unitLinkButtonViewBuilder(sheetTitle: "レア役からのCZ,AT直撃率") {
                    bioRe3TableKoyakuHit(bioRe3: bioRe3)
                }
                
                // レア役停止形
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    bioRe3TableKoyakuPattern()
                }
                
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("・滞在モードごとに直撃率が異なるため、サンプル取りやすい通常モードのレア役のみカウントを推奨")
                    }
                    
                    // セグメントピッカー
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.items, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // カウントボタン横並び
                    HStack {
                        // 弱レア役
                        if self.selectedItem == self.items[0] {
                            // 弱🍒
                            unitCountButtonWithoutRatioWithFunc(
                                title: "弱🍒",
                                count: $bioRe3.jakuRareCountJakuCherry,
                                color: .personalSummerLightRed,
                                minusBool: $bioRe3.minusCheck) {
                                    bioRe3.koyakuCountSumFunc()
                                }
                            // 🍉
                            unitCountButtonWithoutRatioWithFunc(
                                title: "🍉",
                                count: $bioRe3.jakuRareCountSuika,
                                color: .personalSummerLightGreen,
                                minusBool: $bioRe3.minusCheck) {
                                    bioRe3.koyakuCountSumFunc()
                                }
                            // CZ直撃
                            unitCountButtonWithoutRatioWithFunc(
                                title: "CZ直撃",
                                count: $bioRe3.jakuRareCountCzHit,
                                color: .personalSummerLightPurple,
                                minusBool: $bioRe3.minusCheck) {
                                    bioRe3.koyakuCountSumFunc()
                                }
                        }
                        // 強レア役
                        else {
                            // チャンス目
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ﾁｬﾝｽ目",
                                count: $bioRe3.kyoRareCountChance,
                                color: .yellow,
                                minusBool: $bioRe3.minusCheck) {
                                    bioRe3.koyakuCountSumFunc()
                                }
                            // 強🍒
                            unitCountButtonWithoutRatioWithFunc(
                                title: "強🍒",
                                count: $bioRe3.kyoRareCountKyoCherry,
                                color: .red,
                                minusBool: $bioRe3.minusCheck) {
                                    bioRe3.koyakuCountSumFunc()
                                }
                            // CZ直撃
                            unitCountButtonWithoutRatioWithFunc(
                                title: "CZ直撃",
                                count: $bioRe3.kyoRareCountCzHit,
                                color: .purple,
                                minusBool: $bioRe3.minusCheck) {
                                    bioRe3.koyakuCountSumFunc()
                                }
                            // AT直撃
                            unitCountButtonWithoutRatioWithFunc(
                                title: "AT直撃",
                                count: $bioRe3.kyoRareCountAtHit,
                                color: .blue,
                                minusBool: $bioRe3.minusCheck) {
                                    bioRe3.koyakuCountSumFunc()
                                }
                        }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            bioRe3View95Ci(
                                bioRe3: bioRe3,
                                selection: 3,
                            )
                        )
                    )
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("レア役からの直撃")
            }
            
            // ---- 心音
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "転落率",
                    count: $bioRe3.shinonCountDrop,
                    bigNumber: $bioRe3.shinonCountSum,
                    numberofDicimal: 0
                )
                
                // 参考情報）心音レベル転落率
                unitLinkButtonViewBuilder(sheetTitle: "心音レベル転落率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "転落率",
                            percentList: bioRe3.ratioShinonDrop
                        )
                    }
                }
                
                DisclosureGroup {
                    VStack {
                        Text("[STゲーム数メモ]")
                        // STゲーム数ボタン
                        HStack(spacing: 25) {
                            ForEach(0..<6, id: \.self) { i in
                                let isOn = i >= heartBoundary
                                Circle()
                                    .fill(isOn ? Color.red : Color(.systemGray3))
                                    .frame(width: 30, height: 30)
                                    .overlay(Circle().stroke(Color(.systemGray), lineWidth: 1))
                                    .shadow(color: isOn ? Color.red.opacity(0.5) : .clear, radius: 3)
                                    .contentShape(Circle())
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.12)) { tapHeart(i) }
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    // カウントボタン横並び
                    HStack {
                        // 転落
                        unitCountButtonWithoutRatioWithFunc(
                            title: "転落",
                            count: $bioRe3.shinonCountDrop,
                            color: .personalSummerLightBlue,
                            minusBool: $bioRe3.minusCheck) {
                                self.heartBoundary = 2
                                bioRe3.shinonSumFunc()
                            }
                        
                        // 転落なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "転落なし",
                            count: $bioRe3.shinonCountStay,
                            color: .personalSummerLightRed,
                            minusBool: $bioRe3.minusCheck) {
                                bioRe3.shinonSumFunc()
                            }
                    }
                    
                    // 心音レベルの転落について
                    unitLinkButtonViewBuilder(sheetTitle: "心音レベルの転落について") {
                        Text("・心音が緑以上の際は補償6G間のST状態になる")
                        Text("・リプレイ、レア役、前兆突入、前兆終了で補償G数を再セット")
                        Text("・転落直後のSTは補償4Gでセットされる。その4G間に再セット条件を満たすと以降は6Gで再セット")
                        Text("・補償G数消化後はハズレ・ベル成立時に転落抽選")
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            bioRe3View95Ci(
                                bioRe3: bioRe3,
                                selection: 6,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        bioRe3ViewBayes(
                            bioRe3: bioRe3,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("心音レベル転落率")
            }
            
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bioRe3MenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bioRe3.machineName,
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
                unitButtonMinusCheck(minusCheck: $bioRe3.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: bioRe3.resetNormal)
            }
        }
    }
}

#Preview {
    bioRe3ViewNormal(
        bioRe3: BioRe3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

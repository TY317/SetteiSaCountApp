//
//  hanabiViewRtReplay.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/15.
//

import SwiftUI

struct hanabiViewRtReplay: View {
    @ObservedObject var hanabi: Hanabi
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
    
    @State var selectedItem: String = "花火チャレンジ"
    let itemList: [String] = ["花火チャレンジ", "花火GAME"]
    
    var body: some View {
        List {
            // RT中リプレイカウント
            Section {
                // セグメントピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.itemList, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
                
                // 花火チャレンジ
                if self.selectedItem == self.itemList[0] {
                    // 注意書き
                    unitLabelCautionText {
                        Text("移行リプレイ以外の通常リプレイをカウント")
                            .padding(.vertical, 3)
                    }
                    
                    // チャレンジプレイ数
                    unitTextFieldNumberInputWithUnit(
                        title: "花火チャレンジプレイ数",
                        inputValue: $hanabi.challengeGame,
                        titleFont: .footnote,
                        unitText: "Ｇ",
                    )
                    .focused(self.$isFocused)
                    
                    // カウント
                    unitCountButtonVerticalWithoutRatio(
                        title: "通常リプレイ",
                        count: $hanabi.replayCountChallenge,
                        color: .personalSummerLightBlue,
                        minusBool: $hanabi.minusCheck
                    )
                }
                
                // 花火GAME
                else {
                    // 注意書き
                    unitLabelCautionText {
                        Text("2コマ目押し成功で見極められるRTリプレイをカウント")
                        Text("目押し手順は参考情報を参照ください")
                    }
                    
                    // 花火ゲームプレイ数
                    unitTextFieldNumberInputWithUnit(
                        title: "花火GAMEプレイ数",
                        inputValue: $hanabi.hanabiGame,
                        titleFont: .subheadline,
                        unitText: "Ｇ",
                    )
                    .focused(self.$isFocused)
                    
                    // カウント
                    unitCountButtonVerticalWithoutRatio(
                        title: "RTリプレイ",
                        count: $hanabi.replayCountGame,
                        color: .blue,
                        minusBool: $hanabi.minusCheck
                    )
                }
                
                // 確率結果
                HStack {
                    // チャレンジ中通常リプ
                    unitResultRatioDenomination2Line(
                        title: "ﾁｬﾚﾝｼﾞ中通常リプ",
                        count: $hanabi.replayCountChallenge,
                        bigNumber: $hanabi.challengeGame,
                        numberofDicimal: 1
                    )
                    //GAME中RTリプ
                    unitResultRatioDenomination2Line(
                        title: "GAME中RTリプ",
                        count: $hanabi.replayCountGame,
                        bigNumber: $hanabi.hanabiGame,
                        numberofDicimal: 1
                    )
                }
                
                // 参考情報）RT中リプレイ確率
                unitLinkButtonViewBuilder(sheetTitle: "RT中リプレイ確率") {
                    hanabiTableRtReplay(hanabi: hanabi)
                }
                
                // 参考情報）花火GAME中 RTリプレイ判別方法
                unitLinkButtonViewBuilder(sheetTitle: "花火GAME中 RTリプレイ判別手順") {
                    VStack(alignment: .leading) {
                        Text("[手順]")
                        Text("①：左リール 3連ドンの一番上のドンちゃんを中・下段に目押し")
                        Text("②：中・右リールを止める")
                        Text("③：リプレイ揃い時のラインで判別")
                        VStack(alignment: .leading) {
                            Text("中段平行揃い：RTリプレイ")
                            Text("それ以外：通常リプレイ")
                        }
                        .padding(.leading, 40)
                        .padding(.bottom)
                        Text("・予告音やフラッシュ発生時は通常時と同じ手順で小役をフォロー")
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        hanabiView95Ci(
                            hanabi: hanabi,
                            selection: 11,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    hanabiViewBayes(
                        hanabi: hanabi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hanabiMenuRtReplayBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hanabi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("RT中リプレイ")
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
                unitButtonMinusCheck(minusCheck: $hanabi.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hanabi.resetRtReplay)
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
    hanabiViewRtReplay(
        hanabi: Hanabi(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

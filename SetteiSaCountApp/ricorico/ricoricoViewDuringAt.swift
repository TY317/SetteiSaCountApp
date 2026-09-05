//
//  ricoricoViewDuringAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ricoricoViewDuringAt: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var ricorico: Ricorico
    @State var isShowDestination: Bool = false
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

    @State var selectedSegment: String = "プロローグ"
    let segmentList: [String] = ["プロローグ", "ﾗｯｼｭ中ｴﾋﾟﾎﾞ", "Wﾗｯｼｭ中ｴﾋﾟﾎﾞ"]
    @State var selectedImageName: String = ""
    // モードごとに4枚（EP1・EP2 は同じカウント＝デフォルト）
    let imageNameList: [[String]] = [
        ["ricoricoPrologueScreen1", "ricoricoPrologueScreen2", "ricoricoPrologueScreen3", "ricoricoPrologueScreen4"],
        ["ricoricoRushEpiboScreen1", "ricoricoRushEpiboScreen2", "ricoricoRushEpiboScreen3", "ricoricoRushEpiboScreen4"],
        ["ricoricoWRushEpiboScreen1", "ricoricoWRushEpiboScreen2", "ricoricoWRushEpiboScreen3", "ricoricoWRushEpiboScreen4"],
    ]
    let upperBeltTextList: [[String]] = [
        ["【EP1】Time will tell ①", "【EP2】The more the merrier", "【EP3】Repay evil with evil", "【EP4】Time will tell ②"],
        ["【EP1】Easy does it", "【EP2】Nothing seek, nothing find", "【EP3】Opposites attract", "【EP4】Recoil of Lycoris\n−side千束＆真島−"],
        ["【EP1】More haste, less speed", "【EP2】So far, so good", "【EP3】Recoil of Lycoris\n−sideリコリコ−", "【EP4】Recoil of Lycoris\n−sideハワイ−"],
    ]
    let lowerBeltTextList: [[String]] = [
        ["デフォルト", "デフォルト", "???", "???"],
        ["デフォルト", "デフォルト", "???", "???"],
        ["デフォルト", "デフォルト", "???", "???"],
    ]
    let flashColorList: [[Color]] = [
        [.gray, .gray, .green, .red],
        [.gray, .gray, .green, .red],
        [.gray, .gray, .green, .red],
    ]
    let indexList: [Int] = [0,1,2,3]
    // 結果表示用（EP1・EP2 は同じカウントなので3行）
    let resultIndexList: [Int] = [0,1,2]
    let resultTitleList: [[String]] = [
        ["デフォルト", "???(EP3)", "???(EP4)"],
        ["デフォルト", "???(EP3)", "???(EP4)"],
        ["デフォルト", "???(EP3)", "???(EP4)"],
    ]
    let resultColorList: [[Color]] = [
        [.gray, .green, .red],
        [.gray, .green, .red],
        [.gray, .green, .red],
    ]
    // 選択中モードの添字
    var modeIndex: Int {
        self.segmentList.firstIndex(of: self.selectedSegment) ?? 0
    }

    var body: some View {
        List {
            // 画面カウント
            Section {
                // //// セグメントピッカー
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { segment in
                        Text(segment)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: self.selectedSegment) {
                    // モードを切り替えたら画面の選択状態を解除する
                    self.selectedImageName = ""
                }

                VStack {
                    // カウントボタン
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(self.indexList, id: \.self) { index in
                                if self.imageNameList[self.modeIndex].indices.contains(index) &&
                                    self.upperBeltTextList[self.modeIndex].indices.contains(index) &&
                                    self.lowerBeltTextList[self.modeIndex].indices.contains(index) {
                                    unitButtonScreenChoiceVer3(
                                        screen: unitScreenOnlyDisplay(
                                            image: Image(self.imageNameList[self.modeIndex][index]),
                                            upperBeltText: self.upperBeltTextList[self.modeIndex][index],
                                            upperBeltFont: .caption,
                                            upperBeltHeight: 40,
                                            lowerBeltText: self.lowerBeltTextList[self.modeIndex][index],
                                        ),
                                        screenName: self.imageNameList[self.modeIndex][index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenCount(mode: self.modeIndex, index: index),
                                        minusCheck: $ricorico.minusCheck,
                                        action: sumAction(mode: self.modeIndex),
                                    )
                                    // モードごとにボタンのidentityを分ける
                                    // （unitButtonScreenChoiceVer3 の screen/screenName は @State のため、
                                    //   identityを変えないとセグメント切替で画像・ベルトが更新されない）
                                    .id("\(self.selectedSegment)-\(index)")
                                }
                            }
                        }
                    }
                    .frame(height: common.screenScrollHeight)
                }

                // //// カウント結果
                ForEach(self.resultIndexList, id: \.self) { index in
                    if self.resultTitleList[self.modeIndex].indices.contains(index) &&
                        self.resultColorList[self.modeIndex].indices.contains(index) {
                        unitResultCountListPercent(
                            title: self.resultTitleList[self.modeIndex][index],
                            count: bindingForResultCount(mode: self.modeIndex, index: index),
                            flashColor: self.resultColorList[self.modeIndex][index],
                            bigNumber: bindingForSum(mode: self.modeIndex),
                            numberofDigit: 0,
                            titleFont: .body,
                        )
                        // モードごとに行のidentityを分ける
                        // （分けないとセグメント切替でcountの値が変わり、フラッシュが誤発火する）
                        .id("\(self.selectedSegment)-\(index)")
                    }
                }
            } header: {
                unitLabelHeaderScreenCount()
            }

        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.ricoricoMenuDuringAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ricorico.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT中")
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
                // //// 画面選択解除
                unitButtonToolbarScreenSelectReset(
                    currentKeyword: self.$selectedImageName
                )
            }
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $ricorico.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: ricorico.resetDuringAt)
            }
        }
    }

    // 画像4枚 → カウント3本のマッピング（EP1・EP2 はどちらも Count1＝デフォルト）
    func bindingForScreenCount(mode: Int, index: Int) -> Binding<Int> {
        let resultIndex: Int
        switch index {
        case 0, 1: resultIndex = 0
        case 2: resultIndex = 1
        case 3: resultIndex = 2
        default: return .constant(0)
        }
        return bindingForResultCount(mode: mode, index: resultIndex)
    }

    func bindingForResultCount(mode: Int, index: Int) -> Binding<Int> {
        switch (mode, index) {
        case (0, 0): return $ricorico.prologueCount1
        case (0, 1): return $ricorico.prologueCount2
        case (0, 2): return $ricorico.prologueCount3
        case (1, 0): return $ricorico.rushEpiboCount1
        case (1, 1): return $ricorico.rushEpiboCount2
        case (1, 2): return $ricorico.rushEpiboCount3
        case (2, 0): return $ricorico.wRushEpiboCount1
        case (2, 1): return $ricorico.wRushEpiboCount2
        case (2, 2): return $ricorico.wRushEpiboCount3
        default: return .constant(0)
        }
    }

    func bindingForSum(mode: Int) -> Binding<Int> {
        switch mode {
        case 0: return $ricorico.prologueCountSum
        case 1: return $ricorico.rushEpiboCountSum
        case 2: return $ricorico.wRushEpiboCountSum
        default: return .constant(0)
        }
    }

    func sumAction(mode: Int) -> () -> Void {
        switch mode {
        case 0: return ricorico.prologueSumFunc
        case 1: return ricorico.rushEpiboSumFunc
        case 2: return ricorico.wRushEpiboSumFunc
        default: return {}
        }
    }
}

#Preview {
    ricoricoViewDuringAt(
        ricorico: Ricorico(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

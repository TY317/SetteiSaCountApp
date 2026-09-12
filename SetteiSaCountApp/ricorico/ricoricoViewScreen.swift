//
//  ricoricoViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ricoricoViewScreen: View {
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

    @State var selectedSegment: String = "たきなﾗｯｼｭ後"
    let segmentList: [String] = ["たきなﾗｯｼｭ後", "千束ﾗｯｼｭ後", "Wﾗｯｼｭ後"]
    @State var selectedImageName: String = ""
    // 画面の種類はモード共通（8枚）
    let imageNameList: [String] = [
        "ricoricoScreen1",
        "ricoricoScreen2",
        "ricoricoScreen3",
        "ricoricoScreen4",
        "ricoricoScreen5",
        "ricoricoScreen6",
        "ricoricoScreen7",
        "ricoricoScreen8",
    ]
    let upperBeltTextList: [String] = [
        "たきな制服",
        "千束 制服",
        "たきな私服",
        "千束 私服",
        "千束＆たきな",
        "風景",
        "ロボ太",
        "ハワイ",
    ]
    // モードごとに示唆が変わる（たきな私服・千束 私服）
    let lowerBeltTextList: [[String]] = [
        ["デフォルト", "デフォルト", "高設定示唆 弱", "設定4 以上濃厚", "高設定示唆 強", "設定2 以上濃厚", "設定4 以上濃厚", "設定6 濃厚"],
        ["デフォルト", "デフォルト", "設定4 以上濃厚", "高設定示唆 弱", "高設定示唆 強", "設定2 以上濃厚", "設定4 以上濃厚", "設定6 濃厚"],
        ["デフォルト", "デフォルト", "高設定示唆 弱", "高設定示唆 弱", "高設定示唆 強", "設定2 以上濃厚", "設定4 以上濃厚", "設定6 濃厚"],
    ]
    let flashColorList: [Color] = [
        .gray,
        .gray,
        .blue,
        .yellow,
        .green,
        .red,
        .orange,
        .purple,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7]
    // 結果表示は「示唆」単位（6行・モード共通）
    let resultIndexList: [Int] = [0,1,2,3,4,5]
    let resultTitleList: [String] = [
        "デフォルト",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let resultColorList: [Color] = [
        .gray,
        .blue,
        .green,
        .red,
        .orange,
        .purple,
    ]
    // 選択中モードの添字
    var modeIndex: Int {
        self.segmentList.firstIndex(of: self.selectedSegment) ?? 0
    }
    // カウント変数のセット（0=ラッシュ後（たきな・千束 共用） / 1=Wラッシュ後）
    var countSetIndex: Int {
        self.modeIndex == 2 ? 1 : 0
    }

    var body: some View {
        List {
            // 画面カウント
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("ラッシュ種類によって一部画面の示唆内容が変化")
                }
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
                                if self.imageNameList.indices.contains(index) &&
                                    self.upperBeltTextList.indices.contains(index) &&
                                    self.lowerBeltTextList[self.modeIndex].indices.contains(index) {
                                    unitButtonScreenChoiceVer3(
                                        screen: unitScreenOnlyDisplay(
                                            image: Image(self.imageNameList[index]),
                                            upperBeltText: self.upperBeltTextList[index],
                                            lowerBeltText: self.lowerBeltTextList[self.modeIndex][index],
                                        ),
                                        screenName: self.imageNameList[index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenCount(set: self.countSetIndex, mode: self.modeIndex, index: index),
                                        minusCheck: $ricorico.minusCheck,
                                        action: sumAction(set: self.countSetIndex),
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
                    if self.resultTitleList.indices.contains(index) &&
                        self.resultColorList.indices.contains(index) {
                        unitResultCountListPercent(
                            title: self.resultTitleList[index],
                            count: bindingForResultCount(set: self.countSetIndex, index: index),
                            flashColor: self.resultColorList[index],
                            bigNumber: bindingForSum(set: self.countSetIndex),
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
        .resetBadgeOnAppear($common.ricoricoMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ricorico.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("終了画面")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: ricorico.resetScreen)
            }
        }
    }
    // 画像8枚 → 示唆6種のマッピング
    // 示唆の並び：0=デフォルト 1=高設定示唆 弱 2=高設定示唆 強 3=設定2以上濃厚 4=設定4以上濃厚 5=設定6濃厚
    // たきな私服・千束 私服はモードによって示唆が入れ替わるので行き先が変わる
    func resultIndexForScreen(mode: Int, index: Int) -> Int? {
        switch index {
        case 0, 1: return 0                       // たきな制服／千束 制服
        case 2: return mode == 1 ? 4 : 1          // たきな私服（千束ﾗｯｼｭ後のみ設定4以上濃厚）
        case 3: return mode == 0 ? 4 : 1          // 千束 私服（たきなﾗｯｼｭ後のみ設定4以上濃厚）
        case 4: return 2                          // 千束＆たきな
        case 5: return 3                          // 風景
        case 6: return 4                          // ロボ太
        case 7: return 5                          // ハワイ
        default: return nil
        }
    }

    func bindingForScreenCount(set: Int, mode: Int, index: Int) -> Binding<Int> {
        guard let resultIndex = resultIndexForScreen(mode: mode, index: index) else {
            return .constant(0)
        }
        return bindingForResultCount(set: set, index: resultIndex)
    }

    func bindingForResultCount(set: Int, index: Int) -> Binding<Int> {
        switch (set, index) {
        case (0, 0): return $ricorico.screenCount1
        case (0, 1): return $ricorico.screenCount2
        case (0, 2): return $ricorico.screenCount3
        case (0, 3): return $ricorico.screenCount4
        case (0, 4): return $ricorico.screenCount5
        case (0, 5): return $ricorico.screenCount6
        case (1, 0): return $ricorico.wScreenCount1
        case (1, 1): return $ricorico.wScreenCount2
        case (1, 2): return $ricorico.wScreenCount3
        case (1, 3): return $ricorico.wScreenCount4
        case (1, 4): return $ricorico.wScreenCount5
        case (1, 5): return $ricorico.wScreenCount6
        default: return .constant(0)
        }
    }

    func bindingForSum(set: Int) -> Binding<Int> {
        switch set {
        case 0: return $ricorico.screenCountSum
        case 1: return $ricorico.wScreenCountSum
        default: return .constant(0)
        }
    }

    func sumAction(set: Int) -> () -> Void {
        switch set {
        case 0: return ricorico.screenSumFunc
        case 1: return ricorico.wScreenSumFunc
        default: return {}
        }
    }
}

#Preview {
    ricoricoViewScreen(
        ricorico: Ricorico(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

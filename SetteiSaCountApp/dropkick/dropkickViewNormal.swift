//
//  dropkickViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct dropkickViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var dropkick: Dropkick
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
    @State var isShowAlertMigisagari: Bool = false
    @State var isShowAlertUpper: Bool = false
    @State var isShowAlertMiddle: Bool = false
    @State var isShowAlertLower: Bool = false
    @State var isShowAlertMigiagari: Bool = false
    // ポイント加算ボタンの横幅（5ライン共通）
    let plusButtonMaxWidth: CGFloat = 150
    // ポイント加算ボタンの高さ（5ライン共通）
    let plusButtonHeight: CGFloat = 36
    var body: some View {
        List {
            // ポイント推定カウント
            Section {
                Text("ポイント蓄積量のメモ代わりとして活用ください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)

                // 右下がり
                HStack {
                    // 推定ポイント
                    unitResultCount2Line(
                        title: "右下がり",
                        color: .personalSummerLightPurple,
                        count: $dropkick.ptMigisagari,
                        spacerBool: false
                    )
                    // +1pt
                    unitPlusButton(
                        count: $dropkick.ptMigisagari,
                        plusNumber: 1,
                        buttonColor: .purple,
                        minusCheck: dropkick.minusCheck,
                        maxWidth: self.plusButtonMaxWidth,
                        height: self.plusButtonHeight
                    )
                    // +5pt
                    unitPlusButton(
                        count: $dropkick.ptMigisagari,
                        plusNumber: 5,
                        buttonColor: .purple,
                        minusCheck: dropkick.minusCheck,
                        maxWidth: self.plusButtonMaxWidth,
                        height: self.plusButtonHeight
                    )
                    // リセットボタン
                    unitButtonResetBorderedStyle(
                        isShowAlert: self.$isShowAlertMigisagari,
                        buttonText: "ﾘｾｯﾄ",
                        action: dropkick.resetPtMigisagari,
                        message: "右下がりの推定ポイントのみリセットします"
                    )
                }

                // 上段
                HStack {
                    // 推定ポイント
                    unitResultCount2Line(
                        title: "上段",
                        color: .personalSummerLightBlue,
                        count: $dropkick.ptUpper,
                        spacerBool: false
                    )
                    // +1pt
                    unitPlusButton(
                        count: $dropkick.ptUpper,
                        plusNumber: 1,
                        buttonColor: .blue,
                        minusCheck: dropkick.minusCheck,
                        maxWidth: self.plusButtonMaxWidth,
                        height: self.plusButtonHeight
                    )
                    // +5pt
                    unitPlusButton(
                        count: $dropkick.ptUpper,
                        plusNumber: 5,
                        buttonColor: .blue,
                        minusCheck: dropkick.minusCheck,
                        maxWidth: self.plusButtonMaxWidth,
                        height: self.plusButtonHeight
                    )
                    // リセットボタン
                    unitButtonResetBorderedStyle(
                        isShowAlert: self.$isShowAlertUpper,
                        buttonText: "ﾘｾｯﾄ",
                        action: dropkick.resetPtUpper,
                        message: "上段の推定ポイントのみリセットします"
                    )
                }

                // 中段
                HStack {
                    // 推定ポイント
                    unitResultCount2Line(
                        title: "中段",
                        color: .personalSummerLightGreen,
                        count: $dropkick.ptMiddle,
                        spacerBool: false
                    )
                    // +1pt
                    unitPlusButton(
                        count: $dropkick.ptMiddle,
                        plusNumber: 1,
                        buttonColor: .green,
                        minusCheck: dropkick.minusCheck,
                        maxWidth: self.plusButtonMaxWidth,
                        height: self.plusButtonHeight
                    )
                    // +5pt
                    unitPlusButton(
                        count: $dropkick.ptMiddle,
                        plusNumber: 5,
                        buttonColor: .green,
                        minusCheck: dropkick.minusCheck,
                        maxWidth: self.plusButtonMaxWidth,
                        height: self.plusButtonHeight
                    )
                    // リセットボタン
                    unitButtonResetBorderedStyle(
                        isShowAlert: self.$isShowAlertMiddle,
                        buttonText: "ﾘｾｯﾄ",
                        action: dropkick.resetPtMiddle,
                        message: "中段の推定ポイントのみリセットします"
                    )
                }

                // 下段
                HStack {
                    // 推定ポイント
                    unitResultCount2Line(
                        title: "下段",
                        color: .personalSummerLightRed,
                        count: $dropkick.ptLower,
                        spacerBool: false
                    )
                    // +1pt
                    unitPlusButton(
                        count: $dropkick.ptLower,
                        plusNumber: 1,
                        buttonColor: .red,
                        minusCheck: dropkick.minusCheck,
                        maxWidth: self.plusButtonMaxWidth,
                        height: self.plusButtonHeight
                    )
                    // +5pt
                    unitPlusButton(
                        count: $dropkick.ptLower,
                        plusNumber: 5,
                        buttonColor: .red,
                        minusCheck: dropkick.minusCheck,
                        maxWidth: self.plusButtonMaxWidth,
                        height: self.plusButtonHeight
                    )
                    // リセットボタン
                    unitButtonResetBorderedStyle(
                        isShowAlert: self.$isShowAlertLower,
                        buttonText: "ﾘｾｯﾄ",
                        action: dropkick.resetPtLower,
                        message: "下段の推定ポイントのみリセットします"
                    )
                }

                // 右上がり
                HStack {
                    // 推定ポイント
                    unitResultCount2Line(
                        title: "右上がり",
                        color: .grayBack,
                        count: $dropkick.ptMigiagari,
                        spacerBool: false
                    )
                    // +1pt
                    unitPlusButton(
                        count: $dropkick.ptMigiagari,
                        plusNumber: 1,
                        buttonColor: .gray,
                        minusCheck: dropkick.minusCheck,
                        maxWidth: self.plusButtonMaxWidth,
                        height: self.plusButtonHeight
                    )
                    // +5pt
                    unitPlusButton(
                        count: $dropkick.ptMigiagari,
                        plusNumber: 5,
                        buttonColor: .gray,
                        minusCheck: dropkick.minusCheck,
                        maxWidth: self.plusButtonMaxWidth,
                        height: self.plusButtonHeight
                    )
                    // リセットボタン
                    unitButtonResetBorderedStyle(
                        isShowAlert: self.$isShowAlertMigiagari,
                        buttonText: "ﾘｾｯﾄ",
                        action: dropkick.resetPtMigiagari,
                        message: "右上がりの推定ポイントのみリセットします"
                    )
                }
                
                // 参考情報　ラインポイント
                unitLinkButtonViewBuilder(sheetTitle: "ラインポイントについて") {
                    dropkickTableLinePoint()
                }
            } header: {
                Text("ポイント推定カウント")
            }

            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    dropkickTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.dropkickMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dropkick.machineName,
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
                unitButtonMinusCheck(minusCheck: $dropkick.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: dropkick.resetNormal)
            }
        }
    }
}

#Preview {
    dropkickViewNormal(
        dropkick: Dropkick(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

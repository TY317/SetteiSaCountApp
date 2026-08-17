//
//  tonskillViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct tonskillViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var tonskill: Tonskill
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
    @State var isShowAlertSui: Bool = false
    @State var isShowAlertMukoda: Bool = false
    @State var isShowAlertFeru: Bool = false
    var body: some View {
        List {
            // ポイント推定カウント
            Section {
                Text("ポイント蓄積量のメモ代わりとして活用ください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                HStack {
                    VStack {
                        Text("[スイ]")
                            .font(.title2)
                        // +3pt
                        unitPlusButton(
                            count: $tonskill.ptSui,
                            plusNumber: 3,
                            buttonColor: .red,
                            minusCheck: tonskill.minusCheck
                        )
                        // +15pt
                        unitPlusButton(
                            count: $tonskill.ptSui,
                            plusNumber: 15,
                            buttonColor: .red,
                            minusCheck: tonskill.minusCheck
                        )
                        // 推定ポイント
                        unitResultCount2Line(
                            title: "スイ",
                            color: .personalSummerLightRed,
                            count: $tonskill.ptSui,
                            spacerBool: false
                        )
                        .padding(.top, 5)
                        // リセットボタン
                        unitButtonResetBorderedStyle(
                            isShowAlert: self.$isShowAlertSui,
                            buttonText: "リセット",
                            action: tonskill.resetPtSui,
                            message: "スイの推定ポイントのみリセットします"
                        )
                    }
                    VStack {
                        Text("[ムコーダ]")
                            .font(.title2)
                        // +3pt
                        unitPlusButton(
                            count: $tonskill.ptMukoda,
                            plusNumber: 3,
                            buttonColor: .green,
                            minusCheck: tonskill.minusCheck
                        )
                        // +15pt
                        unitPlusButton(
                            count: $tonskill.ptMukoda,
                            plusNumber: 15,
                            buttonColor: .green,
                            minusCheck: tonskill.minusCheck
                        )
                        // 推定ポイント
                        unitResultCount2Line(
                            title: "ムコーダ",
                            color: .personalSummerLightGreen,
                            count: $tonskill.ptMukoda,
                            spacerBool: false
                        )
                        .padding(.top, 5)
                        // リセットボタン
                        unitButtonResetBorderedStyle(
                            isShowAlert: self.$isShowAlertMukoda,
                            buttonText: "リセット",
                            action: tonskill.resetPtMukoda,
                            message: "ムコーダの推定ポイントのみリセットします"
                        )
                    }
                    VStack {
                        Text("[フェル]")
                            .font(.title2)
                        // +3pt
                        unitPlusButton(
                            count: $tonskill.ptFeru,
                            plusNumber: 3,
                            buttonColor: .purple,
                            minusCheck: tonskill.minusCheck
                        )
                        // +15pt
                        unitPlusButton(
                            count: $tonskill.ptFeru,
                            plusNumber: 15,
                            buttonColor: .purple,
                            minusCheck: tonskill.minusCheck
                        )
                        // 推定ポイント
                        unitResultCount2Line(
                            title: "フェル",
                            color: .personalSummerLightPurple,
                            count: $tonskill.ptFeru,
                            spacerBool: false
                        )
                        .padding(.top, 5)
                        // リセットボタン
                        unitButtonResetBorderedStyle(
                            isShowAlert: self.$isShowAlertFeru,
                            buttonText: "リセット",
                            action: tonskill.resetPtFeru,
                            message: "フェルの推定ポイントのみリセットします"
                        )
                    }
                }
                
                // 参考情報 CZポイントについて
                unitLinkButtonViewBuilder(sheetTitle: "CZポイントについて") {
                    tonskillTableCzPoint()
                }
            } header: {
                Text("ポイント推定カウント")
            }

            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    Text("・チャンス目図柄が停止してリプレイ・ベル揃いなしでチャンス目")
                    Text("・全リール適当押しでOK")
                    Text("・カバネリと同じ")
                }
            } header: {
                Text("小役")
            }
            
             // モード
            Section {
                // 参考情報　通常時のモード
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    tonskillTableMode()
                }
            } header: {
                Text("モード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.tonskillMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tonskill.machineName,
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
                unitButtonMinusCheck(minusCheck: $tonskill.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: tonskill.resetNormal)
            }
        }
    }
}

#Preview {
    tonskillViewNormal(
        tonskill: Tonskill(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

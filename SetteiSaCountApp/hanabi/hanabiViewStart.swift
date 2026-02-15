//
//  hanabiViewStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/07.
//

import SwiftUI

struct hanabiViewStart: View {
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
    
    var body: some View {
        List {
            // 打ち始めデータ
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "総ゲーム数",
                    inputValue: $hanabi.startGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                .onChange(of: hanabi.startGame) { oldValue, newValue in
                    hanabi.gameSumFunc()
                }
                
                // カウントボタン横並び
                HStack {
                    // BIG
                    unitCountButtonDenominateWithFunc(
                        title: "BIG",
                        count: $hanabi.startBig,
                        color: .personalSummerLightRed,
                        bigNumber: $hanabi.startGame,
                        numberofDicimal: 0,
                        minusBool: $hanabi.minusCheck) {
                            hanabi.bonusSumFunc()
                        }
                    // REG
                    unitCountButtonDenominateWithFunc(
                        title: "REG",
                        count: $hanabi.startReg,
                        color: .personalSummerLightBlue,
                        bigNumber: $hanabi.startGame,
                        numberofDicimal: 0,
                        minusBool: $hanabi.minusCheck) {
                            hanabi.bonusSumFunc()
                        }
                }
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,5,6])
                        unitTableDenominate(
                            columTitle: "BIG",
                            denominateList: hanabi.ratioBig
                        )
                        unitTableDenominate(
                            columTitle: "REG",
                            denominateList: hanabi.ratioReg
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        hanabiView95CiStart(
                            hanabi: hanabi,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    hanabiViewBayesStart(
                        hanabi: hanabi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("打ち始めデータ")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hanabiMenuStartBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hanabi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("打ち始めデータ")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: hanabi.resetStart)
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
    hanabiViewStart(
        hanabi: Hanabi(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

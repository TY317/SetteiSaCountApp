//
//  thunderViewStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/09.
//

import SwiftUI

struct thunderViewStart: View {
    @ObservedObject var thunder: Thunder
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
                    inputValue: $thunder.startGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                .onChange(of: thunder.startGame) { oldValue, newValue in
                    thunder.gameSumFunc()
                }
                
                // カウントボタン横並び
                HStack {
                    // BIG
                    unitCountButtonDenominateWithFunc(
                        title: "BIG",
                        count: $thunder.startBig,
                        color: .personalSummerLightRed,
                        bigNumber: $thunder.startGame,
                        numberofDicimal: 0,
                        minusBool: $thunder.minusCheck) {
                            thunder.bonusSumFunc()
                        }
                    // REG
                    unitCountButtonDenominateWithFunc(
                        title: "REG",
                        count: $thunder.startReg,
                        color: .personalSummerLightBlue,
                        bigNumber: $thunder.startGame,
                        numberofDicimal: 0,
                        minusBool: $thunder.minusCheck) {
                            thunder.bonusSumFunc()
                        }
                }
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,5,6])
                        unitTableDenominate(
                            columTitle: "BIG",
                            denominateList: thunder.ratioBig
                        )
                        unitTableDenominate(
                            columTitle: "REG",
                            denominateList: thunder.ratioReg
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        thunderView95CiStart(
                            thunder: thunder,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    thunderViewBayesStart(
                        thunder: thunder,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("打ち始めデータ")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.thunderMenuStartBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: thunder.machineName,
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
                unitButtonMinusCheck(minusCheck: $thunder.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: thunder.resetStart)
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
    thunderViewStart(
        thunder: Thunder(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

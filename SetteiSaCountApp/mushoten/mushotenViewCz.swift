//
//  mushotenViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import SwiftUI

struct mushotenViewCz: View {
    @ObservedObject var mushoten: Mushoten
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
//    @FocusState var isFocused: Bool
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
    @FocusState var focusedField: MushotenField?
    enum MushotenField: Hashable {
        case gameStart
        case gameCurrent
        case count(Int)
    }
    
    var body: some View {
        List {
            // ---- CZ確率
            Section {
                // //// ゲーム数入力
                // 打ち始め入力
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $mushoten.gameNumberStart,
                    unitText: "Ｇ"
                )
                .focused($focusedField, equals: .gameStart)
                .onChange(of: mushoten.gameNumberStart) {
                    let playGame = mushoten.gameNumberCurrent - mushoten.gameNumberStart
                    mushoten.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $mushoten.gameNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused($focusedField, equals: .gameCurrent)
                .onChange(of: mushoten.gameNumberCurrent) {
                    let playGame = mushoten.gameNumberCurrent - mushoten.gameNumberStart
                    mushoten.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: mushoten.gameNumberPlay
                )
                
                // CZカウント
                unitCountButtonVerticalDenominate(
                    title: "CZ",
                    count: $mushoten.czCount,
                    color: .personalSummerLightPurple,
                    bigNumber: $mushoten.gameNumberPlay,
                    numberofDicimal: 0,
                    minusBool: $mushoten.minusCheck
                )
                
                // 参考情報）CZ確率
                unitLinkButtonViewBuilder(sheetTitle: "CZ確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "CZ",
                            denominateList: mushoten.ratioCz
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        mushotenView95Ci(
                            mushoten: mushoten,
                            selection: 2,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    mushotenViewBayes(
                        mushoten: mushoten,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("CZ確率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mushotenMenuCzBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mushoten.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ")
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
                unitButtonMinusCheck(minusCheck: $mushoten.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mushoten.resetCz)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        focusedField = nil
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
    mushotenViewCz(
        mushoten: Mushoten(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

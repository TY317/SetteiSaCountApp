//
//  takosloViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct takosloViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var takoslo: Takoslo
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

    enum TakosloField: Hashable {
        case gameStart
        case gameCurrent
        case count(Int)
    }
    @FocusState var focusedField: TakosloField?
    // ダイレクト入力の並び（bindingCount の case と対応）
    let kindList: [String] = ["プラム", "🍉", "🍒", "🍉A", "🍉B", "🍒B", "🍒C"]
    var body: some View {
        List {
            // ---- 小役
            Section {
//                // プラム確率
//                unitResultRatioDenomination2Line(
//                    title: "プラム確率",
//                    count: $takoslo.koyakuCountPlum,
//                    bigNumber: $takoslo.gameNumberPlay,
//                    numberofDicimal: 1
//                )
//
//                // スイカ確率
//                unitResultRatioDenomination2Line(
//                    title: "スイカ確率",
//                    count: $takoslo.koyakuCountSuika,
//                    bigNumber: $takoslo.gameNumberPlay,
//                    numberofDicimal: 0
//                )
//
//                // チェリー確率
//                unitResultRatioDenomination2Line(
//                    title: "チェリー確率",
//                    count: $takoslo.koyakuCountCherry,
//                    bigNumber: $takoslo.gameNumberPlay,
//                    numberofDicimal: 0
//                )

                // カウント
//                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // プラム
                        unitCountButtonDenominateWithFunc(
                            title: "プラム",
                            count: $takoslo.koyakuCountPlum,
                            color: .personalSummerLightBlue,
                            bigNumber: $takoslo.gameNumberPlay,
                            numberofDicimal: 2,
                            minusBool: $takoslo.minusCheck) {
                                
                            }
                        // スイカ
                        unitCountButtonDenominateWithFunc(
                            title: "🍉",
                            count: $takoslo.koyakuCountSuika,
                            color: .personalSummerLightGreen,
                            bigNumber: $takoslo.gameNumberPlay,
                            numberofDicimal: 1,
                            minusBool: $takoslo.minusCheck) {
                            }
                        // チェリー
                        unitCountButtonDenominateWithFunc(
                            title: "🍒",
                            count: $takoslo.koyakuCountCherry,
                            color: .personalSummerLightRed,
                            bigNumber: $takoslo.gameNumberPlay,
                            numberofDicimal: 1,
                            minusBool: $takoslo.minusCheck) {
                            }
                    }
                
                // 参考情報）小役確率
                unitLinkButtonViewBuilder(sheetTitle: "小役確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,5,6])
                        unitTableDenominate(
                            columTitle: "プラム",
                            denominateList: takoslo.ratioKoyakuPlum,
                            numberofDicimal: 1,
                        )
                        unitTableDenominate(
                            columTitle: "🍉",
                            denominateList: takoslo.ratioKoyakuSuika,
                            numberofDicimal: 1,
                        )
                        unitTableDenominate(
                            columTitle: "🍒",
                            denominateList: takoslo.ratioKoyakuCherry,
                            numberofDicimal: 1,
                        )
                    }
                }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            takosloView95Ci(
                                takoslo: takoslo,
                                selection: 1,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        takosloViewBayes(
                            takoslo: takoslo,
                        )
                    }
//                } label: {
//                    Text("カウント")
//                        .foregroundStyle(Color.blue)
//                }
            } header: {
                Text("小役")
            }

            // ---- 小役詳細
            Section {
//                // スイカA確率
//                unitResultRatioDenomination2Line(
//                    title: "スイカA確率",
//                    count: $takoslo.koyakuDetailCountSuikaA,
//                    bigNumber: $takoslo.gameNumberPlay,
//                    numberofDicimal: 0
//                )
//
//                // スイカB確率
//                unitResultRatioDenomination2Line(
//                    title: "スイカB確率",
//                    count: $takoslo.koyakuDetailCountSuikaB,
//                    bigNumber: $takoslo.gameNumberPlay,
//                    numberofDicimal: 0
//                )
//
//                // チェリーB確率
//                unitResultRatioDenomination2Line(
//                    title: "チェリーB確率",
//                    count: $takoslo.koyakuDetailCountCherryB,
//                    bigNumber: $takoslo.gameNumberPlay,
//                    numberofDicimal: 0
//                )
//
//                // チェリーC確率
//                unitResultRatioDenomination2Line(
//                    title: "チェリーC確率",
//                    count: $takoslo.koyakuDetailCountCherryC,
//                    bigNumber: $takoslo.gameNumberPlay,
//                    numberofDicimal: 0
//                )

                // カウント
//                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // スイカA
                        unitCountButtonDenominateWithFunc(
                            title: "🍉A",
                            count: $takoslo.koyakuDetailCountSuikaA,
                            color: .personalSummerLightGreen,
                            bigNumber: $takoslo.gameNumberPlay,
                            numberofDicimal: 1,
                            minusBool: $takoslo.minusCheck) {
                            }
                        // スイカB
                        unitCountButtonDenominateWithFunc(
                            title: "🍉B",
                            count: $takoslo.koyakuDetailCountSuikaB,
                            color: .green,
                            bigNumber: $takoslo.gameNumberPlay,
                            numberofDicimal: 1,
                            minusBool: $takoslo.minusCheck) {
                            }
                        // チェリーB
                        unitCountButtonDenominateWithFunc(
                            title: "🍒B",
                            count: $takoslo.koyakuDetailCountCherryB,
                            color: .personalSummerLightRed,
                            bigNumber: $takoslo.gameNumberPlay,
                            numberofDicimal: 1,
                            minusBool: $takoslo.minusCheck) {
                            }
                        // チェリーC
                        unitCountButtonDenominateWithFunc(
                            title: "🍒C",
                            count: $takoslo.koyakuDetailCountCherryC,
                            color: .red,
                            bigNumber: $takoslo.gameNumberPlay,
                            numberofDicimal: 1,
                            minusBool: $takoslo.minusCheck) {
                            }
                    }
                
                // 参考情報）小役詳細
                unitLinkButtonViewBuilder(sheetTitle: "小役詳細") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,5,6])
                        unitTableDenominate(
                            columTitle: "🍉A",
                            denominateList: takoslo.ratioKoyakuDetailSuikaA,
                            numberofDicimal: 1,
                        )
                        unitTableDenominate(
                            columTitle: "🍉B",
                            denominateList: takoslo.ratioKoyakuDetailSuikaB,
                            numberofDicimal: 1,
                        )
                        unitTableDenominate(
                            columTitle: "🍒B",
                            denominateList: takoslo.ratioKoyakuDetailCherryB,
                            numberofDicimal: 1,
                        )
                        unitTableDenominate(
                            columTitle: "🍒C",
                            denominateList: takoslo.ratioKoyakuDetailCherryC,
                            numberofDicimal: 1,
                        )
                    }
                }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            takosloView95Ci(
                                takoslo: takoslo,
                                selection: 4,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        takosloViewBayes(
                            takoslo: takoslo,
                        )
                    }
//                } label: {
//                    Text("カウント")
//                        .foregroundStyle(Color.blue)
//                }
            } header: {
                Text("小役詳細")
            }
            
            // ゲーム数入力
            Section {
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $takoslo.gameNumberStart,
                    unitText: "Ｇ",
                )
                .focused($focusedField, equals: .gameStart)
                .onChange(of: takoslo.gameNumberStart) {
                    let playGame = takoslo.gameNumberCurrent - takoslo.gameNumberStart
                    takoslo.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $takoslo.gameNumberCurrent,
                    unitText: "Ｇ",
                )
                .focused($focusedField, equals: .gameCurrent)
                .onChange(of: takoslo.gameNumberCurrent) {
                    let playGame = takoslo.gameNumberCurrent - takoslo.gameNumberStart
                    takoslo.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                unitTextGameNumberWithoutInput(gameNumber: takoslo.gameNumberPlay)
            } header: {
                Text("ゲーム数入力")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.takosloMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: takoslo.machineName,
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
                // カウント入力
                UnitToolbarButtonCountDirectInputEnumFocus<TakosloField, AnyView>(
                    focus: $focusedField,
                    inputView: {
                        AnyView(
                            ForEach(self.kindList.indices, id: \.self) { index in
                                UnitTextFieldNumberInputWithUnitEnumFocus<TakosloField>(
                                    title: self.kindList[index],
                                    inputValue: bindingCount(index),
                                    focusedField: $focusedField,
                                    thisField: .count(index)
                                )
                            }
                        )
                    }
                )
            }
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $takoslo.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: takoslo.resetNormal)
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

    // kindList の並びと対応させる
    private func bindingCount(_ index: Int) -> Binding<Int> {
        switch index {
        case 0: return $takoslo.koyakuCountPlum
        case 1: return $takoslo.koyakuCountSuika
        case 2: return $takoslo.koyakuCountCherry
        case 3: return $takoslo.koyakuDetailCountSuikaA
        case 4: return $takoslo.koyakuDetailCountSuikaB
        case 5: return $takoslo.koyakuDetailCountCherryB
        case 6: return $takoslo.koyakuDetailCountCherryC
        default: return .constant(0)
        }
    }
}

#Preview {
    takosloViewNormal(
        takoslo: Takoslo(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

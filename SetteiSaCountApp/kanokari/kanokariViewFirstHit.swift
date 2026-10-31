//
//  kanokariViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kanokariViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var kanokari: Kanokari
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
    // REG連続天井の回数選択
    let regTenjoSegmentList: [String] = ["3回目", "4回目", "5回目"]
    @State var regTenjoSelected: String = "3回目"
    var body: some View {
        List {
            // ゲーム数入力
            unitTextFieldNumberInputWithUnit(
                title: "通常ゲーム数",
                inputValue: $kanokari.normalGame,
                unitText: "Ｇ",
            )
            .focused(self.$isFocused)

            // カウントボタン横並び
            HStack {
                // CZ
                unitCountButtonVerticalDenominate(
                    title: "CZ",
                    count: $kanokari.firstHitCountCz,
                    color: .personalSummerLightBlue,
                    bigNumber: $kanokari.normalGame,
                    numberofDicimal: 0,
                    minusBool: $kanokari.minusCheck
                )
                // 初当り
                unitCountButtonVerticalDenominate(
                    title: "初当り",
                    count: $kanokari.firstHitCountBonus,
                    color: .personalSummerLightRed,
                    bigNumber: $kanokari.normalGame,
                    numberofDicimal: 0,
                    minusBool: $kanokari.minusCheck
                )
            }

            // 参考情報）初当り確率
            unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTableDenominate(
                        columTitle: "CZ",
                        denominateList: kanokari.ratioFirstHitCz
                    )
                    unitTableDenominate(
                        columTitle: "初当り",
                        denominateList: kanokari.ratioFirstHitBonus
                    )
                }
            }

            // //// 95%信頼区間グラフへのリンク
            unitNaviLink95Ci(
                Ci95view: AnyView(
                    kanokariView95Ci(
                        kanokari: kanokari,
                        selection: 2,
                    )
                )
            )

            // //// 設定期待値へのリンク
            unitNaviLinkBayes {
                kanokariViewBayes(
                    kanokari: kanokari,
                )
            }
            
            // REG連続天井
            Section {
                // 確率横並び（その回数に到達したときの天井率）
                HStack {
                    // 3回目
                    unitResultRatioPercent2Line(
                        title: "3回目",
                        count: $kanokari.regTenjo3CountHit,
                        bigNumber: $kanokari.regTenjo3CountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 4回目
                    unitResultRatioPercent2Line(
                        title: "4回目",
                        count: $kanokari.regTenjo4CountHit,
                        bigNumber: $kanokari.regTenjo4CountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 5回目
                    unitResultRatioPercent2Line(
                        title: "5回目",
                        count: $kanokari.regTenjo5CountHit,
                        bigNumber: $kanokari.regTenjo5CountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .popoverTip(tipVer491KanokariRegTenjo())

//                unitLinkButtonViewBuilder(sheetTitle: "REG連続天井について") {
//                    VStack(alignment: .leading) {
//                        Text("・REG連続天井の振分けは3〜6回")
//                        Text("・高設定ほど少ない回数の振り分けが優遇")
//                        Text("・天井到達時はボーナスが裏かのかりボーナスに昇格する")
//                    }
//                }

                // 参考情報）REG連続天井の振分け
                unitLinkButtonViewBuilder(sheetTitle: "REG連続天井の振分け") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "3回",
                            percentList: kanokari.ratioRegTenjo3,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "4回",
                            percentList: kanokari.ratioRegTenjo4,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "5回",
                            percentList: kanokari.ratioRegTenjo5,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "6回",
                            percentList: kanokari.ratioRegTenjo6,
                            numberofDicimal: 1,
                        )
                    }
//                    .padding(.bottom)
//                    VStack(alignment: .leading) {
//                        Text("・その回数まで天井が来ずに到達したときの天井率")
//                        Text("・振分けから算出（6回目は必ず天井）")
//                    }
//                    HStack(spacing: 0) {
//                        unitTableSettingIndex()
//                        unitTablePercent(
//                            columTitle: "3回目",
//                            percentList: kanokari.ratioRegTenjoStage3,
//                            numberofDicimal: 1,
//                        )
//                        unitTablePercent(
//                            columTitle: "4回目",
//                            percentList: kanokari.ratioRegTenjoStage4,
//                            numberofDicimal: 1,
//                        )
//                        unitTablePercent(
//                            columTitle: "5回目",
//                            percentList: kanokari.ratioRegTenjoStage5,
//                            numberofDicimal: 0,
//                        )
//                    }
                }

                // カウント
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("・天井到達時は裏かのかりBONUS濃厚のため、裏かのかりでない場合は天井なしでカウント")
                        Text("・その回数に到達する前にBIGに当選した場合はカウントしない")
                    }
                    // セグメントピッカー
                    Picker("", selection: self.$regTenjoSelected) {
                        ForEach(self.regTenjoSegmentList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)

                    // カウントボタン横並び
                    HStack {
                        if self.regTenjoSelected == self.regTenjoSegmentList[0] {
                            // 天井なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井なし",
                                count: $kanokari.regTenjo3CountMiss,
                                color: .personalSummerLightBlue,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.regTenjo3SumFunc()
                                }
                            // 天井あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井あり",
                                count: $kanokari.regTenjo3CountHit,
                                color: .personalSummerLightRed,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.regTenjo3SumFunc()
                                }
                        }
                        else if self.regTenjoSelected == self.regTenjoSegmentList[1] {
                            // 天井なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井なし",
                                count: $kanokari.regTenjo4CountMiss,
                                color: .personalSummerLightBlue,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.regTenjo4SumFunc()
                                }
                            // 天井あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井あり",
                                count: $kanokari.regTenjo4CountHit,
                                color: .personalSummerLightRed,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.regTenjo4SumFunc()
                                }
                        }
                        else if self.regTenjoSelected == self.regTenjoSegmentList[2] {
                            // 天井なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井なし",
                                count: $kanokari.regTenjo5CountMiss,
                                color: .personalSummerLightBlue,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.regTenjo5SumFunc()
                                }
                            // 天井あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井あり",
                                count: $kanokari.regTenjo5CountHit,
                                color: .personalSummerLightRed,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.regTenjo5SumFunc()
                                }
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            kanokariView95Ci(
                                kanokari: kanokari,
                                selection: 11 + (self.regTenjoSegmentList.firstIndex(of: self.regTenjoSelected) ?? 0),
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        kanokariViewBayes(
                            kanokari: kanokari,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("REG連続天井")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kanokariMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kanokari.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
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
                unitButtonMinusCheck(minusCheck: $kanokari.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kanokari.resetFirstHit)
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
    kanokariViewFirstHit(
        kanokari: Kanokari(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

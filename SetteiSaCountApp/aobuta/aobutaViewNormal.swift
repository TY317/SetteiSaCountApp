//
//  aobutaViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct aobutaViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var aobuta: Aobuta
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

    // 選択中の小役（0=🍒 / 1=ﾁｬﾝｽ目）
    @State var selectedKoyakuIndex: Int = 0
    let koyakuList: [String] = ["🍒", "ﾁｬﾝｽ目"]

    var body: some View {
        List {
            // ---- アオハルチャンス当選率
            Section {
                // 小役ごとの当選率
                HStack {
                    // 🍒
                    unitResultRatioPercent2Line(
                        title: "🍒",
                        count: $aobuta.aoharuCherryCountHit,
                        bigNumber: $aobuta.aoharuCherryCount,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // ﾁｬﾝｽ目
                    unitResultRatioPercent2Line(
                        title: "ﾁｬﾝｽ目",
                        count: $aobuta.aoharuChanceCountHit,
                        bigNumber: $aobuta.aoharuChanceCount,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // 参考情報）アオハルチャンス当選率
                unitLinkButtonViewBuilder(sheetTitle: "アオハルチャンス当選率") {
                    VStack(spacing: 20) {
                        VStack(spacing: 7) {
                            Text("[通常滞在時]")
                                .font(.title3)
                                .fontWeight(.bold)
                            HStack(spacing: 0) {
                                unitTableSettingIndex(settingList: [2,3,4,5,6])
                                unitTablePercent(
                                    columTitle: "🍉",
                                    percentList: aobuta.ratioAoharuSuika,
                                    numberofDicimal: 1,
                                )
                                unitTablePercent(
                                    columTitle: "🍒",
                                    percentList: aobuta.ratioAoharuCherry,
                                    numberofDicimal: 1,
                                )
                                unitTablePercent(
                                    columTitle: "ﾁｬﾝｽ目",
                                    percentList: aobuta.ratioAoharuChance,
                                    numberofDicimal: 1,
                                )
                            }
                        }
                        VStack(spacing: 7) {
                            Text("[高確・リラックス滞在時]")
                                .font(.title3)
                                .fontWeight(.bold)
                            HStack(spacing: 0) {
                                unitTableString(
                                    columTitle: "",
                                    stringList: ["全設定共通"],
                                    maxWidth: 90,
                                    contentFont: .subheadline,
                                )
                                unitTablePercent(
                                    columTitle: "🍉",
                                    percentList: aobuta.ratioAoharuHighSuika,
                                    numberofDicimal: 1,
                                )
                                unitTablePercent(
                                    columTitle: "🍒",
                                    percentList: aobuta.ratioAoharuHighCherry,
                                    numberofDicimal: 1,
                                )
                                unitTablePercent(
                                    columTitle: "ﾁｬﾝｽ目",
                                    percentList: aobuta.ratioAoharuHighChance,
                                    numberofDicimal: 1,
                                )
                            }
                        }
//                        Text("・設定差があるのは通常滞在時の🍒とﾁｬﾝｽ目\n・高確・リラックス滞在時は当選率が異なるためカウント対象外")
//                            .foregroundStyle(Color.secondary)
//                            .font(.caption)
                    }
                }

                // カウント
                DisclosureGroup {
                    // 小役セグメントピッカー
                    Picker("", selection: self.$selectedKoyakuIndex) {
                        ForEach(self.koyakuList.indices, id: \.self) { index in
                            Text(self.koyakuList[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(.segmented)

                    // カウントボタン横並び
                    HStack {
                        // 成立
                        unitCountButtonWithoutRatioWithFunc(
                            title: "小役成立",
                            count: self.selectedKoyakuIndex == 0 ? $aobuta.aoharuCherryCount : $aobuta.aoharuChanceCount,
                            color: self.selectedKoyakuIndex == 0 ? .personalSummerLightRed : .personalSummerLightPurple,
                            minusBool: $aobuta.minusCheck) { }
                        // 当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: self.selectedKoyakuIndex == 0 ? $aobuta.aoharuCherryCountHit : $aobuta.aoharuChanceCountHit,
                            color: self.selectedKoyakuIndex == 0 ? .red : .purple,
                            minusBool: $aobuta.minusCheck) { }
                    }
                    // 小役ごとにボタンのidentityを分ける
                    // （unitCountButtonWithoutRatioWithFunc の title/color は @State のため、
                    //   identityを変えないと切替時に色が更新されない）
                    .id("aoharu-\(self.selectedKoyakuIndex)")

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            aobutaView95Ci(
                                aobuta: aobuta,
                                selection: self.selectedKoyakuIndex == 0 ? 4 : 5,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        aobutaViewBayes(
                            aobuta: aobuta,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("アオハルチャンス当選率")
            }
            
            // ---- アオハルチャンス確率
            Section {
                // アオハルチャンス確率
                unitResultRatioDenomination2Line(
                    title: "アオハルチャンス確率",
                    count: $aobuta.aoharuCount,
                    bigNumber: $aobuta.aoharuGame,
                    numberofDicimal: 1
                )

                // 参考情報）アオハルチャンス確率
                unitLinkButtonViewBuilder(sheetTitle: "アオハルチャンス確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [2,3,4,5,6])
                        unitTableDenominate(
                            columTitle: "アオハル",
                            denominateList: aobuta.ratioAoharu,
                            numberofDicimal: 1,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン
                    HStack {
                        // アオハルチャンス
                        unitCountButtonWithoutRatioWithFunc(
                            title: "アオハルチャンス",
                            count: $aobuta.aoharuCount,
                            color: .personalSummerLightBlue,
                            minusBool: $aobuta.minusCheck) { }
                    }

                    // ゲーム数（初当りの通常ゲーム数とは別管理）
                    unitTextFieldNumberInputWithUnit(
                        title: "ゲーム数",
                        inputValue: $aobuta.aoharuGame,
                        unitText: "Ｇ",
                    )
                    .focused(self.$isFocused)

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            aobutaView95Ci(
                                aobuta: aobuta,
                                selection: 6,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        aobutaViewBayes(
                            aobuta: aobuta,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("アオハルチャンス確率")
            }

            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    aobutaTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
            
            // 不可思議モード
            Section {
                // 参考情報）不可思議モード
                unitLinkButtonViewBuilder(sheetTitle: "不可思議モードについて") {
                    aobutaTableFukashigiMode()
                }
            } header: {
                Text("モード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.aobutaMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: aobuta.machineName,
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
                unitButtonMinusCheck(minusCheck: $aobuta.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: aobuta.resetNormal)
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
    aobutaViewNormal(
        aobuta: Aobuta(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

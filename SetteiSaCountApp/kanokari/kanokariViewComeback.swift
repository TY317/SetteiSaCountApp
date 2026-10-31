//
//  kanokariViewComeback.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kanokariViewComeback: View {
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
    // ななかりDREAMのモード選択
    let dreamSegmentList: [String] = ["非ユメカノ", "ユメカノ"]
    @State var dreamSelected: String = "非ユメカノ"

    var body: some View {
        List {
//            // 引き戻し
//            Section {
//                VStack(alignment: .leading) {
//                    Text("・通常の引き戻し状態での引き戻し期待度は25%で設定差なし")
//                    Text("・高設定ほど引き戻し時にななかりドリームになりやすい")
//                    Text("・ユメカノモード中は引き戻し期待度、ななかりドリーム昇格率ともに高設定ほど優遇")
//                }
//            }

            // ---- 引き戻し期待度（ユメカノモード）
            Section {
                // 引き戻し率
                unitResultRatioPercent2Line(
                    title: "引き戻し率",
                    count: $kanokari.comebackYumekanoCountHit,
                    bigNumber: $kanokari.comebackYumekanoCountSum,
                    numberofDicimal: 0
                )
                .popoverTip(tipVer491KanokariComeback())

                // 参考情報）引き戻し期待度
                unitLinkButtonViewBuilder(sheetTitle: "引き戻し期待度") {
                    VStack(alignment: .leading) {
                        Text("・ユメカノモードの引き戻し期待度は高設定ほど優遇")
                        Text("・非ユメカノモードは設定差なし")
                        Text("・フェイク前兆中の強チャンス目による引き戻し書き換え（20.3%）は全設定共通のため除外")
                    }
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "非ユメカノ",
                            percentList: [kanokari.ratioComebackNormal[0]],
                            numberofDicimal: 1,
                            lineList: [6],
                            colorList: [.white]
                        )
                        unitTablePercent(
                            columTitle: "ユメカノ",
                            percentList: kanokari.ratioComebackYumekano,
                            numberofDicimal: 1,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("・ユメカノモード滞在時のみカウント")
                        Text("・フェイク前兆中の強チャンス目による引き戻しはカウント除外")
                    }
                    // カウントボタン横並び
                    HStack {
                        // 引き戻しなし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "引き戻しなし",
                            count: $kanokari.comebackYumekanoCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $kanokari.minusCheck) {
                                kanokari.comebackYumekanoSumFunc()
                            }
                        // 引き戻しあり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "引き戻しあり",
                            count: $kanokari.comebackYumekanoCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $kanokari.minusCheck) {
                                kanokari.comebackYumekanoSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            kanokariView95Ci(
                                kanokari: kanokari,
                                selection: 8,
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
                Text("引き戻し期待度")
            }

            // ---- ななかりDREAM当選率
            Section {
                // 確率横並び
                HStack {
                    // 非ユメカノ
                    unitResultRatioPercent2Line(
                        title: "非ユメカノ",
                        count: $kanokari.dreamNormalCountHit,
                        bigNumber: $kanokari.dreamNormalCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // ユメカノ
                    unitResultRatioPercent2Line(
                        title: "ユメカノ",
                        count: $kanokari.dreamYumekanoCountHit,
                        bigNumber: $kanokari.dreamYumekanoCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // 参考情報）ななかりDREAM当選率
                unitLinkButtonViewBuilder(sheetTitle: "ななかりDREAM当選率") {
                    VStack(alignment: .leading) {
                        Text("・引き戻し当選時のななかりDREAM振分け")
                        Text("・ユメカノモード滞在の有無に関わらず、高設定ほど引き戻し時にななかりDREAMが選ばれやすい")
                    }
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "非ユメカノ",
                            percentList: kanokari.ratioDreamNormal,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "ユメカノ",
                            percentList: kanokari.ratioDreamYumekano,
                            numberofDicimal: 0,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
//                    // 注意書き
//                    unitLabelCautionText {
//                        Text("・引き戻し当選時のみカウント")
//                    }
                    // セグメントピッカー
                    Picker("", selection: self.$dreamSelected) {
                        ForEach(self.dreamSegmentList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)

                    // カウントボタン横並び
                    HStack {
                        if self.dreamSelected == self.dreamSegmentList[0] {
                            // DREAMなし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "DREAMなし",
                                count: $kanokari.dreamNormalCountMiss,
                                color: .personalSummerLightBlue,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.dreamNormalSumFunc()
                                }
                            // DREAMあり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "DREAMあり",
                                count: $kanokari.dreamNormalCountHit,
                                color: .personalSummerLightRed,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.dreamNormalSumFunc()
                                }
                        }
                        else if self.dreamSelected == self.dreamSegmentList[1] {
                            // DREAMなし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "DREAMなし",
                                count: $kanokari.dreamYumekanoCountMiss,
                                color: .personalSummerLightBlue,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.dreamYumekanoSumFunc()
                                }
                            // DREAMあり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "DREAMあり",
                                count: $kanokari.dreamYumekanoCountHit,
                                color: .personalSummerLightRed,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.dreamYumekanoSumFunc()
                                }
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            kanokariView95Ci(
                                kanokari: kanokari,
                                selection: 9 + (self.dreamSegmentList.firstIndex(of: self.dreamSelected) ?? 0),
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
                Text("ななかりDREAM当選率")
            }

        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kanokariMenuComebackBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kanokari.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("引き戻し")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: kanokari.resetComeback)
            }
        }
    }
}

#Preview {
    kanokariViewComeback(
        kanokari: Kanokari(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

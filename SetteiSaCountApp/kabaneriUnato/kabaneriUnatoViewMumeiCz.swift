//
//  kabaneriUnatoViewMumeiCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kabaneriUnatoViewMumeiCz: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var kabaneriUnato: KabaneriUnato
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
    // 撃破数の選択
    let killSegmentList: [String] = ["7撃破", "8撃破", "9撃破"]
    @State var killSelected: String = "7撃破"

    var body: some View {
        List {
            // ---- 撃破数別ボーナス期待度
            Section {
                // 確率横並び
                HStack {
                    // 7撃破
                    unitResultRatioPercent2Line(
                        title: "7撃破",
                        count: $kabaneriUnato.mumeiCz7CountHit,
                        bigNumber: $kabaneriUnato.mumeiCz7CountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 8撃破
                    unitResultRatioPercent2Line(
                        title: "8撃破",
                        count: $kabaneriUnato.mumeiCz8CountHit,
                        bigNumber: $kabaneriUnato.mumeiCz8CountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 9撃破
                    unitResultRatioPercent2Line(
                        title: "9撃破",
                        count: $kabaneriUnato.mumeiCz9CountHit,
                        bigNumber: $kabaneriUnato.mumeiCz9CountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .popoverTip(tipVer491KabaneriUnatoMumeiCz())

                // 参考情報）撃破数別ボーナス期待度
                unitLinkButtonViewBuilder(sheetTitle: "撃破数別ボーナス期待度") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "7撃破",
                            percentList: kabaneriUnato.ratioMumeiCz7,
                            numberofDicimal: 0,
                        )
                        unitTablePercent(
                            columTitle: "8撃破",
                            percentList: kabaneriUnato.ratioMumeiCz8,
                            numberofDicimal: 0,
                        )
                        unitTablePercent(
                            columTitle: "9撃破",
                            percentList: kabaneriUnato.ratioMumeiCz9,
                            numberofDicimal: 0,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // セグメントピッカー
                    Picker("", selection: self.$killSelected) {
                        ForEach(self.killSegmentList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)

                    // カウントボタン横並び
                    HStack {
                        if self.killSelected == self.killSegmentList[0] {
                            // ハズレ
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ハズレ",
                                count: $kabaneriUnato.mumeiCz7CountMiss,
                                color: .personalSummerLightBlue,
                                minusBool: $kabaneriUnato.minusCheck) {
                                    kabaneriUnato.mumeiCz7SumFunc()
                                }
                            // 当選
                            unitCountButtonWithoutRatioWithFunc(
                                title: "当選",
                                count: $kabaneriUnato.mumeiCz7CountHit,
                                color: .blue,
                                minusBool: $kabaneriUnato.minusCheck) {
                                    kabaneriUnato.mumeiCz7SumFunc()
                                }
                        }
                        else if self.killSelected == self.killSegmentList[1] {
                            // ハズレ
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ハズレ",
                                count: $kabaneriUnato.mumeiCz8CountMiss,
                                color: .personalSummerLightGreen,
                                minusBool: $kabaneriUnato.minusCheck) {
                                    kabaneriUnato.mumeiCz8SumFunc()
                                }
                            // 当選
                            unitCountButtonWithoutRatioWithFunc(
                                title: "当選",
                                count: $kabaneriUnato.mumeiCz8CountHit,
                                color: .green,
                                minusBool: $kabaneriUnato.minusCheck) {
                                    kabaneriUnato.mumeiCz8SumFunc()
                                }
                        }
                        else if self.killSelected == self.killSegmentList[2] {
                            // ハズレ
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ハズレ",
                                count: $kabaneriUnato.mumeiCz9CountMiss,
                                color: .personalSummerLightRed,
                                minusBool: $kabaneriUnato.minusCheck) {
                                    kabaneriUnato.mumeiCz9SumFunc()
                                }
                            // 当選
                            unitCountButtonWithoutRatioWithFunc(
                                title: "当選",
                                count: $kabaneriUnato.mumeiCz9CountHit,
                                color: .red,
                                minusBool: $kabaneriUnato.minusCheck) {
                                    kabaneriUnato.mumeiCz9SumFunc()
                                }
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            kabaneriUnatoView95Ci(
                                kabaneriUnato: kabaneriUnato,
                                selection: 7 + (self.killSegmentList.firstIndex(of: self.killSelected) ?? 0),
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        kabaneriUnatoViewBayes(
                            kabaneriUnato: kabaneriUnato,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("撃破数別ボーナス期待度")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kabaneriUnatoMenuMumeiCzBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kabaneriUnato.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("無名CZ")
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
                unitButtonMinusCheck(minusCheck: $kabaneriUnato.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kabaneriUnato.resetMumeiCz)
            }
        }
    }
}

#Preview {
    kabaneriUnatoViewMumeiCz(
        kabaneriUnato: KabaneriUnato(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

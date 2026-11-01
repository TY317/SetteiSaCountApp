//
//  goeva2ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct goeva2ViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var goeva2: Goeva2
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
    let bonusStateItems: [String] = ["通常", "高確", "超高確"]
    @State var selectedBonusState: String = "通常"
    let bonusGroupItems: [String] = ["弱レア系", "強レア系①", "強レア系②"]
    @State var selectedBonusGroup: String = "弱レア系"

    var body: some View {
        List {
            // ---- スイカ成立時のCZ当選率
            Section {
                // 当選率
                unitResultRatioPercent2Line(
                    title: "🍉→CZ",
                    count: $goeva2.suikaCzCount,
                    bigNumber: $goeva2.suikaCount,
                    numberofDicimal: 0
                )

                // 参考情報）スイカ成立時のCZ当選率
                unitLinkButtonViewBuilder(sheetTitle: "🍉からのCZ当選率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "CZ",
                            percentList: goeva2.ratioSuikaCz,
                            numberofDicimal: 0,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // スイカ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "🍉成立",
                            count: $goeva2.suikaCount,
                            color: .personalSummerLightGreen,
                            minusBool: $goeva2.minusCheck) {
                            }
                        // CZ当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "CZ当選",
                            count: $goeva2.suikaCzCount,
                            color: .personalSummerLightPurple,
                            minusBool: $goeva2.minusCheck) {
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            goeva2View95Ci(
                                goeva2: goeva2,
                                selection: 1,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        goeva2ViewBayes(
                            goeva2: goeva2,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("🍉からのCZ当選率")
            }

            // ---- レア役からのボーナス当選率
            Section {
                // 状態のセグメントピッカー
                Picker("", selection: self.$selectedBonusState) {
                    ForEach(self.bonusStateItems, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)

                // 確率横並び
                HStack {
                    // 通常
                    if self.selectedBonusState == self.bonusStateItems[0] {
                        // 弱レア系
                        unitResultRatioPercent2Line(
                            title: "弱レア系",
                            count: $goeva2.bonusNormalWeakCountHit,
                            bigNumber: $goeva2.bonusNormalWeakCount,
                            numberofDicimal: 1,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                        // 強レア系①
                        unitResultRatioPercent2Line(
                            title: "強レア系①",
                            count: $goeva2.bonusNormalStrong1CountHit,
                            bigNumber: $goeva2.bonusNormalStrong1Count,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                        // 強レア系②
                        unitResultRatioPercent2Line(
                            title: "強レア系②",
                            count: $goeva2.bonusNormalStrong2CountHit,
                            bigNumber: $goeva2.bonusNormalStrong2Count,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                    }
                    // 高確
                    else if self.selectedBonusState == self.bonusStateItems[1] {
                        // 弱レア系
                        unitResultRatioPercent2Line(
                            title: "弱レア系",
                            count: $goeva2.bonusHighWeakCountHit,
                            bigNumber: $goeva2.bonusHighWeakCount,
                            numberofDicimal: 1,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                        // 強レア系①
                        unitResultRatioPercent2Line(
                            title: "強レア系①",
                            count: $goeva2.bonusHighStrong1CountHit,
                            bigNumber: $goeva2.bonusHighStrong1Count,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                        // 強レア系②
                        unitResultRatioPercent2Line(
                            title: "強レア系②",
                            count: $goeva2.bonusHighStrong2CountHit,
                            bigNumber: $goeva2.bonusHighStrong2Count,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                    }
                    // 超高確は弱レア系のみ設定差あり
                    else {
                        // 弱レア系
                        unitResultRatioPercent2Line(
                            title: "弱レア系",
                            count: $goeva2.bonusSuperWeakCountHit,
                            bigNumber: $goeva2.bonusSuperWeakCount,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // 参考情報）ボーナス当選率
                unitLinkButtonViewBuilder(sheetTitle: "\(self.selectedBonusState)時のボーナス当選率") {
                    VStack {
//                        Text("・設定1のみ判明")
//                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            // 通常
                            if self.selectedBonusState == self.bonusStateItems[0] {
                                unitTablePercent(
                                    columTitle: "弱レア系",
                                    percentList: goeva2.ratioBonusNormalWeak,
                                    numberofDicimal: 1,
                                )
                                unitTablePercent(
                                    columTitle: "強レア系①",
                                    percentList: goeva2.ratioBonusNormalStrong1,
                                    numberofDicimal: 0,
                                )
                                unitTablePercent(
                                    columTitle: "強レア系②",
                                    percentList: goeva2.ratioBonusNormalStrong2,
                                    numberofDicimal: 0,
                                )
                            }
                            // 高確
                            else if self.selectedBonusState == self.bonusStateItems[1] {
                                unitTablePercent(
                                    columTitle: "弱レア系",
                                    percentList: goeva2.ratioBonusHighWeak,
                                    numberofDicimal: 1,
                                )
                                unitTablePercent(
                                    columTitle: "強レア系①",
                                    percentList: goeva2.ratioBonusHighStrong1,
                                    numberofDicimal: 0,
                                )
                                unitTablePercent(
                                    columTitle: "強レア系②",
                                    percentList: goeva2.ratioBonusHighStrong2,
                                    numberofDicimal: 0,
                                )
                            }
                            // 超高確
                            else {
                                unitTablePercent(
                                    columTitle: "弱レア系",
                                    percentList: goeva2.ratioBonusSuperWeak,
                                    numberofDicimal: 0,
                                )
                                unitTablePercent(
                                    columTitle: "強レア系①",
                                    percentList: [100],
                                    numberofDicimal: 0,
                                    lineList: [6],
                                    colorList: [.white],
                                )
                                unitTablePercent(
                                    columTitle: "強レア系②",
                                    percentList: [100],
                                    numberofDicimal: 0,
                                    lineList: [6],
                                    colorList: [.white],
                                )
                            }
                        }
//                        // 超高確の強レア系はカウントしないので注記
//                        if self.selectedBonusState == self.bonusStateItems[2] {
//                            Text("・強レア系①②は全設定100%")
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                        }
                    }
                }

                // 参考情報）成立役のグループ
                unitLinkButtonViewBuilder(sheetTitle: "成立役のグループ") {
                    VStack {
                        HStack(spacing: 0) {
                            unitTableString(
                                columTitle: "グループ",
                                stringList: ["弱レア系", "強レア系①", "強レア系②", "確定役系"],
                                maxWidth: 80,
                                lineList: [2,4,2,4],
                            )
                            unitTableString(
                                columTitle: "成立役",
                                stringList: [
                                    "弱🍒\n🔔3連",
                                    "強レア役\n🔔4連\n弱レア役2連\n強レア役の次Gで弱レア役",
                                    "弱レア役の次Gで強レア役",
                                    "リーチ目役\n🔔5連以上\n弱レア役3連以上\n強レア役2連以上",
                                ],
                                maxWidth: 250,
                                lineList: [2,4,2,4],
                            )
                        }
                        Text("・確定役系は全設定・全状態で100%")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                // カウント
                DisclosureGroup {
                    // グループのセグメントピッカー（超高確は弱レア系のみなので非表示）
                    if self.selectedBonusState != self.bonusStateItems[2] {
                        Picker("", selection: self.$selectedBonusGroup) {
                            ForEach(self.bonusGroupItems, id: \.self) { item in
                                Text(item)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    // カウントボタン横並び
                    HStack {
                        // 超高確 弱レア系
                        if self.selectedBonusState == self.bonusStateItems[2] {
                            unitCountButtonWithoutRatioWithFunc(
                                title: "弱レア系成立",
                                count: $goeva2.bonusSuperWeakCount,
                                color: .personalSummerLightBlue,
                                minusBool: $goeva2.minusCheck) {
                                }
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ボーナス当選",
                                count: $goeva2.bonusSuperWeakCountHit,
                                color: .blue,
                                minusBool: $goeva2.minusCheck) {
                                }
                        }
                        // 通常
                        else if self.selectedBonusState == self.bonusStateItems[0] {
                            // 通常 弱レア系
                            if self.selectedBonusGroup == self.bonusGroupItems[0] {
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "弱レア系成立",
                                    count: $goeva2.bonusNormalWeakCount,
                                    color: .personalSummerLightBlue,
                                    minusBool: $goeva2.minusCheck) {
                                    }
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "ボーナス当選",
                                    count: $goeva2.bonusNormalWeakCountHit,
                                    color: .blue,
                                    minusBool: $goeva2.minusCheck) {
                                    }
                            }
                            // 通常 強レア系①
                            else if self.selectedBonusGroup == self.bonusGroupItems[1] {
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "強レア系①成立",
                                    count: $goeva2.bonusNormalStrong1Count,
                                    color: .personalSummerLightRed,
                                    minusBool: $goeva2.minusCheck) {
                                    }
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "ボーナス当選",
                                    count: $goeva2.bonusNormalStrong1CountHit,
                                    color: .red,
                                    minusBool: $goeva2.minusCheck) {
                                    }
                            }
                            // 通常 強レア系②
                            else {
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "強レア系②成立",
                                    count: $goeva2.bonusNormalStrong2Count,
                                    color: .personalSummerLightPurple,
                                    minusBool: $goeva2.minusCheck) {
                                    }
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "ボーナス当選",
                                    count: $goeva2.bonusNormalStrong2CountHit,
                                    color: .purple,
                                    minusBool: $goeva2.minusCheck) {
                                    }
                            }
                        }
                        // 高確
                        else {
                            // 高確 弱レア系
                            if self.selectedBonusGroup == self.bonusGroupItems[0] {
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "弱レア系成立",
                                    count: $goeva2.bonusHighWeakCount,
                                    color: .personalSummerLightBlue,
                                    minusBool: $goeva2.minusCheck) {
                                    }
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "ボーナス当選",
                                    count: $goeva2.bonusHighWeakCountHit,
                                    color: .blue,
                                    minusBool: $goeva2.minusCheck) {
                                    }
                            }
                            // 高確 強レア系①
                            else if self.selectedBonusGroup == self.bonusGroupItems[1] {
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "強レア系①成立",
                                    count: $goeva2.bonusHighStrong1Count,
                                    color: .personalSummerLightRed,
                                    minusBool: $goeva2.minusCheck) {
                                    }
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "ボーナス当選",
                                    count: $goeva2.bonusHighStrong1CountHit,
                                    color: .red,
                                    minusBool: $goeva2.minusCheck) {
                                    }
                            }
                            // 高確 強レア系②
                            else {
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "強レア系②成立",
                                    count: $goeva2.bonusHighStrong2Count,
                                    color: .personalSummerLightPurple,
                                    minusBool: $goeva2.minusCheck) {
                                    }
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "ボーナス当選",
                                    count: $goeva2.bonusHighStrong2CountHit,
                                    color: .purple,
                                    minusBool: $goeva2.minusCheck) {
                                    }
                            }
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            goeva2View95Ci(
                                goeva2: goeva2,
                                selection: self.bonus95CiTag(),
                            )
                        )
                    )
                    // Ci95viewは@Stateで初回の値を保持するので、選択が変わったら作り直す
                    .id(self.bonus95CiTag())
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("レア役からのボーナス当選率")
            }

            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    goeva2TableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.goeva2MenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: goeva2.machineName,
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
                unitButtonMinusCheck(minusCheck: $goeva2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: goeva2.resetNormal)
            }
        }
    }

    // 選択中の状態・グループに対応する95Ciグラフのタグ（通常2〜4、高確5〜7、超高確8）
    private func bonus95CiTag() -> Int {
        if self.selectedBonusState == self.bonusStateItems[2] {
            return 8
        }
        let stateIndex = self.bonusStateItems.firstIndex(of: self.selectedBonusState) ?? 0
        let groupIndex = self.bonusGroupItems.firstIndex(of: self.selectedBonusGroup) ?? 0
        return 2 + stateIndex * 3 + groupIndex
    }
}

#Preview {
    goeva2ViewNormal(
        goeva2: Goeva2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

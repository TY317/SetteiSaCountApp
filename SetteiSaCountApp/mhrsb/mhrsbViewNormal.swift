//
//  mhrsbViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct mhrsbViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var mhrsb: Mhrsb
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
    let rareBzStateItems: [String] = ["通常", "高確", "超高確"]
    @State var selectedRareBzState: String = "通常"
    let rareBzGroupItems: [String] = ["弱レア役", "強レア役"]
    @State var selectedRareBzGroup: String = "弱レア役"

    var body: some View {
        List {
            // ---- レア役からのBZ当選率
            Section {
                // 状態のセグメントピッカー
                Picker("", selection: self.$selectedRareBzState) {
                    ForEach(self.rareBzStateItems, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)

                // 確率横並び
                HStack {
                    // 通常
                    if self.selectedRareBzState == self.rareBzStateItems[0] {
                        // 弱レア役
                        unitResultRatioPercent2Line(
                            title: "弱レア役→BZ",
                            count: $mhrsb.rareBzNormalWeakCountHit,
                            bigNumber: $mhrsb.rareBzNormalWeakCount,
                            numberofDicimal: 1,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                        // 強レア役
                        unitResultRatioPercent2Line(
                            title: "強レア役→BZ",
                            count: $mhrsb.rareBzNormalStrongCountHit,
                            bigNumber: $mhrsb.rareBzNormalStrongCount,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                    }
                    // 高確
                    else if self.selectedRareBzState == self.rareBzStateItems[1] {
                        // 弱レア役
                        unitResultRatioPercent2Line(
                            title: "弱レア役→BZ",
                            count: $mhrsb.rareBzHighWeakCountHit,
                            bigNumber: $mhrsb.rareBzHighWeakCount,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                        // 強レア役
                        unitResultRatioPercent2Line(
                            title: "強レア役→BZ",
                            count: $mhrsb.rareBzHighStrongCountHit,
                            bigNumber: $mhrsb.rareBzHighStrongCount,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                    }
                    // 超高確は弱レア役のみ設定差あり
                    else {
                        // 弱レア役
                        unitResultRatioPercent2Line(
                            title: "弱レア役→BZ",
                            count: $mhrsb.rareBzSuperWeakCountHit,
                            bigNumber: $mhrsb.rareBzSuperWeakCount,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // 参考情報）BZ当選率
                unitLinkButtonViewBuilder(sheetTitle: "\(self.selectedRareBzState)時のBZ当選率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        // 通常
                        if self.selectedRareBzState == self.rareBzStateItems[0] {
                            unitTablePercent(
                                columTitle: "弱レア役",
                                percentList: mhrsb.ratioRareBzNormalWeak,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "強レア役",
                                percentList: mhrsb.ratioRareBzNormalStrong,
                                numberofDicimal: 0,
                            )
                        }
                        // 高確
                        else if self.selectedRareBzState == self.rareBzStateItems[1] {
                            unitTablePercent(
                                columTitle: "弱レア役",
                                percentList: mhrsb.ratioRareBzHighWeak,
                                numberofDicimal: 0,
                            )
                            unitTablePercent(
                                columTitle: "強レア役",
                                percentList: mhrsb.ratioRareBzHighStrong,
                                numberofDicimal: 0,
                            )
                        }
                        // 超高確
                        else {
                            unitTablePercent(
                                columTitle: "弱レア役",
                                percentList: mhrsb.ratioRareBzSuperWeak,
                                numberofDicimal: 0,
                            )
                            unitTablePercent(
                                columTitle: "強レア役",
                                percentList: [100],
                                numberofDicimal: 0,
                                lineList: [6],
                                colorList: [.white],
                            )
                        }
                    }
                }

                // カウント
                DisclosureGroup {
                    // レア役のセグメントピッカー（超高確は弱レア役のみなので非表示）
                    if self.selectedRareBzState != self.rareBzStateItems[2] {
                        Picker("", selection: self.$selectedRareBzGroup) {
                            ForEach(self.rareBzGroupItems, id: \.self) { item in
                                Text(item)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    // カウントボタン横並び
                    HStack {
                        // 超高確 弱レア役
                        if self.selectedRareBzState == self.rareBzStateItems[2] {
                            unitCountButtonWithoutRatioWithFunc(
                                title: "弱レア役成立",
                                count: $mhrsb.rareBzSuperWeakCount,
                                color: .personalSummerLightBlue,
                                minusBool: $mhrsb.minusCheck) {
                                }
                            unitCountButtonWithoutRatioWithFunc(
                                title: "BZ当選",
                                count: $mhrsb.rareBzSuperWeakCountHit,
                                color: .blue,
                                minusBool: $mhrsb.minusCheck) {
                                }
                        }
                        // 通常
                        else if self.selectedRareBzState == self.rareBzStateItems[0] {
                            // 通常 弱レア役
                            if self.selectedRareBzGroup == self.rareBzGroupItems[0] {
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "弱レア役成立",
                                    count: $mhrsb.rareBzNormalWeakCount,
                                    color: .personalSummerLightBlue,
                                    minusBool: $mhrsb.minusCheck) {
                                    }
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "BZ当選",
                                    count: $mhrsb.rareBzNormalWeakCountHit,
                                    color: .blue,
                                    minusBool: $mhrsb.minusCheck) {
                                    }
                            }
                            // 通常 強レア役
                            else {
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "強レア役成立",
                                    count: $mhrsb.rareBzNormalStrongCount,
                                    color: .personalSummerLightRed,
                                    minusBool: $mhrsb.minusCheck) {
                                    }
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "BZ当選",
                                    count: $mhrsb.rareBzNormalStrongCountHit,
                                    color: .red,
                                    minusBool: $mhrsb.minusCheck) {
                                    }
                            }
                        }
                        // 高確
                        else {
                            // 高確 弱レア役
                            if self.selectedRareBzGroup == self.rareBzGroupItems[0] {
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "弱レア役成立",
                                    count: $mhrsb.rareBzHighWeakCount,
                                    color: .personalSummerLightBlue,
                                    minusBool: $mhrsb.minusCheck) {
                                    }
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "BZ当選",
                                    count: $mhrsb.rareBzHighWeakCountHit,
                                    color: .blue,
                                    minusBool: $mhrsb.minusCheck) {
                                    }
                            }
                            // 高確 強レア役
                            else {
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "強レア役成立",
                                    count: $mhrsb.rareBzHighStrongCount,
                                    color: .personalSummerLightRed,
                                    minusBool: $mhrsb.minusCheck) {
                                    }
                                unitCountButtonWithoutRatioWithFunc(
                                    title: "BZ当選",
                                    count: $mhrsb.rareBzHighStrongCountHit,
                                    color: .red,
                                    minusBool: $mhrsb.minusCheck) {
                                    }
                            }
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            mhrsbView95Ci(
                                mhrsb: mhrsb,
                                selection: self.rareBz95CiTag(),
                            )
                        )
                    )
                    // Ci95viewは@Stateで初回の値を保持するので、選択が変わったら作り直す
                    .id(self.rareBz95CiTag())

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        mhrsbViewBayes(
                            mhrsb: mhrsb,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("レア役からのBZ当選率")
            }

            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    mhrsbTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mhrsbMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mhrsb.machineName,
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
                unitButtonMinusCheck(minusCheck: $mhrsb.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mhrsb.resetNormal)
            }
        }
    }

    // 選択中の状態・レア役に対応する95Ciグラフのタグ（通常11〜12、高確13〜14、超高確15）
    private func rareBz95CiTag() -> Int {
        if self.selectedRareBzState == self.rareBzStateItems[2] {
            return 15
        }
        let stateIndex = self.rareBzStateItems.firstIndex(of: self.selectedRareBzState) ?? 0
        let groupIndex = self.rareBzGroupItems.firstIndex(of: self.selectedRareBzGroup) ?? 0
        return 11 + stateIndex * 2 + groupIndex
    }
}

#Preview {
    mhrsbViewNormal(
        mhrsb: Mhrsb(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

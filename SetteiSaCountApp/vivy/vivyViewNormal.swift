//
//  vivyViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct vivyViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var vivy: Vivy
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
    let accelStepItems: [String] = ["1回目", "2回目", "3回目", "4回目"]
    @State var selectedAccelStep: String = "1回目"
    let weakCherryStateItems: [String] = ["通常時", "変換高確Lv2", "変換高確Lv3"]
    @State var selectedWeakCherryState: String = "通常時"
    var body: some View {
        List {
            // ---- 弱チェリー確率
            Section {
                // 状態別の確率横並び
                HStack {
                    // 通常時
                    unitResultRatioDenomination2Line(
                        title: "通常時",
                        count: $vivy.weakCherryCountNormal,
                        bigNumber: $vivy.weakCherryGameNormal,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 変換高確Lv2
                    unitResultRatioDenomination2Line(
                        title: "Lv2",
                        count: $vivy.weakCherryCountHigh2,
                        bigNumber: $vivy.weakCherryGameHigh2,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 変換高確Lv3
                    unitResultRatioDenomination2Line(
                        title: "Lv3",
                        count: $vivy.weakCherryCountHigh3,
                        bigNumber: $vivy.weakCherryGameHigh3,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // 参考情報）弱チェリー確率
                unitLinkButtonViewBuilder(sheetTitle: "弱チェリー確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "通常時",
                            denominateList: vivy.ratioWeakCherryNormal,
                            numberofDicimal: 0,
                            titleFont: .subheadline,
                        )
                        unitTableDenominate(
                            columTitle: "変換高確Lv2",
                            denominateList: vivy.ratioWeakCherryHigh2,
                            numberofDicimal: 0,
                            titleFont: .subheadline,
                        )
                        unitTableDenominate(
                            columTitle: "変換高確Lv3",
                            denominateList: vivy.ratioWeakCherryHigh3,
                            numberofDicimal: 1,
                            titleFont: .subheadline,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // 状態のセグメントピッカー
                    Picker("", selection: self.$selectedWeakCherryState) {
                        ForEach(self.weakCherryStateItems, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)

                    // 通常時
                    if self.selectedWeakCherryState == self.weakCherryStateItems[0] {
                        unitTextFieldNumberInputWithUnit(
                            title: "通常時ゲーム数",
                            inputValue: $vivy.weakCherryGameNormal,
                            unitText: "Ｇ"
                        )
                        .focused(self.$isFocused)
                        unitCountButtonDenominateWithFunc(
                            title: "弱🍒",
                            count: $vivy.weakCherryCountNormal,
                            color: .personalSummerLightRed,
                            bigNumber: $vivy.weakCherryGameNormal,
                            numberofDicimal: 0,
                            minusBool: $vivy.minusCheck) {
                            }
                    }
                    // 変換高確Lv2
                    else if self.selectedWeakCherryState == self.weakCherryStateItems[1] {
                        unitTextFieldNumberInputWithUnit(
                            title: "変換高確Lv2ゲーム数",
                            inputValue: $vivy.weakCherryGameHigh2,
                            unitText: "Ｇ"
                        )
                        .focused(self.$isFocused)
                        unitCountButtonDenominateWithFunc(
                            title: "弱🍒",
                            count: $vivy.weakCherryCountHigh2,
                            color: .lightRed,
                            bigNumber: $vivy.weakCherryGameHigh2,
                            numberofDicimal: 0,
                            minusBool: $vivy.minusCheck) {
                            }
                    }
                    // 変換高確Lv3
                    else {
                        unitTextFieldNumberInputWithUnit(
                            title: "変換高確Lv3ゲーム数",
                            inputValue: $vivy.weakCherryGameHigh3,
                            unitText: "Ｇ"
                        )
                        .focused(self.$isFocused)
                        unitCountButtonDenominateWithFunc(
                            title: "弱🍒",
                            count: $vivy.weakCherryCountHigh3,
                            color: .red,
                            bigNumber: $vivy.weakCherryGameHigh3,
                            numberofDicimal: 1,
                            minusBool: $vivy.minusCheck) {
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            vivyView95Ci(
                                vivy: vivy,
                                selection: self.weakCherry95CiTag(),
                            )
                        )
                    )
                    // Ci95viewは@Stateで初回の値を保持するので、選択が変わったら作り直す
                    .id(self.weakCherry95CiTag())
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("弱チェリー確率")
            }
            
            // ---- アクセルチャンス昇格 継続回数
            Section {
                // 継続回数ごとの昇格率
                VStack {
                    Text("その回までに昇格しなかった場合の昇格率")
                        .font(.subheadline)
                        .foregroundStyle(Color.secondary)
                    HStack {
                        // 1回目
                        unitResultRatioPercent2Line(
                            title: "1回目",
                            count: $vivy.accelPromoteCountHit1,
                            bigNumber: $vivy.accelPromoteCountSum1,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                        // 2回目
                        unitResultRatioPercent2Line(
                            title: "2回目",
                            count: $vivy.accelPromoteCountHit2,
                            bigNumber: $vivy.accelPromoteCountSum2,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                        // 3回目
                        unitResultRatioPercent2Line(
                            title: "3回目",
                            count: $vivy.accelPromoteCountHit3,
                            bigNumber: $vivy.accelPromoteCountSum3,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                        // 4回目
                        unitResultRatioPercent2Line(
                            title: "4回目",
                            count: $vivy.accelPromoteCountHit4,
                            bigNumber: $vivy.accelPromoteCountSum4,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // 参考情報）実質の昇格率
                unitLinkButtonViewBuilder(sheetTitle: "実質の昇格率（独自算出）") {
                    VStack(alignment: .leading) {
                        Text("・継続回数の振分けから独自算出した確率")
                        Text("・その回まで昇格しなかった場合に、その回で昇格する確率")
                        Text("・5回目は全設定100%のため対象外")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "1回目",
                            percentList: vivy.ratioAccelPromote[0],
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "2回目",
                            percentList: vivy.ratioAccelPromote[1],
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "3回目",
                            percentList: vivy.ratioAccelPromote[2],
                            numberofDicimal: 0,
                        )
                        unitTablePercent(
                            columTitle: "4回目",
                            percentList: vivy.ratioAccelPromote[3],
                            numberofDicimal: 0,
                        )
                    }
                }

                // 参考情報）昇格までの継続回数振分け
                unitLinkButtonViewBuilder(sheetTitle: "昇格までの継続回数振分け") {
                    VStack(alignment: .leading) {
                        Text("・アクセルチャンスはセット継続ごとに継続回数が1つ進む")
                        Text("・突入時に昇格までの継続回数を下表の振分けで決定")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    VStack(spacing: 20) {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "1回",
                                percentList: vivy.ratioAccelDistribution[0],
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "2回",
                                percentList: vivy.ratioAccelDistribution[1],
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "3回",
                                percentList: vivy.ratioAccelDistribution[2],
                                numberofDicimal: 1,
                            )
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "4回",
                                percentList: vivy.ratioAccelDistribution[3],
                                numberofDicimal: 0,
                            )
                            unitTablePercent(
                                columTitle: "5回",
                                percentList: vivy.ratioAccelDistribution[4],
                                numberofDicimal: 0,
                            )
                        }
                    }
                }

                // カウント
                DisclosureGroup {
                    // 補足
                    VStack(alignment: .leading) {
                        Text("・セット継続するたびに、その回数目を選んで昇格の有無をカウント")
                        Text("・昇格した時点で、そのアクセルチャンスのカウントは終了")
                    }
                    .foregroundStyle(Color.secondary)
                    .font(.caption)

                    // 継続回数のセグメントピッカー
                    Picker("", selection: self.$selectedAccelStep) {
                        ForEach(self.accelStepItems, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)

                    // カウントボタン横並び
                    HStack {
                        // 1回目
                        if self.selectedAccelStep == self.accelStepItems[0] {
                            unitCountButtonWithoutRatioWithFunc(
                                title: "昇格なし",
                                count: $vivy.accelPromoteCountMiss1,
                                color: .personalSummerLightBlue,
                                minusBool: $vivy.minusCheck) {
                                    vivy.accelPromoteSumFunc()
                                }
                            unitCountButtonWithoutRatioWithFunc(
                                title: "昇格あり",
                                count: $vivy.accelPromoteCountHit1,
                                color: .blue,
                                minusBool: $vivy.minusCheck) {
                                    vivy.accelPromoteSumFunc()
                                }
                        }
                        // 2回目
                        else if self.selectedAccelStep == self.accelStepItems[1] {
                            unitCountButtonWithoutRatioWithFunc(
                                title: "昇格なし",
                                count: $vivy.accelPromoteCountMiss2,
                                color: .personalSpringLightYellow,
                                minusBool: $vivy.minusCheck) {
                                    vivy.accelPromoteSumFunc()
                                }
                            unitCountButtonWithoutRatioWithFunc(
                                title: "昇格あり",
                                count: $vivy.accelPromoteCountHit2,
                                color: .yellow,
                                minusBool: $vivy.minusCheck) {
                                    vivy.accelPromoteSumFunc()
                                }
                        }
                        // 3回目
                        else if self.selectedAccelStep == self.accelStepItems[2] {
                            unitCountButtonWithoutRatioWithFunc(
                                title: "昇格なし",
                                count: $vivy.accelPromoteCountMiss3,
                                color: .personalSummerLightGreen,
                                minusBool: $vivy.minusCheck) {
                                    vivy.accelPromoteSumFunc()
                                }
                            unitCountButtonWithoutRatioWithFunc(
                                title: "昇格あり",
                                count: $vivy.accelPromoteCountHit3,
                                color: .green,
                                minusBool: $vivy.minusCheck) {
                                    vivy.accelPromoteSumFunc()
                                }
                        }
                        // 4回目
                        else {
                            unitCountButtonWithoutRatioWithFunc(
                                title: "昇格なし",
                                count: $vivy.accelPromoteCountMiss4,
                                color: .personalSummerLightRed,
                                minusBool: $vivy.minusCheck) {
                                    vivy.accelPromoteSumFunc()
                                }
                            unitCountButtonWithoutRatioWithFunc(
                                title: "昇格あり",
                                count: $vivy.accelPromoteCountHit4,
                                color: .red,
                                minusBool: $vivy.minusCheck) {
                                    vivy.accelPromoteSumFunc()
                                }
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            vivyView95Ci(
                                vivy: vivy,
                                selection: self.accel95CiTag(),
                            )
                        )
                    )
                    // Ci95viewは@Stateで初回の値を保持するので、選択が変わったら作り直す
                    .id(self.accel95CiTag())

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        vivyViewBayes(
                            vivy: vivy,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("アクセルチャンス昇格 継続回数")
            }
            
            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    vivyTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }

            // ---- 周期モード
            Section {
                // 参考情報）周期モードについて
                unitLinkButtonViewBuilder(sheetTitle: "周期モードについて") {
                    VStack(alignment: .leading) {
                        Text("・設定変更時＆AT終了時にモードを抽選")
                        Text("・偶数設定は通常Bへ移行しやすい")
                        Text("・天国移行率は約40%（設定1）")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text("[モードごとの規定周期振り分け]")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top)
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "規定周期",
                            stringList: ["1周期", "2周期", "3周期", "4周期", "5周期", "6周期"],
                        )
                        unitTablePercent(
                            columTitle: "通常A",
                            percentList: [0, 27.5, 11.3, 18.3, 17.9, 24.9],
                            numberofDicimal: 0,
                        )
                        unitTablePercent(
                            columTitle: "通常B",
                            percentList: [0, 43.6, 56.4, 0, 0, 0],
                            numberofDicimal: 0,
                        )
                        unitTablePercent(
                            columTitle: "天国",
                            percentList: [100, 0, 0, 0, 0, 0],
                            numberofDicimal: 0,
                        )
                    }
                }

                // 参考情報）モードごとの規定ポイント期待度
                unitLinkButtonViewBuilder(sheetTitle: "モードごとの規定ポイント期待度") {
                    vivyTablePointKitai()
                }
            } header: {
                Text("周期モード")
            }

            
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.vivyMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vivy.machineName,
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
                unitButtonMinusCheck(minusCheck: $vivy.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: vivy.resetNormal)
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

    // 弱チェリー確率の95Ciタグ（通常時＝5 〜 変換高確Lv3＝7）
    private func weakCherry95CiTag() -> Int {
        let stateIndex = self.weakCherryStateItems.firstIndex(of: self.selectedWeakCherryState) ?? 0
        return 5 + stateIndex
    }

    // アクセルチャンス昇格の95Ciタグ（1回目＝1 〜 4回目＝4）
    private func accel95CiTag() -> Int {
        let stepIndex = self.accelStepItems.firstIndex(of: self.selectedAccelStep) ?? 0
        return 1 + stepIndex
    }
}

// //// モードごとの規定ポイント期待度（前回の規定ポイントで切り替え）
// kitaiList：0=－　1=△　2=◯　3=◎　11=周期天井
struct vivyTablePointKitai: View {
    let lastPointList: [String] = ["前回555pt以外", "前回555pt"]
    @State var selectedLastPoint: String = "前回555pt以外"
    let pointList: [String] = ["111pt", "222pt", "333pt", "444pt", "555pt"]

    var body: some View {
        VStack {
            Picker("", selection: self.$selectedLastPoint) {
                ForEach(self.lastPointList, id: \.self) { point in
                    Text(point)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)

            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "ポイント",
                    stringList: self.pointList,
                    maxWidth: 100,
                )
                if self.selectedLastPoint == self.lastPointList[0] {
                    unitTableZoneKitai(columTitle: "通常A", kitaiList: [1,2,3,3,11])
                    unitTableZoneKitai(columTitle: "通常B", kitaiList: [1,3,2,3,11])
                    unitTableZoneKitai(columTitle: "天国", kitaiList: [2,11,0,0,0])
                } else {
                    unitTableZoneKitai(columTitle: "通常A", kitaiList: [1,3,11,0,0])
                    unitTableZoneKitai(columTitle: "通常B", kitaiList: [1,3,11,0,0])
                    unitTableZoneKitai(columTitle: "天国", kitaiList: [2,11,0,0,0])
                }
            }
        }
    }
}

#Preview {
    vivyViewNormal(
        vivy: Vivy(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

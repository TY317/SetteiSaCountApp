//
//  gareiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct gareiViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var garei: Garei
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
    // 小役カウントは6個。横向きで2段に折り返すと List のセル自己サイズが
    // 再帰ループ（UpdateCoalescingCollectionView）を起こすため、6列＝1段に収める
    let lazyVGridCountLandscape: Int = 6
    @State var lazyVGridCount: Int = 3

    @State private var isAutoCountOn: Bool = false
    @State private var nextAutoCountDate: Date? = nil

    enum GareiField: Hashable {
        case gameStart
        case gameCurrent
        case count(Int)
    }
    @FocusState var focusedField: GareiField?
    // ダイレクト入力の並び（bindingCount の case と対応）
    let kindList: [String] = ["共通🔔","🍉","弱🍒","強🍒","弱チャンス目","強チャンス目","弱🍒重複","強🍒重複"]
    @State var selectedSegment: String = "小役カウント"
    let segmentList: [String] = ["小役カウント", "CZ重複当選"]

    var body: some View {
        List {
            // レア役
            Section {
                // //// セグメントピッカー
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { segment in
                        Text(segment)
                    }
                }
                .pickerStyle(.segmented)

                // //// カウントボタン横並び
                let gridItem = Array(
                    repeating: GridItem(
                        .flexible(minimum: 80, maximum: 150),
                        spacing: 5,
                        alignment: .center,
                    ),
                    count: self.lazyVGridCount
                )
                LazyVGrid(columns: gridItem) {
                    // ---- 小役カウント
                    if self.selectedSegment == self.segmentList[0] {
                    // 共通ベル
                    unitCountButtonDenominateWithFunc(
                        title: "共通🔔",
                        count: $garei.koyakuCountCommonBell,
                        color: .personalSpringLightYellow,
                        bigNumber: $garei.gameNumberPlay,
                        numberofDicimal: 1,
                        minusBool: $garei.minusCheck) {

                        }
                        .padding(.bottom)
                    // スイカ
                    unitCountButtonDenominateWithFunc(
                        title: "🍉",
                        count: $garei.koyakuCountSuika,
                        color: .personalSummerLightGreen,
                        bigNumber: $garei.gameNumberPlay,
                        numberofDicimal: 1,
                        minusBool: $garei.minusCheck) {

                        }
                        .padding(.bottom)
                    // 弱チェリー
                    unitCountButtonDenominateWithFunc(
                        title: "弱🍒",
                        count: $garei.koyakuCountJakuCherry,
                        color: .personalSummerLightRed,
                        bigNumber: $garei.gameNumberPlay,
                        numberofDicimal: 1,
                        minusBool: $garei.minusCheck) {

                        }
                        .padding(.bottom)
                    // 強チェリー
                    unitCountButtonDenominateWithFunc(
                        title: "強🍒",
                        count: $garei.koyakuCountKyoCherry,
                        color: .red,
                        bigNumber: $garei.gameNumberPlay,
                        numberofDicimal: 1,
                        minusBool: $garei.minusCheck) {

                        }
                        .padding(.bottom)
                    // 弱チャンス目
                    unitCountButtonDenominateWithFunc(
                        title: "弱チャンス目",
                        count: $garei.koyakuCountJakuChance,
                        color: .personalSummerLightBlue,
                        bigNumber: $garei.gameNumberPlay,
                        numberofDicimal: 1,
                        minusBool: $garei.minusCheck) {

                        }
                        .padding(.bottom)
                    // 強チャンス目
                    unitCountButtonDenominateWithFunc(
                        title: "強チャンス目",
                        count: $garei.koyakuCountKyoChance,
                        color: .personalSummerLightPurple,
                        bigNumber: $garei.gameNumberPlay,
                        numberofDicimal: 1,
                        minusBool: $garei.minusCheck) {

                        }
                        .padding(.bottom)
                    }
                    // ---- 重複当選カウント
                    else {
                        // 弱チェリー
                        unitCountButtonPercentWithFunc(
                            title: "弱🍒",
                            count: $garei.chofukuCountJakuCherry,
                            color: .personalSummerLightRed,
                            bigNumber: $garei.koyakuCountJakuCherry,
                            numberofDicimal: 1,
                            minusBool: $garei.minusCheck) {

                            }
                            .padding(.bottom)
                        // 強チェリー
                        unitCountButtonPercentWithFunc(
                            title: "強🍒",
                            count: $garei.chofukuCountKyoCherry,
                            color: .red,
                            bigNumber: $garei.koyakuCountKyoCherry,
                            numberofDicimal: 1,
                            minusBool: $garei.minusCheck) {

                            }
                            .padding(.bottom)
                    }
                }

                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    gareiTableKoyakuPattern()
                }

                // 小役確率
                unitLinkButtonViewBuilder(sheetTitle: "小役確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "共通🔔",
                            denominateList: garei.ratioCommonBell,
                            numberofDicimal: 1,
                        )
                        unitTableDenominate(
                            columTitle: "🍉",
                            denominateList: garei.ratioSuika,
                            numberofDicimal: 1,
                        )
                        unitTableDenominate(
                            columTitle: "弱🍒",
                            denominateList: garei.ratioJakuCherry,
                            numberofDicimal: 1,
                        )
                    }
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "強🍒",
                            denominateList: garei.ratioKyoCherry,
                            numberofDicimal: 1,
                        )
                        unitTableDenominate(
                            columTitle: "弱チャンス目",
                            denominateList: garei.ratioJakuChance,
                            numberofDicimal: 1,
                        )
                        unitTableDenominate(
                            columTitle: "強チャンス目",
                            denominateList: garei.ratioKyoChance,
                            numberofDicimal: 1,
                        )
                    }
                }
                .popoverTip(tipVer470GareiKoyaku())

                // 重複当選率
                unitLinkButtonViewBuilder(sheetTitle: "重複期待度") {
                    Text("[通常滞在時]")
                        .font(.title2)
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "弱🍒",
                            percentList: garei.ratioChofukuJakuCherry,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "強🍒",
                            percentList: garei.ratioChofukuKyoCherry,
                            numberofDicimal: 1,
                        )
                    }
                }

                // 95%信頼区間グラフ
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        gareiView95Ci(
                            garei: garei,
                            selection: 1
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    gareiViewBayes(
                        garei: garei,
                    )
                }
            } header: {
                HStack {
                    Text("小役")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "小役カウント",
                            textBody1: "・小役成立ごとにカウントして下さい",
//                            textBody2: "・🍉と弱🍒は全設定の確率が判明しているため設定期待値の計算に使えます",
//                            textBody3: "・強🍒、弱チャンス目、強チャンス目は設定1の確率のみ判明しています（表の「?」は非公開）",
                        )
                    }
                }
            }

            // //// ゲーム数入力
            Section {
                // 打ち始め入力
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $garei.gameNumberStart,
                    unitText: "Ｇ"
                )
                .focused($focusedField, equals: .gameStart)
                .onChange(of: garei.gameNumberStart) {
                    let playGame = garei.gameNumberCurrent - garei.gameNumberStart
                    garei.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $garei.gameNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused($focusedField, equals: .gameCurrent)
                .onChange(of: garei.gameNumberCurrent) {
                    let playGame = garei.gameNumberCurrent - garei.gameNumberStart
                    garei.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: garei.gameNumberPlay
                )
            } header: {
                Text("ゲーム数入力")
            }
            
            // ---- モード
//            Section {
//                
//            } header: {
//                Text("モード")
//            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gareiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: garei.machineName,
                screenClass: screenClass
            )
        }
        // オートゲーム数カウント
        .autoGameCount(
            isOn: self.$isAutoCountOn,
            currentGames: self.$garei.gameNumberCurrent,
            nextDate: self.$nextAutoCountDate,
            interval: common.autoGameInterval
        )
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
                // 自動G数カウント
                unitToolbarButtonAutoGameCount(
                    autoBool: self.$isAutoCountOn,
                    nextAutoCountDate: self.$nextAutoCountDate,
                )
                .popoverTip(commonTipAutoGameCount())
            }
            // カウント値ダイレクト入力
            ToolbarItem(placement: .automatic) {
                UnitToolbarButtonCountDirectInputEnumFocus<GareiField, AnyView>(
                    focus: $focusedField,
                    inputView: {
                        AnyView(
                            ForEach(self.kindList.indices, id: \.self) { index in
                                if self.kindList.indices.contains(index) {
                                    UnitTextFieldNumberInputWithUnitEnumFocus<GareiField>(
                                        title: self.kindList[index],
                                        inputValue: bindingCount(index),
                                        focusedField: $focusedField,
                                        thisField: .count(index)
                                    )
                                }
                            }
                        )
                    }
                )
            }
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $garei.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: garei.resetNormal)
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
        case 0: return $garei.koyakuCountCommonBell
        case 1: return $garei.koyakuCountSuika
        case 2: return $garei.koyakuCountJakuCherry
        case 3: return $garei.koyakuCountKyoCherry
        case 4: return $garei.koyakuCountJakuChance
        case 5: return $garei.koyakuCountKyoChance
        case 6: return $garei.chofukuCountJakuCherry
        case 7: return $garei.chofukuCountKyoCherry
        default: return .constant(0)
        }
    }
}

#Preview {
    gareiViewNormal(
        garei: Garei(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

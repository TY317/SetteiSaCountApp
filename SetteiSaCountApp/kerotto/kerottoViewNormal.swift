//
//  kerottoViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI
import Combine

struct kerottoViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var kerotto: Kerotto
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
    @State var selectedSegment: String = "小役カウント"
    let segmentList: [String] = ["小役カウント", "重複当選"]
    
    @State private var isAutoCountOn: Bool = false
    @State private var nextAutoCountDate: Date? = nil
    private var autoCountTimer: Publishers.Autoconnect<Timer.TimerPublisher> { Timer.publish(every: common.autoGameInterval, on: .main, in: .common).autoconnect() }
    
    enum KerottoField: Hashable {
        case gameStart
        case gameCurrent
        case count(Int)
    }
    @FocusState var focusedField: KerottoField?
    let kindList: [String] = ["🔔","🍒","平行🍊","斜め🍊","確定役"]
    
    var body: some View {
        List {
            // ---- 小役カウント
            Section {
                // //// セグメントピッカー
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { segment in
                        Text(segment)
                    }
                }
                .pickerStyle(.segmented)
                .popoverTip(tipVer421KerottoKoyaku())

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
//                        HStack {
                            // ベル
                            unitCountButtonDenominateWithFunc(
                                title: "🔔",
                                count: $kerotto.koyakuCountBell,
                                color: .personalSpringLightYellow,
                                bigNumber: $kerotto.gameNumberPlay,
                                numberofDicimal: 1,
                                minusBool: $kerotto.minusCheck) {
                                    
                                }
                                .padding(.bottom)
                            // チェリー
                            unitCountButtonDenominateWithFunc(
                                title: "🍒",
                                count: $kerotto.koyakuCountCherry,
                                color: .personalSummerLightRed,
                                bigNumber: $kerotto.gameNumberPlay,
                                numberofDicimal: 1,
                                minusBool: $kerotto.minusCheck) {
                                    
                                }
                                .padding(.bottom)
                            // 平行オレンジ
                            unitCountButtonDenominateWithFunc(
                                title: "平行🍊",
                                count: $kerotto.koyakuCountHeikoOrange,
                                color: .personalAutumLightOrange,
                                bigNumber: $kerotto.gameNumberPlay,
                                numberofDicimal: 0,
                                minusBool: $kerotto.minusCheck) {
                                    
                                }
                                .padding(.bottom)
                            // 斜めオレンジ
                            unitCountButtonDenominateWithFunc(
                                title: "斜め🍊",
                                count: $kerotto.koyakuCountNanameOrange,
                                color: .personalSpringLightBrown,
                                bigNumber: $kerotto.gameNumberPlay,
                                numberofDicimal: 0,
                                minusBool: $kerotto.minusCheck) {
                                    
                                }
                                .padding(.bottom)
                            // 確定役
                            unitCountButtonDenominateWithFunc(
                                title: "確定役",
                                count: $kerotto.koyakuCountKakuteiyaku,
                                color: .personalSummerLightPurple,
                                bigNumber: $kerotto.gameNumberPlay,
                                numberofDicimal: 0,
                                minusBool: $kerotto.minusCheck) {
                                    
                                }
                                .padding(.bottom)
//                        }
                    }
                    // ---- 重複カウント
                    else {
//                        HStack {
                            // チェリー
                            unitCountButtonPercentWithFunc(
                                title: "🍒",
                                count: $kerotto.chofukuCountCherry,
                                color: .red,
                                bigNumber: $kerotto.koyakuCountCherry,
                                numberofDicimal: 0,
                                minusBool: $kerotto.minusCheck) {
                                    
                                }
                                .padding(.bottom)
                            
                            // 平行オレンジ
                            unitCountButtonPercentWithFunc(
                                title: "平行🍊",
                                count: $kerotto.chofukuCountHeikoOrange,
                                color: .orange,
                                bigNumber: $kerotto.koyakuCountHeikoOrange,
                                numberofDicimal: 0,
                                minusBool: $kerotto.minusCheck) {
                                    
                                }
                                .padding(.bottom)
                            
                            // 斜めオレンジ
                            unitCountButtonPercentWithFunc(
                                title: "斜め🍊",
                                count: $kerotto.chofukuCountNanameOrange,
                                color: .brown,
                                bigNumber: $kerotto.koyakuCountNanameOrange,
                                numberofDicimal: 0,
                                minusBool: $kerotto.minusCheck) {
                                    
                                }
                                .padding(.bottom)
//                        }
                    }
                }
                
                // 小役確率
                unitLinkButtonViewBuilder(sheetTitle: "小役確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "🔔",
                            denominateList: kerotto.ratioBell,
                            numberofDicimal: 1,
                        )
                        unitTableDenominate(
                            columTitle: "🍒",
                            denominateList: kerotto.ratioCherry,
                            numberofDicimal: 1,
                        )
                    }
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "平行🍊",
                            denominateList: kerotto.ratioHeikoOrange
                        )
                        unitTableDenominate(
                            columTitle: "斜め🍊",
                            denominateList: kerotto.ratioNanameOrange
                        )
                        unitTableDenominate(
                            columTitle: "確定役",
                            denominateList: kerotto.ratioKakuteiyaku
                        )
                    }
                }
                
                // 重複確率
                unitLinkButtonViewBuilder(sheetTitle: "重複期待度") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "🍒",
                            percentList: kerotto.ratioChofukuCherry,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "平行🍊",
                            percentList: kerotto.ratioChofukuHeikoOrange
                        )
                        unitTablePercent(
                            columTitle: "斜め🍊",
                            percentList: kerotto.ratioChofukuNanameOrange
                        )
                    }
                }
                
                // 95%信頼区間グラフ
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        kerottoView95Ci(
                            kerotto: kerotto,
                            selection: 5
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    kerottoViewBayes(
                        kerotto: kerotto,
                    )
                }
            } header: {
                HStack {
                    Text("小役")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "小役、重複カウント",
                            textBody1: "・小役カウントでは小役成立ごとにカウントして下さい",
                            textBody2: "・重複当選ではボーナス重複当選ごとにカウントして下さい。小役のカウント数と重複回数から重複当選率を算出します",
                        )
                    }
                }
            }
            
            // //// ゲーム数入力
            Section {
                // //// ゲーム数入力
                // 打ち始め入力
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $kerotto.gameNumberStart,
                    unitText: "Ｇ"
                )
//                .focused(self.$isFocused)
                .focused($focusedField, equals: .gameStart)
                .onChange(of: kerotto.gameNumberStart) {
                    let playGame = kerotto.gameNumberCurrent - kerotto.gameNumberStart
                    kerotto.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $kerotto.gameNumberCurrent,
                    unitText: "Ｇ"
                )
//                .focused(self.$isFocused)
                .focused($focusedField, equals: .gameCurrent)
                .onChange(of: kerotto.gameNumberCurrent) {
                    let playGame = kerotto.gameNumberCurrent - kerotto.gameNumberStart
                    kerotto.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: kerotto.gameNumberPlay
                )
                
            } header: {
                Text("ゲーム数入力")
            }
            
            // ---- フリーズ
            Section {
                Text("ロングフリーズ発生時はSBB+設定4 以上濃厚")
            } header: {
                Text("フリーズ")
            }

        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kerottoMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kerotto.machineName,
                screenClass: screenClass
            )
        }
        // オートゲーム数カウント
        .autoGameCount(
            isOn: self.$isAutoCountOn,
            currentGames: self.$kerotto.gameNumberCurrent,
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
                UnitToolbarButtonCountDirectInputEnumFocus<KerottoField, AnyView>(
                    focus: $focusedField,
                    inputView: {
                        AnyView(
                            ForEach(self.kindList.indices, id: \.self) { index in
                                if self.kindList.indices.contains(index) {
                                    UnitTextFieldNumberInputWithUnitEnumFocus<KerottoField>(
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
                unitButtonMinusCheck(minusCheck: $kerotto.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kerotto.resetNormal)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
//                        isFocused = false
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
    private func bindingCount(_ index: Int) -> Binding<Int> {
        switch index {
        case 0: return $kerotto.koyakuCountBell
        case 1: return $kerotto.koyakuCountCherry
        case 2: return $kerotto.koyakuCountHeikoOrange
        case 3: return $kerotto.koyakuCountNanameOrange
        case 4: return $kerotto.koyakuCountKakuteiyaku
        default: return .constant(0)
        }
    }
}

#Preview {
    kerottoViewNormal(
        kerotto: Kerotto(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}

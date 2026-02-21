//
//  newKingHanaViewJissenCount.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/21.
//

import SwiftUI
import Combine

struct newKingHanaViewJissenCount: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var newKingHana: NewKingHana
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    let displayMode = ["通常時", "BIG", "REG"]
    @State var isSelectedDisplayMode = "通常時"
    @FocusState var isFocused: Bool
    @State var isShowAlert = false
    @FocusState var focusedField: NewKingHanaField?
    enum NewKingHanaField: Hashable {
        case gameStart
        case gameCurrent
        case count(Int)
    }
    let kindList: [String] = ["🔔","BIG","REG"]
    
    @State private var isAutoCountOn: Bool = false
    @State private var nextAutoCountDate: Date? = nil
    private var autoCountTimer: Publishers.Autoconnect<Timer.TimerPublisher> { Timer.publish(every: common.autoGameInterval, on: .main, in: .common).autoconnect() }
    
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
    
    var body: some View {
        ZStack {
            List {
                // --------
                // 通常時
                // --------
                if isSelectedDisplayMode == "通常時" {
                    Section {
                        // カウントボタン横並び
                        HStack {
                            // ベル
                            unitCountButtonDenominateWithFunc(
                                title: "🔔",
                                count: $newKingHana.bellCount,
                                color: .personalSpringLightYellow,
                                bigNumber: $newKingHana.playGames,
                                numberofDicimal: 2,
                                minusBool: $newKingHana.minusCheck,
                                flushColor: .yellow) {
                                    newKingHana.totalBellSumFunc()
                                }
                            // ビッグ
                            unitCountButtonDenominateWithFunc(
                                title: "BIG",
                                count: $newKingHana.bigCount,
                                color: .personalSummerLightRed,
                                bigNumber: $newKingHana.playGames,
                                numberofDicimal: 0,
                                minusBool: $newKingHana.minusCheck) {
                                    newKingHana.bonusSumFunc()
                                    newKingHana.totalBonusSumFunc()
                                    newKingHana.bigPlayGameCalFunc()
                                }
                            // REG
                            unitCountButtonDenominateWithFunc(
                                title: "REG",
                                count: $newKingHana.regCount,
                                color: .personalSummerLightPurple,
                                bigNumber: $newKingHana.playGames,
                                numberofDicimal: 0,
                                minusBool: $newKingHana.minusCheck) {
                                    newKingHana.bonusSumFunc()
                                    newKingHana.totalBonusSumFunc()
                                }
                        }
                        
                        // 確率結果
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $newKingHana.bonusSum,
                            bigNumber: $newKingHana.playGames,
                            numberofDicimal: 0
                        )
                        
                        // 参考情報）ベル、ボーナス確率
                        unitLinkButtonViewBuilder(sheetTitle: "🔔,ボーナス確率") {
                            newKingHanaTableBellBonus(newKingHana: newKingHana)
                        }
                        
                        // //// 95%信頼区間グラフへのリンク
                        unitNaviLink95Ci(
                            Ci95view: AnyView(
                                newKingHanaView95CiPersonal(
                                    newKingHana: newKingHana,
                                    selection: 1,
                                )
                            )
                        )
                        
                        // //// 設定期待値へのリンク
                        unitNaviLinkBayes {
                            newKingHanaViewBayes(
                                newKingHana: newKingHana,
                                bayes: bayes,
                                viewModel: viewModel,
                            )
                        }
                    } header: {
                        Text("🔔,ボーナス")
                    }
                    
                    // //// ゲーム数入力
                    Section {
                        // //// ゲーム数入力
                        // 打ち始め入力
                        unitTextGameNumberWithoutInput(
                            titleText: "打ち始め",
                            gameNumber: newKingHana.startGameInput
                        )
                        // 現在入力
                        unitTextFieldNumberInputWithUnit(
                            title: "現在",
                            inputValue: $newKingHana.currentGames,
                            unitText: "Ｇ"
                        )
                        .focused($focusedField, equals: .gameCurrent)
                        .onChange(of: newKingHana.currentGames) {
                            newKingHana.playGameCalFunc()
                        }
                        // プレイ数
                        unitTextGameNumberWithoutInput(
                            gameNumber: newKingHana.playGames,
                        )
                        
                    } header: {
                        Text("ゲーム数入力")
                    }
                }
                
                // -------
                // BIG
                // -------
                else if self.isSelectedDisplayMode == self.displayMode[1] {
                    Section {
                        // BIG前半ゲーム数
                        HStack {
                            HStack {
                                Text("BIG前半ゲーム数")
                                    .font(.subheadline)
                                unitToolbarButtonQuestion {
                                    unitExView5body2image(
                                        title: "BIG前半ゲーム数",
                                        textBody1: "・BIG回数から自動算出しています",
                                        textBody2: "   BIG回数 × 14ゲーム"
                                    )
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            Text("\(newKingHana.bigPlayGames)")
                                .foregroundStyle(Color.secondary)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .offset(x: 5)
                            Text("Ｇ")
                                .foregroundStyle(Color.secondary)
                                .font(.footnote)
                        }
                        // スイカカウントボタン
                        unitCountButtonVerticalDenominate(
                            title: "スイカ",
                            count: $newKingHana.bbSuikaCount,
                            color: .green,
                            bigNumber: $newKingHana.bigPlayGames,
                            numberofDicimal: 1,
                            minusBool: $newKingHana.minusCheck
                        )
                        
                        // 参考情報）BIG中スイカ確率
                        unitLinkButtonViewBuilder(sheetTitle: "BIG中スイカ確率") {
                            VStack {
                                Text("[参考] 過去のハナハナシリーズ数値")
                                HStack(spacing: 0) {
                                    unitTableSettingIndex(settingList: [1,2,3,4,6])
                                    unitTableDenominate(
                                        columTitle: "BIG中スイカ",
                                        denominateList: newKingHana.ratioBigSuika
                                    )
                                }
                            }
                        }
                        
                        // //// 95%信頼区間グラフへのリンク
                        unitNaviLink95Ci(
                            Ci95view: AnyView(
                                newKingHanaView95CiPersonal(
                                    newKingHana: newKingHana,
                                    selection: 5,
                                )
                            )
                        )
                        
                        // //// 設定期待値へのリンク
                        unitNaviLinkBayes {
                            newKingHanaViewBayes(
                                newKingHana: newKingHana,
                                bayes: bayes,
                                viewModel: viewModel,
                            )
                        }
                    } header: {
                        Text("  \nBIG前半スイカ")
                    }
                    
                    Section {
                        // カウントボタン横並び
                        HStack {
                            // 青
                            unitCountButtonPercentWithFunc(
                                title: "青",
                                count: $newKingHana.sideLampCountBlue,
                                color: .personalSummerLightBlue,
                                bigNumber: $newKingHana.sideLampCountSum,
                                numberofDicimal: 0,
                                minusBool: $newKingHana.minusCheck) {
                                    newKingHana.sideLampCountSumFunc()
                                }
                            // 黄色
                            unitCountButtonPercentWithFunc(
                                title: "黄",
                                count: $newKingHana.sideLampCountYellow,
                                color: .personalSpringLightYellow,
                                bigNumber: $newKingHana.sideLampCountSum,
                                numberofDicimal: 0,
                                minusBool: $newKingHana.minusCheck,
                                flushColor: .yellow) {
                                    newKingHana.sideLampCountSumFunc()
                                }
                            // 緑
                            unitCountButtonPercentWithFunc(
                                title: "緑",
                                count: $newKingHana.sideLampCountGreen,
                                color: .personalSummerLightGreen,
                                bigNumber: $newKingHana.sideLampCountSum,
                                numberofDicimal: 0,
                                minusBool: $newKingHana.minusCheck) {
                                    newKingHana.sideLampCountSumFunc()
                                }
                            // 赤
                            unitCountButtonPercentWithFunc(
                                title: "赤",
                                count: $newKingHana.sideLampCountRed,
                                color: .personalSummerLightRed,
                                bigNumber: $newKingHana.sideLampCountSum,
                                numberofDicimal: 0,
                                minusBool: $newKingHana.minusCheck) {
                                    newKingHana.sideLampCountSumFunc()
                                }
                        }
                        
                        // 奇数・偶数確率
                        HStack {
                            // 奇数示唆
                            unitResultRatioPercent2Line(
                                title: "奇数示唆",
                                color: .grayBack,
                                count: $newKingHana.sideLampCountKisu,
                                bigNumber: $newKingHana.sideLampCountSum,
                                numberofDicimal: 0
                            )
                            // 偶数示唆
                            unitResultRatioPercent2Line(
                                title: "偶数示唆",
                                color: .grayBack,
                                count: $newKingHana.sideLampCountGusu,
                                bigNumber: $newKingHana.sideLampCountSum,
                                numberofDicimal: 0
                            )
                        }
                        
                        // サイドランプ振り分け
                        unitLinkButtonViewBuilder(sheetTitle: "サイドランプ振分け") {
                            VStack {
                                VStack(alignment: .leading) {
                                    Text("・BIG後半中に1回だけ確認可能")
                                    Text("・左リール中段に白７ビタ押し。成功したら中・右にスイカを狙う")
                                    Text("・奇数設定は青・緑が６割、偶数は黄・赤が６割。\n　ただし、設定６のみ全色均等に出現する")
                                }
                                .padding(.bottom)
                                Text("[参考] 過去のハナハナシリーズ数値")
                                HStack(spacing: 0) {
                                    unitTableSettingIndex(settingList: [1,2,3,4,6])
                                    unitTablePercent(
                                        columTitle: "青",
                                        percentList: newKingHana.ratioSideLampBlue
                                    )
                                    unitTablePercent(
                                        columTitle: "黄",
                                        percentList: newKingHana.ratioSideLampYellow
                                    )
                                    unitTablePercent(
                                        columTitle: "緑",
                                        percentList: newKingHana.ratioSideLampGreen
                                    )
                                    unitTablePercent(
                                        columTitle: "赤",
                                        percentList: newKingHana.ratioSideLampRed
                                    )
                                    unitTablePercent(
                                        columTitle: "虹",
                                        percentList: newKingHana.ratioSideLampRainbow,
                                        numberofDicimal: 2,
                                    )
                                }
                            }
                        }
                        
                        // //// 95%信頼区間グラフへのリンク
                        unitNaviLink95Ci(
                            Ci95view: AnyView(
                                newKingHanaView95CiPersonal(
                                    newKingHana: newKingHana,
                                    selection: 6,
                                )
                            )
                        )
                        
                        // //// 設定期待値へのリンク
                        unitNaviLinkBayes {
                            newKingHanaViewBayes(
                                newKingHana: newKingHana,
                                bayes: bayes,
                                viewModel: viewModel,
                            )
                        }
                    } header: {
                        Text("BIG後半 サイドランプ")
                    }
                    
                    // BIG後トップランプ
                    Section {
                        // カウントボタン横並び
                        HStack {
                            // 青
                            unitCountButtonPercentWithFunc(
                                title: "青",
                                count: $newKingHana.bigTopLampCountBlue,
                                color: .personalSummerLightBlue,
                                bigNumber: $newKingHana.bigCount,
                                numberofDicimal: 1,
                                minusBool: $newKingHana.minusCheck) {
                                    newKingHana.bigTopLampSumFunc()
                                }
                            // 黄色
                            unitCountButtonPercentWithFunc(
                                title: "黄",
                                count: $newKingHana.bigTopLampCountYellow,
                                color: .personalSpringLightYellow,
                                bigNumber: $newKingHana.bigCount,
                                numberofDicimal: 1,
                                minusBool: $newKingHana.minusCheck,
                                flushColor: .yellow) {
                                    newKingHana.bigTopLampSumFunc()
                                }
                            // 緑
                            unitCountButtonPercentWithFunc(
                                title: "緑",
                                count: $newKingHana.bigTopLampCountGreen,
                                color: .personalSummerLightGreen,
                                bigNumber: $newKingHana.bigCount,
                                numberofDicimal: 1,
                                minusBool: $newKingHana.minusCheck) {
                                    newKingHana.bigTopLampSumFunc()
                                }
                            // 赤
                            unitCountButtonPercentWithFunc(
                                title: "紫",
                                count: $newKingHana.bigTopLampCountPurple,
                                color: .personalSummerLightPurple,
                                bigNumber: $newKingHana.bigCount,
                                numberofDicimal: 1,
                                minusBool: $newKingHana.minusCheck) {
                                    newKingHana.bigTopLampSumFunc()
                                }
                        }
                        
                        // ランプ合算確率
                        unitResultRatioPercent2Line(
                            title: "ランプ合算",
                            count: $newKingHana.bigTopLampCountSum,
                            bigNumber: $newKingHana.bigCount,
                            numberofDicimal: 1
                        )
                        
                        // 参考情報）ランプ振分け
                        unitLinkButtonViewBuilder(sheetTitle: "BIG終了後ランプ") {
                            VStack {
                                Text("[参考] 過去のハナハナシリーズ数値")
                                HStack(spacing: 0) {
                                    unitTableSettingIndex(settingList: [1,2,3,4,6])
                                    unitTablePercent(
                                        columTitle: "青",
                                        percentList: newKingHana.ratioBigTopLampBlue,
                                        numberofDicimal: 1,
                                    )
                                    unitTablePercent(
                                        columTitle: "黄",
                                        percentList: newKingHana.ratioBigTopLampYellow,
                                        numberofDicimal: 1,
                                    )
                                    unitTablePercent(
                                        columTitle: "緑",
                                        percentList: newKingHana.ratioBigTopLampGreen,
                                        numberofDicimal: 1,
                                    )
                                    unitTablePercent(
                                        columTitle: "紫",
                                        percentList: newKingHana.ratioBigTopLampPurple,
                                        numberofDicimal: 1,
                                    )
                                }
                                HStack(spacing: 0) {
                                    unitTableSettingIndex(settingList: [1,2,3,4,6])
                                    unitTablePercent(
                                        columTitle: "虹",
                                        percentList: newKingHana.ratioBigTopLampRainbow,
                                        numberofDicimal: 2,
                                    )
                                    unitTablePercent(
                                        columTitle: "合算",
                                        percentList: newKingHana.ratioBigTopLampSum,
                                        numberofDicimal: 1,
                                    )
                                }
                            }
                        }
                        
                        // //// 95%信頼区間グラフへのリンク
                        unitNaviLink95Ci(
                            Ci95view: AnyView(
                                newKingHanaView95CiPersonal(
                                    newKingHana: newKingHana,
                                    selection: 7,
                                )
                            )
                        )
                        
                        // //// 設定期待値へのリンク
                        unitNaviLinkBayes {
                            newKingHanaViewBayes(
                                newKingHana: newKingHana,
                                bayes: bayes,
                                viewModel: viewModel,
                            )
                        }
                    } header: {
                        Text("終了後 トップランプ")
                    }
                }
            }
            
            // -----
            // モード選択
            // -----
            VStack {
                Picker("", selection: $isSelectedDisplayMode) {
                    ForEach(displayMode, id: \.self) { mode in
                        Text(mode)
                    }
                }
                .background(Color(UIColor.systemGroupedBackground))
                .pickerStyle(.segmented)
                Spacer()
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newKingHana.machineName,
                screenClass: screenClass
            )
        }
        // オートゲーム数カウント
        .autoGameCount(
            isOn: self.$isAutoCountOn,
            currentGames: self.$newKingHana.currentGames,
            nextDate: self.$nextAutoCountDate,
            interval: common.autoGameInterval
        )
        .navigationTitle("実戦カウント")
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
        
        // //// ツールバーボタン
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
                UnitToolbarButtonCountDirectInputEnumFocus<NewKingHanaField, AnyView>(
                    focus: $focusedField,
                    inputView: {
                        AnyView(
                            ForEach(self.kindList.indices, id: \.self) { index in
                                if self.kindList.indices.contains(index) {
                                    UnitTextFieldNumberInputWithUnitEnumFocus<NewKingHanaField>(
                                        title: self.kindList[index],
                                        inputValue: bindingCount(index),
                                        focusedField: $focusedField,
                                        thisField: .count(index)
                                    )
                                    .onChange(of: newKingHana.bellCount) { oldValue, newValue in
                                        newKingHana.totalBellSumFunc()
                                    }
                                    .onChange(of: newKingHana.bigCount) { oldValue, newValue in
                                        newKingHana.bonusSumFunc()
                                        newKingHana.totalBonusSumFunc()
                                    }
                                    .onChange(of: newKingHana.regCount) { oldValue, newValue in
                                        newKingHana.bonusSumFunc()
                                        newKingHana.totalBonusSumFunc()
                                    }
                                }
                            }
                        )
                    }
                )
            }
            ToolbarItem(placement: .automatic) {
                // マイナスボタン
                unitButtonMinusCheck(minusCheck: $newKingHana.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // データリセットボタン
                unitButtonReset(isShowAlert: $isShowAlert, action: newKingHana.hanaReset)
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
    
    func bindingCount(_ index: Int) -> Binding<Int> {
        switch index {
        case 0: return $newKingHana.bellCount
        case 1: return $newKingHana.bigCount
        case 2: return $newKingHana.regCount
        default: return .constant(0)
        }
    }
}

#Preview {
    newKingHanaViewJissenCount(
        newKingHana: NewKingHana(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

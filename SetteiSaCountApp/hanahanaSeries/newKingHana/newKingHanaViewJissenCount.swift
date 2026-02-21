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

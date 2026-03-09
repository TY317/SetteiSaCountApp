//
//  shakeViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import SwiftUI
import Combine

struct shakeViewNormal: View {
    @ObservedObject var shake: Shake
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @State var isShowAlert: Bool = false
    @FocusState var focusedField: ShakeField?
    enum ShakeField: Hashable {
        case gameStart
        case gameCurrent
        case count(Int)
    }
    @EnvironmentObject var common: commonVar
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 6
    @State var lazyVGridCount: Int = 3
    // ---- 自動カウント用
    @State private var isAutoCountOn: Bool = false
    @State private var nextAutoCountDate: Date? = nil
    private var autoCountTimer: Publishers.Autoconnect<Timer.TimerPublisher> { Timer.publish(every: common.autoGameInterval, on: .main, in: .common).autoconnect() }
    // ----------------
    
    let kindList: [String] = ["🔔","🍒","🍉"]
    let dicimalList: [Int] = [1,1,1]
    let colorList: [Color] = [
        .personalSpringLightYellow,
        .personalSummerLightRed,
        .personalSummerLightGreen,
    ]
    let flushColorList: [Color] = [
        .yellow,
        .red,
        .green,
    ]
    
    var body: some View {
        List {
            // ---- 小役
            Section {
                // カウントボタン横並び
                HStack {
                    ForEach(self.kindList.indices, id: \.self) { index in
                        if self.kindList.indices.contains(index) &&
                            self.dicimalList.indices.contains(index) &&
                            self.colorList.indices.contains(index) &&
                            self.flushColorList.indices.contains(index) {
                            unitCountButtonVerticalDenominate(
                                title: self.kindList[index],
                                count: bindingCount(index),
                                color: self.colorList[index],
                                bigNumber: $shake.gameNumberPlay,
                                numberofDicimal: self.dicimalList[index],
                                minusBool: $shake.minusCheck,
                                flushColor: self.flushColorList[index],
                            )
                        }
                    }
                }
                // 参考情報）小役確率
                unitLinkButtonViewBuilder(sheetTitle: "小役確率") {
                    shakeTableKoyakuRatio(shake: shake)
                }
//                .popoverTip(tipVer3171ShakeKoyaku())
                // 参考情報）レア役停止形
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    shakeTableKoyakuPattern()
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        shakeView95Ci(
                            shake: shake,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    shakeViewBayes(
                        shake: shake,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
                
            } header: {
                HStack {
                    Text("小役")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "小役",
                            textBody1: "・小役回数はダイトモで確認できます",
                            textBody2: "・右上のキーボードボタンで数値の直接入力が可能です",
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
                    inputValue: $shake.gameNumberStart,
                    unitText: "Ｇ"
                )
                .focused($focusedField, equals: .gameStart)
                .onChange(of: shake.gameNumberStart) {
                    let playGame = shake.gameNumberCurrent - shake.gameNumberStart
                    shake.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $shake.gameNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused($focusedField, equals: .gameCurrent)
                .onChange(of: shake.gameNumberCurrent) {
                    let playGame = shake.gameNumberCurrent - shake.gameNumberStart
                    shake.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: shake.gameNumberPlay
                )
                
            } header: {
                Text("ゲーム数入力")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shakeMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shake.machineName,
                screenClass: screenClass
            )
        }
        .autoGameCount(
            isOn: self.$isAutoCountOn,
            currentGames: $shake.gameNumberCurrent,
            nextDate: self.$nextAutoCountDate,
            interval: common.autoGameInterval
        )
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
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // 自動G数カウント
                unitToolbarButtonAutoGameCount(
                    autoBool: self.$isAutoCountOn,
                    nextAutoCountDate: self.$nextAutoCountDate,
                )
//                .popoverTip(commonTipAutoGameCount())
            }
            // カウント値ダイレクト入力
            ToolbarItem(placement: .automatic) {
                UnitToolbarButtonCountDirectInputEnumFocus<ShakeField, AnyView>(
                    focus: $focusedField,
                    inputView: {
                        AnyView(
                            ForEach(self.kindList.indices, id: \.self) { index in
                                if self.kindList.indices.contains(index) {
                                    UnitTextFieldNumberInputWithUnitEnumFocus<ShakeField>(
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
                unitButtonMinusCheck(minusCheck: $shake.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: shake.resetNormal)
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
        case 0: return $shake.koyakuCountBell
        case 1: return $shake.koyakuCountCherry
        case 2: return $shake.koyakuCountSuika
        default: return .constant(0)
        }
    }
}

#Preview {
    shakeViewNormal(
        shake: Shake(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

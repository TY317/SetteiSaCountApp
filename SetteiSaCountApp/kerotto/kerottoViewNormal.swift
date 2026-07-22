//
//  kerottoViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

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
                
                // ---- 小役カウント
                if self.selectedSegment == self.segmentList[0] {
                    HStack {
                        // 平行オレンジ
                        unitCountButtonDenominateWithFunc(
                            title: "平行🍊",
                            count: $kerotto.koyakuCountHeikoOrange,
                            color: .personalSpringLightYellow,
                            bigNumber: $kerotto.gameNumberPlay,
                            numberofDicimal: 0,
                            minusBool: $kerotto.minusCheck) {
                                
                            }
                        // 斜めオレンジ
                        unitCountButtonDenominateWithFunc(
                            title: "斜め🍊",
                            count: $kerotto.koyakuCountNanameOrange,
                            color: .personalSummerLightRed,
                            bigNumber: $kerotto.gameNumberPlay,
                            numberofDicimal: 0,
                            minusBool: $kerotto.minusCheck) {
                                
                            }
                    }
                }
                // ---- 重複カウント
                else {
                    HStack {
                        // 平行オレンジ
                        unitCountButtonPercentWithFunc(
                            title: "平行🍊",
                            count: $kerotto.chofukuCountHeikoOrange,
                            color: .orange,
                            bigNumber: $kerotto.koyakuCountHeikoOrange,
                            numberofDicimal: 0,
                            minusBool: $kerotto.minusCheck) {
                                
                            }
                        
                        // 斜めオレンジ
                        unitCountButtonPercentWithFunc(
                            title: "斜め🍊",
                            count: $kerotto.chofukuCountNanameOrange,
                            color: .red,
                            bigNumber: $kerotto.koyakuCountNanameOrange,
                            numberofDicimal: 0,
                            minusBool: $kerotto.minusCheck) {
                                
                            }
                    }
                }
                
                // 小役確率
                unitLinkButtonViewBuilder(sheetTitle: "小役確率") {
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
                    }
                }
                
                // 重複確率
                unitLinkButtonViewBuilder(sheetTitle: "重複期待度") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
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
                .focused(self.$isFocused)
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
                .focused(self.$isFocused)
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
                        isFocused = false
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
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

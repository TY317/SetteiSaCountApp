//
//  hanabiViewReg.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/22.
//

import SwiftUI

struct hanabiViewReg: View {
    @ObservedObject var hanabi: Hanabi
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
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
    
    @State var selectedItem: String = "2回以下"
    let itemList: [String] = ["2回以下", "3,4回", "5回以上"]
    
    var body: some View {
        List {
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("・1枚役回数ごとにピース花火の発生有無をカウント")
                    Text("・ピース花火確認できたら以降はカウント不要です")
                }
                // セグメントピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.itemList, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
                
                // カウントボタン横並び
                HStack {
                    // 2回以下
                    if self.selectedItem == self.itemList[0]{
                        // 発生なし
                        unitCountButtonPercentWithFunc(
                            title: "発生なし",
                            count: $hanabi.peaceCountU2Miss,
                            color: .personalSummerLightBlue,
                            bigNumber: $hanabi.peaceCountU2Sum,
                            numberofDicimal: 0,
                            minusBool: $hanabi.minusCheck) {
                                hanabi.peaceSumFunc()
                            }
                        unitCountButtonPercentWithFunc(
                            title: "発生あり",
                            count: $hanabi.peaceCountU2Hit,
                            color: .blue,
                            bigNumber: $hanabi.peaceCountU2Sum,
                            numberofDicimal: 0,
                            minusBool: $hanabi.minusCheck) {
                                hanabi.peaceSumFunc()
                            }
                    }
                    
                    // 3,4回
                    else if self.selectedItem == self.itemList[1] {
                        // 発生なし
                        unitCountButtonPercentWithFunc(
                            title: "発生なし",
                            count: $hanabi.peaceCountU4Miss,
                            color: .personalSummerLightGreen,
                            bigNumber: $hanabi.peaceCountU4Sum,
                            numberofDicimal: 0,
                            minusBool: $hanabi.minusCheck) {
                                hanabi.peaceSumFunc()
                            }
                        unitCountButtonPercentWithFunc(
                            title: "発生あり",
                            count: $hanabi.peaceCountU4Hit,
                            color: .green,
                            bigNumber: $hanabi.peaceCountU4Sum,
                            numberofDicimal: 0,
                            minusBool: $hanabi.minusCheck) {
                                hanabi.peaceSumFunc()
                            }
                    }
                    
                    // 5回以上
                    else {
                        // 発生なし
                        unitCountButtonPercentWithFunc(
                            title: "発生なし",
                            count: $hanabi.peaceCountO5Miss,
                            color: .personalSummerLightRed,
                            bigNumber: $hanabi.peaceCountO5Sum,
                            numberofDicimal: 0,
                            minusBool: $hanabi.minusCheck) {
                                hanabi.peaceSumFunc()
                            }
                        unitCountButtonPercentWithFunc(
                            title: "発生あり",
                            count: $hanabi.peaceCountO5Hit,
                            color: .red,
                            bigNumber: $hanabi.peaceCountO5Sum,
                            numberofDicimal: 0,
                            minusBool: $hanabi.minusCheck) {
                                hanabi.peaceSumFunc()
                            }
                    }
                }
                
                // 参考情報）ピース花火出現率
                unitLinkButtonViewBuilder(sheetTitle: "ピース花火出現率") {
                    VStack {
                        Text("[1枚役回数ごとの出現率]")
                            .font(.title2)
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,5,6])
                            unitTablePercent(
                                columTitle: "2回以下",
                                percentList: [
                                    hanabi.ratioPeaceU2[0],
                                    hanabi.ratioPeaceU2[1],
                                ],
                                numberofDicimal: 1,
                                lineList: [1,3]
                            )
                            unitTablePercent(
                                columTitle: "3,4回",
                                percentList: [
                                    hanabi.ratioPeaceU4[0],
                                    hanabi.ratioPeaceU4[1],
                                ],
                                numberofDicimal: 0,
                                lineList: [1,3]
                            )
                            unitTablePercent(
                                columTitle: "5回以上",
                                percentList: [
                                    hanabi.ratioPeaceO5[0],
                                    hanabi.ratioPeaceO5[1],
                                ],
                                numberofDicimal: 0,
                                lineList: [1,3]
                            )
                        }
                    }
                }
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    hanabiViewBayes(
                        hanabi: hanabi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("ピース花火")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hanabiMenuRegBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hanabi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("REG")
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
                unitButtonMinusCheck(minusCheck: $hanabi.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hanabi.resetReg)
            }
        }
    }
}

#Preview {
    hanabiViewReg(
        hanabi: Hanabi(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

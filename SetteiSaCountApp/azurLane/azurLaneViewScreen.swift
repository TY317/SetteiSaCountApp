//
//  azurLaneViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/26.
//

import SwiftUI

struct azurLaneViewScreen: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var azurLane: AzurLane
    @State var isShowAlert = false
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "azurLaneScreen1",
        "azurLaneScreen2",
        "azurLaneScreen3",
        "azurLaneScreen4",
        "azurLaneScreen5",
        "azurLaneScreen6",
        "azurLaneScreen7",
        "azurLaneScreen8",
        "azurLaneScreen9",
        "azurLaneScreen10",
        "azurLaneScreen11",
    ]
    let upperBeltTextList: [String] = [
        "エンタープライズ",
        "ベルファスト",
        "ｴﾝﾀｰﾌﾟﾗｲｽﾞ&ﾍﾞﾙﾌｧｽﾄ",
        "赤城",
        "全員集合",
        "加賀＆赤城",
        "パーティ",
        "ピクニック",
        "仲良し4人",
        "最後の晩餐風",
        "セイレーン",
    ]
    let lowerBeltTextList: [String] = [
        "デフォ 奇数示唆 弱",
        "デフォ 偶数示唆 弱",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
        "ボーナス規定回数残り\n3回以内の期待度アップ",
        "ボーナス規定回数残り\n3回以内の期待度アップ＆5回以内濃厚",
        "ボーナス規定回数残り\n3回以内濃厚",
        "ボーナス規定回数残り\n1回濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .gray,
        .blue,
        .yellow,
        .cyan,
        .orange,
        .purple,
        .personalSummerLightBlue,
        .personalSummerLightGreen,
        .personalSummerLightRed,
        .personalSummerLightPurple,
    ]
    var body: some View {
        List {
            Section {
                // //// 画面カウントボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(self.imageNameList.indices, id: \.self) { index in
                            if self.imageNameList.indices.contains(index) &&
                                self.upperBeltTextList.indices.contains(index) &&
                                self.lowerBeltTextList.indices.contains(index) {
                                if index < 7 {
                                    unitButtonScreenChoiceVer3(
                                        screen: unitScreenOnlyDisplay(
                                            image: Image(self.imageNameList[index]),
                                            upperBeltText: self.upperBeltTextList[index],
                                            lowerBeltText: self.lowerBeltTextList[index],
                                            lowerBeltFont: .body,
                                            lowerBeltHeight: 35,
                                        ),
                                        screenName: self.imageNameList[index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenCount(index: index),
                                        minusCheck: $azurLane.minusCheck,
                                        action: azurLane.screenSumFunc,
                                    )
                                } else {
                                    unitButtonScreenChoiceVer3(
                                        screen: unitScreenOnlyDisplay(
                                            image: Image(self.imageNameList[index]),
                                            upperBeltText: self.upperBeltTextList[index],
                                            lowerBeltText: self.lowerBeltTextList[index],
                                            lowerBeltFont: .caption,
                                            lowerBeltHeight: 35,
                                        ),
                                        screenName: self.imageNameList[index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenCount(index: index),
                                        minusCheck: $azurLane.minusCheck,
                                        action: azurLane.screenSumFunc,
                                    )
                                }
                            }
                        }
                    }
                }
                .frame(height: 155)
                .popoverTip(tipVer3110AzurLaneScreen())
                
                // //// カウント結果
                ForEach(self.lowerBeltTextList.indices, id: \.self) { index in
                    if self.lowerBeltTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) {
//                        if index == 0 {
//                            
//                        }
//                        else if index < 7 {
                        if index < 7 {
                            unitResultCountListPercent(
                                title: self.lowerBeltTextList[index],
                                count: bindingForScreenCount(index: index),
                                flashColor: self.flashColorList[index],
                                bigNumber: $azurLane.screenCountSetteiSum,
                                numberofDigit: 0,
                                titleFont: .body,
                            )
                        } else {
                            unitResultCountListWithoutRatio(
                                title: self.lowerBeltTextList[index],
                                count: bindingForScreenCount(index: index),
                                flashColor: self.flashColorList[index],
                                titleFont: .caption,
                            )
//                            unitResultCountListPercent(
//                                title: self.lowerBeltTextList[index],
//                                count: bindingForScreenCount(index: index),
//                                flashColor: self.flashColorList[index],
//                                bigNumber: $azurLane.screenCountSum,
//                                numberofDigit: 0,
//                                titleFont: .caption,
//                            )
                        }
                    }
                }
                
                // 参考情報）画面振り分け
                unitLinkButtonViewBuilder(sheetTitle: "終了画面振り分け") {
                    azurLaneTableScreenRatio(azurLane: azurLane)
                }
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    azurLaneViewBayes(
                        azurLane: azurLane,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                HStack {
                    Text("画面カウント")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "画面カウント",
                            textBody1: "・画面を選択した状態でもう一度タップするとカウントできます",
                            textBody2: "・選択解除は画面上部のボタンでできます",
                            textBody3: "・画像はイメージです。実際の画面と人数やポーズ、持ち物、背景など詳細は異なる場合があります",
                        )
                    }
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.azurLaneMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: azurLane.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(
                        currentKeyword: self.$selectedImageName
                    )
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $azurLane.minusCheck)
                    // /// リセット
                    unitButtonReset(
                        isShowAlert: $isShowAlert,
                        action: azurLane.resetScreen,
                    )
                }
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $azurLane.screenCountDefault
        case 1: return $azurLane.screenCountDefaultGusu
        case 2: return $azurLane.screenCountHighJaku
        case 3: return $azurLane.screenCountHighKyo
        case 4: return $azurLane.screenCountOver2
        case 5: return $azurLane.screenCountOver4
        case 6: return $azurLane.screenCountOver6
        case 7: return $azurLane.screenCountRemain3Sisa
        case 8: return $azurLane.screenCountRemain5
        case 9: return $azurLane.screenCountRemain3
        case 10: return $azurLane.screenCountRemain1
        default: return .constant(0)
        }
    }
}

#Preview {
    azurLaneViewScreen(
        azurLane: AzurLane(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

//
//  bakemonoViewAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/06.
//

import SwiftUI

struct bakemonoViewAt: View {
    @ObservedObject var bakemono: Bakemono
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "bakemonoFixScreen1",
        "bakemonoFixScreen2",
        "bakemonoFixScreen3",
    ]
    let upperBeltTextList: [String] = [
        "ヒロインA",
        "ヒロインB",
        "忍",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "高設定示唆",
        "青7濃厚\n(赤7なら設定5以上濃厚)",
    ]
    let flashColorList: [Color] = [
        .gray,
        .yellow,
        .blue,
    ]
    let indexList: [Int] = [0,1,2]
    let sisaText: [String] = [
        "ヒロインA",
        "ヒロインB",
        "忍",
    ]
    var body: some View {
        List {
            // 獲得枚数表示
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "獲得枚数での示唆") {
                    bakemonoTableMaisuSisa()
                }
            } header: {
                Text("獲得枚数での示唆")
            }
            
            // 画面カウント
            Section {
                // カウントボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(self.indexList, id: \.self) { index in
                            if self.imageNameList.indices.contains(index) &&
                                self.upperBeltTextList.indices.contains(index) &&
                                self.lowerBeltTextList.indices.contains(index) {
                                unitButtonScreenChoiceVer3(
                                    screen: unitScreenOnlyDisplay(
                                        image: Image(self.imageNameList[index]),
                                        upperBeltText: self.upperBeltTextList[index],
                                        lowerBeltText: self.lowerBeltTextList[index],
//                                        lowerBeltFont: .body,
//                                        lowerBeltHeight: 35,
                                    ),
                                    screenName: self.imageNameList[index],
                                    selectedScreen: self.$selectedImageName,
                                    count: bindingForScreenCount(index: index),
                                    minusCheck: $bakemono.minusCheck,
                                    action: bakemono.fixScreenSumFunc,
                                )
                            }
                        }
                    }
                }
                .frame(height: common.screenScrollHeight)
                
                // //// カウント結果
                ForEach(self.indexList, id: \.self) { index in
                    if self.lowerBeltTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) {
//                        self.flashColorList.indices.contains(index) &&
//                        self.sisaText.indices.contains(index) {
                        unitResultCountListPercent(
                            title: self.lowerBeltTextList[index],
//                            title: self.sisaText[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $bakemono.fixScreenSum,
                            numberofDigit: 0,
                            titleFont: .body,
                        )
                    }
                }
            } header: {
                HStack {
                    Text("ボーナス確定画面")
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
        .resetBadgeOnAppear($common.bakemonoMenuAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bakemono.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("倖時間")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// 画面選択解除
                unitButtonToolbarScreenSelectReset(
                    currentKeyword: self.$selectedImageName
                )
            }
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $bakemono.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: bakemono.resetAt)
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $bakemono.fixScreen1
        case 1: return $bakemono.fixScreen2
        case 2: return $bakemono.fixScreen3
        default: return .constant(0)
        }
    }
}

#Preview {
    bakemonoViewAt(
        bakemono: Bakemono(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

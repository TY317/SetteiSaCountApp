//
//  bakemonoViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/06.
//

import SwiftUI

struct bakemonoViewScreen: View {
    @ObservedObject var bakemono: Bakemono
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "bakemonoScreen1",
        "bakemonoScreen2",
        "bakemonoScreen3",
        "bakemonoScreen4",
        "bakemonoScreen5",
        "bakemonoScreen6",
        "bakemonoScreen7",
        "bakemonoScreen8",
        "bakemonoScreen9",
        "bakemonoScreen10",
        "bakemonoScreen11",
    ]
    let upperBeltTextList: [String] = [
        "暦",
        "ひたぎ",
        "真宵",
        "駿河",
        "撫子",
        "翼",
        "忍",
        "忍野",
        "金枠 3人",
        "金枠 ヒロイン",
        "I LOVE YOU",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "高設定示唆 強",
        "偶数示唆 弱",
        "奇数＆高設定示唆",
        "高設定示唆 弱",
        "偶数示唆 強",
        "設定2,4,6濃厚",
        "設定3,5,6濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .red,
        .yellow,
        .green,
        .blue,
        .yellow,
        .cyan,
        .purple,
        .orange,
        .orange,
        .orange,
    ]
    let indexList: [Int] = [0,2,4,3,5,1,6,7,8,9,10]
    let sisaText: [String] = [
        "暦",
        "ひたぎ",
        "真宵",
        "駿河",
        "撫子",
        "翼",
        "忍",
        "忍野",
        "金枠 3人",
        "金枠 ヒロイン",
        "I LOVE YOU",
    ]
    var body: some View {
        List {
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
                                    action: bakemono.screenCountSumFunc,
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
                            bigNumber: $bakemono.screenCountSum,
                            numberofDigit: 0,
                            titleFont: .body,
                        )
                    }
                }
            } header: {
                unitLabelHeaderScreenCount()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bakemonoMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bakemono.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT終了画面")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: bakemono.resetScreen)
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $bakemono.screenCount1
        case 1: return $bakemono.screenCount2
        case 2: return $bakemono.screenCount3
        case 3: return $bakemono.screenCount4
        case 4: return $bakemono.screenCount5
        case 5: return $bakemono.screenCount6
        case 6: return $bakemono.screenCount7
        case 7: return $bakemono.screenCount8
        case 8: return $bakemono.screenCount9
        case 9: return $bakemono.screenCount10
        case 10: return $bakemono.screenCount11
        default: return .constant(0)
        }
    }
}

#Preview {
    bakemonoViewScreen(
        bakemono: Bakemono(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

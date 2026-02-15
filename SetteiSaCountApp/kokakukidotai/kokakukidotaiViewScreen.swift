//
//  kokakukidotaiViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/28.
//

import SwiftUI

struct kokakukidotaiViewScreen: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "kokakukidotaiScreen1",
        "kokakukidotaiScreen2",
        "kokakukidotaiScreen3",
        "kokakukidotaiScreen4",
        "kokakukidotaiScreen5",
        "kokakukidotaiScreen6",
        "kokakukidotaiScreen7",
        "kokakukidotaiScreen8",
        "kokakukidotaiScreen9",
        "kokakukidotaiScreen10",
    ]
    let upperBeltTextList: [String] = [
        "緑枠 素子",
        "緑枠 素子＆タチコマ",
        "緑枠 トグサ",
        "緑枠 バトー",
        "緑枠 ポーカー",
        "緑枠 素子後姿",
        "赤枠 9課",
        "紫枠 素子＆笑い男",
        "金枠 アオイ",
        "緑枠 9課",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "高設定示唆 弱",
        "奇数示唆",
        "偶数示唆",
        "高モード示唆",
        "通常B以上濃厚",
        "通常C以上濃厚",
        "C以上濃厚＆D期待",
        "D＆設定4以上濃厚",
        "白の境界ストック",
    ]
    let flashColorList: [Color] = [
        .green,
        .green,
        .green,
        .green,
        .green,
        .green,
        .red,
        .purple,
        .orange,
        .green,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7,8,9]
    
    var body: some View {
        List {
            // 画面カウント
            Section {
                // 注意書き
                HStack {
                    Text("⚠️")
                    VStack(alignment: .leading) {
                        Text("以下のタイミング＆操作で表示されます")
                        Text("・通常時77G以上消化以降＋左停止ボタン7回PUSH")
                        Text("・タチコマS.A.M終了画面＋ボタンPUSH")
                        Text("・AT終了画面＋ボタンPUSH")
                    }
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                }
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
                                    minusCheck: $kokakukidotai.minusCheck,
                                    action: kokakukidotai.screenSumFunc,
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
                            bigNumber: $kokakukidotai.screenCountSum,
                            numberofDigit: 0,
                            titleFont: .body,
                        )
                    }
                }
            } header: {
                unitLabelHeaderScreenCount()
            }
            
            // CZ終了画面の示唆
            kokakukidotaiSubViewCzScreen()
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kokakukidotaiMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("示唆ウィンドウ")
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
                unitButtonMinusCheck(minusCheck: $kokakukidotai.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kokakukidotai.resetScreen)
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $kokakukidotai.screenCountDefault
        case 1: return $kokakukidotai.screenCountHighJaku
        case 2: return $kokakukidotai.screenCountKisu
        case 3: return $kokakukidotai.screenCountGusu
        case 4: return $kokakukidotai.screenCountHighMode
        case 5: return $kokakukidotai.screenCountOverB
        case 6: return $kokakukidotai.screenCountOverC
        case 7: return $kokakukidotai.screenCountOverCKyo
        case 8: return $kokakukidotai.screenCountOverD4
        case 9: return $kokakukidotai.screenCountWhiteEdge
        default: return .constant(0)
        }
    }
}

#Preview {
    kokakukidotaiViewScreen(
        kokakukidotai: Kokakukidotai(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

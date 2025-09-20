//
//  toreveViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/06.
//

import SwiftUI

struct toreveViewScreen: View {
    @ObservedObject var ver391: Ver391
    @ObservedObject var toreve: Toreve
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var isShowAlert = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "toreveScreen1",
        "toreveScreen2",
        "toreveScreen3",
        "toreveScreen4",
        "toreveScreen5",
        "toreveScreen6",
        "toreveScreen7",
        "toreveScreen8",
        "toreveScreen9",
        "toreveScreen10",
    ]
    let upperBeltTextList: [String] = [
        "白背景",
        "赤背景 3人",
        "赤背景 5人",
        "炎背景",
        "青背景 2人",
        "青背景 5人",
        "水色背景 2人",
        "黄枠",
        "紫枠 夏祭り",
        "金枠 結成写真",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "偶数示唆",
        "高設定示唆 強",
        "設定4 以上濃厚",
        "奇数示唆",
        "高設定示唆 弱",
        "設定2 以上濃厚",
        "設定3 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .red,
        .red,
        .red,
        .blue,
        .blue,
        .cyan,
        .yellow,
        .purple,
        .orange,
    ]
    let sisaText: [String] = [
        "デフォルト",
        "偶数示唆",
        "高設定示唆 強",
        "設定4 以上濃厚",
        "奇数示唆",
        "高設定示唆 弱",
        "設定2 以上濃厚",
        "設定3 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let indexList: [Int] = [0,1,4,5,2,6,7,3,8,9]
    
    var body: some View {
        List {
            Section {
                // 注意事項
                unitLinkButtonViewBuilder(sheetTitle: "[注意]固定の画面が出る場合") {
                    VStack(alignment: .leading) {
                        Text("以下の場合は固定の画面が表示されます")
                        Text("カウントから除外して下さい")
                        Text("特にエンディング後は金枠が固定で出るので勘違いしないように注意！")
                        Text("　・エピソード後")
                        Text("　・ロングフリーズ後のエピソード後")
                        Text("　・エンディング後")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                // //// 画面カウントボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
//                        ForEach(self.imageNameList.indices, id: \.self) { index in
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
                                    minusCheck: $toreve.minusCheck,
                                    action: toreve.screenSumFunc,
                                )
                            }
                        }
                    }
                }
                .frame(height: 170)
                .popoverTip(tipVer391ToreveScreen())
                
                // //// カウント結果
//                ForEach(self.lowerBeltTextList.indices, id: \.self) { index in
                ForEach(self.indexList, id: \.self) { index in
                    if self.lowerBeltTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) &&
                        self.sisaText.indices.contains(index) {
                        unitResultCountListPercent(
//                            title: self.lowerBeltTextList[index],
                            title: self.sisaText[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $toreve.screenCountSum,
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
        .resetBadgeOnAppear($ver391.toreveMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
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
                    unitButtonMinusCheck(minusCheck: $toreve.minusCheck)
                    // /// リセット
                    unitButtonReset(
                        isShowAlert: $isShowAlert,
                        action: toreve.resetScreen,
                    )
                }
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $toreve.screenCount1
        case 1: return $toreve.screenCount2
        case 2: return $toreve.screenCount3
        case 3: return $toreve.screenCount4
        case 4: return $toreve.screenCount5
        case 5: return $toreve.screenCount6
        case 6: return $toreve.screenCount7
        case 7: return $toreve.screenCount8
        case 8: return $toreve.screenCount9
        case 9: return $toreve.screenCount10
        default: return .constant(0)
        }
    }
}

#Preview {
    toreveViewScreen(
        ver391: Ver391(),
        toreve: Toreve(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}

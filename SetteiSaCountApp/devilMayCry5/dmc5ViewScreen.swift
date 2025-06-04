//
//  dmc5ViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/01.
//

import SwiftUI

struct dmc5ViewScreen: View {
    @ObservedObject var dmc5: Dmc5
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "dmc5BonusScreen1",
        "dmc5BonusScreen2",
        "dmc5BonusScreen3",
        "dmc5BonusScreen4",
        "dmc5BonusScreen5",
        "dmc5BonusScreen6",
        "dmc5BonusScreen7",
        "dmc5BonusScreen8",
        "dmc5BonusScreen9",
        "dmc5BonusScreen10",
        "dmc5BonusScreen11",
    ]
    let upperBeltTextList: [String] = [
        "緑枠 ﾆｺﾄﾚｰﾗｰ内",
        "緑枠 ライブラリー",
        "緑枠 マーケット",
        "青枠 ストリート",
        "青枠 カタコンベ",
        "銅枠 ﾌﾞﾗｯﾃﾞｨﾊﾟﾚｽ(低層)",
        "銅枠 ﾌﾞﾗｯﾃﾞｨﾊﾟﾚｽ(中層)",
        "銅枠 ﾌﾞﾗｯﾃﾞｨﾊﾟﾚｽ(上層)",
        "金枠 魔界",
        "金枠 全員集合",
        "虹枠 ｴﾝﾀﾗｲｵﾝ"
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定3 否定",
        "設定2 否定",
        "設定1 否定",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚"
    ]
    let flashColorList: [Color] = [
        .green,
        .green,
        .green,
        .blue,
        .blue,
        .brown,
        .brown,
        .brown,
        .orange,
        .orange,
        .purple
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
                                unitButtonScreenChoiceVer3(
                                    screen: unitScreenOnlyDisplay(
                                        image: Image(self.imageNameList[index]),
                                        upperBeltText: self.upperBeltTextList[index],
                                        upperBeltFont: .footnote,
                                        lowerBeltText: self.lowerBeltTextList[index]
                                    ),
                                    screenName: self.imageNameList[index],
                                    selectedScreen: self.$selectedImageName,
                                    count: bindingForScreenCount(index: index),
                                    minusCheck: $dmc5.minusCheck,
                                    action: dmc5.screenCountSumFunc
                                )
                            }
                        }
                    }
                    .popoverTip(tipUnitButtonScreenChoice())
                }
                .frame(height: 120)
                
                // //// カウント結果
                ForEach(self.lowerBeltTextList.indices, id: \.self) { index in
                    if self.lowerBeltTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) {
                        unitResultCountListPercent(
                            title: self.lowerBeltTextList[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $dmc5.screenCountSum
                        )
                    }
                }
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dmc5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: self.$selectedImageName)
//                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $dmc5.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: dmc5.resetScreen)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return dmc5.$screenCountDefault
        case 1: return dmc5.$screenCountKisu
        case 2: return dmc5.$screenCountGusu
        case 3: return dmc5.$screenCountHighJaku
        case 4: return dmc5.$screenCountHighKyo
        case 5: return dmc5.$screenCountNegate3
        case 6: return dmc5.$screenCountNegate2
        case 7: return dmc5.$screenCountNegate1
        case 8: return dmc5.$screenCountOver4
        case 9: return dmc5.$screenCountOver5
        case 10: return dmc5.$screenCountOver6
        default: return .constant(0)
        }
    }
}

#Preview {
    dmc5ViewScreen(
        dmc5: Dmc5()
    )
}

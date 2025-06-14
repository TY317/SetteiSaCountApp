//
//  guiltyCrown2ViewAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/07.
//

import SwiftUI

struct guiltyCrown2ViewAtScreen: View {
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "guiltyCrown2AtScreen1",
        "guiltyCrown2AtScreen2",
        "guiltyCrown2AtScreen3",
        "guiltyCrown2AtScreen4",
    ]
    let upperBeltTextList: [String] = [
        "集",
        "綾瀬＆ツグミ",
        "羽つき",
        "ライブ",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .green,
        .red,
        .purple,
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
                                        lowerBeltText: self.lowerBeltTextList[index]
                                    ),
                                    screenName: self.imageNameList[index],
                                    selectedScreen: self.$selectedImageName,
                                    count: bindingForScreenCount(index: index),
                                    minusCheck: $guiltyCrown2.minusCheck,
                                    action: guiltyCrown2.atScreenCountSumFunc,
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
                            bigNumber: $guiltyCrown2.atScreenCountSum
                        )
                    }
                }
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: guiltyCrown2.machineName,
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
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $guiltyCrown2.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: guiltyCrown2.resetAtScreen)
                }
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return guiltyCrown2.$atScreenCountDefault
        case 1: return guiltyCrown2.$atScreenCountOver2
        case 2: return guiltyCrown2.$atScreenCountOver4
        case 3: return guiltyCrown2.$atScreenCountOver6
        default: return .constant(0)
        }
    }
}

#Preview {
    guiltyCrown2ViewAtScreen(
        guiltyCrown2: GuiltyCrown2()
    )
}

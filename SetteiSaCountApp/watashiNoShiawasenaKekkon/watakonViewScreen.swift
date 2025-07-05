//
//  watakonViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/30.
//

import SwiftUI

struct watakonViewScreen: View {
    @ObservedObject var watakon: Watakon
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "watakonScreenDefault",
        "watakonScreenHigh",
        "watakonScreenGusu",
        "watakonScreenOver2",
        "watakonScreenOver4",
        "watakonScreenOver6",
    ]
    let upperBeltTextList: [String] = [
        "春（着物）",
        "春（軍服）",
        "夏",
        "秋",
        "冬",
        "お正月",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "高設定示唆",
        "偶数示唆",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .green,
        .yellow,
        .blue,
        .red,
        .orange,
    ]
    var body: some View {
        List {
            Section {
                // コナミコマンドの説明
                Text("AT終了画面でコナミコマンド（十字キーの↑↑↓↓←→←→+CHANCEボタン）を入力すると画面が変化し設定を示唆")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                
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
                                        lowerBeltText: self.lowerBeltTextList[index],
//                                        lowerBeltFont: .subheadline,
                                    ),
                                    screenName: self.imageNameList[index],
                                    selectedScreen: self.$selectedImageName,
                                    count: bindingForScreenCount(index: index),
                                    minusCheck: $watakon.minusCheck,
                                    action: watakon.screenCountSumFunc
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
                            bigNumber: $watakon.screenCountSum
                        )
                    }
                }
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: watakon.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(
                        currentKeyword: self.$selectedImageName
                    )
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $watakon.minusCheck)
                    // /// リセット
                    unitButtonReset(
                        isShowAlert: $isShowAlert,
                        action: watakon.resetScreen,
                    )
                }
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return watakon.$screenCountDefault
        case 1: return watakon.$screenCountHigh
        case 2: return watakon.$screenCountGusu
        case 3: return watakon.$screenCountOver2
        case 4: return watakon.$screenCountOver4
        case 5: return watakon.$screenCountOver6
        default: return .constant(0)
        }
    }
}

#Preview {
    watakonViewScreen(
        watakon: Watakon(),
    )
}

//
//  reSwordViewAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/02.
//

import SwiftUI

struct reSwordViewAtScreen: View {
    @ObservedObject var ver361: Ver361
    @ObservedObject var reSword: ReSword
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "reSwordAtScreen1",
        "reSwordAtScreen2",
        "reSwordAtScreen3",
        "reSwordAtScreen4",
        "reSwordAtScreen5",
        "reSwordAtScreen6",
    ]
    let upperBeltTextList: [String] = [
        "フラン＋師匠",
        "フラン＋師匠(白)",
        "フラン＋師匠(黒)",
        "水着フラン",
        "和服フラン",
        "全員集合",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "高設定示唆 弱",
        "高設定示唆 強",
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
    let sisaList: [String] = [
        "デフォルト",
        "???(白背景)",
        "???(黒背景)",
        "???(水着)",
        "???(和服)",
        "???(全員集合)",
    ]
    var body: some View {
        List {
            Section {
                // //// 詳細判明したら消す
                Text("AT終了画面で設定を示唆\n右にある画面ほど良い示唆と思われる")
                    .multilineTextAlignment(.leading)
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
                                    ),
                                    screenName: self.imageNameList[index],
                                    selectedScreen: self.$selectedImageName,
                                    count: bindingForScreenCount(index: index),
                                    minusCheck: $reSword.minusCheck,
                                    action: reSword.screenCountSumFunc
                                )
                            }
                        }
                    }
                }
                .frame(height: 120)
                .popoverTip(tipVer361ReSwordScreen())
                
                // //// カウント結果
//                ForEach(self.sisaList.indices, id: \.self) { index in
                ForEach(self.lowerBeltTextList.indices, id: \.self) { index in
//                    if self.sisaList.indices.contains(index) &&
                    if self.lowerBeltTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) {
                        unitResultCountListPercent(
//                            title: self.sisaList[index],
                            title: self.lowerBeltTextList[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $reSword.atScreenCountSum,
                        )
                    }
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver361.reSwordMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: reSword.machineName,
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
                    unitButtonMinusCheck(minusCheck: $reSword.minusCheck)
                    // /// リセット
                    unitButtonReset(
                        isShowAlert: $isShowAlert,
                        action: reSword.resetAtScreen,
                    )
                }
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return reSword.$atScreenCount1
        case 1: return reSword.$atScreenCount2
        case 2: return reSword.$atScreenCount3
        case 3: return reSword.$atScreenCount4
        case 4: return reSword.$atScreenCount5
        case 5: return reSword.$atScreenCount6
        default: return .constant(0)
        }
    }
}

#Preview {
    reSwordViewAtScreen(
        ver361: Ver361(),
        reSword: ReSword(),
    )
}

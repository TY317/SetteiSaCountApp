//
//  magiaViewAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaViewAtScreen: View {
//    @ObservedObject var ver271 = Ver271()
//    @ObservedObject var magia = Magia()
    @ObservedObject var magia: Magia
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "magiaAtScreenDefault",
        "magiaAtScreen356",
        "magiaAtScreen246",
        "magiaAtScreenOver6"
    ]
    var body: some View {
        List {
            // /// 調査中表示
//            Section {
//                Text("詳細調査中")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .frame(maxWidth: .infinity, alignment: .center)
//            }
            
            // //// ALL設定バトル動画の情報
//            Section {
//                VStack {
//                    Text("・人物が写っていない画面がデフォルトと思われる")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("・確認できたのはデフォルト含めて3種類")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("・設定5,6のデフォルト比率は合算で2/6で33%だった")
//                }
//                .foregroundStyle(Color.secondary)
//            } header: {
//                Text("試打動画からの考察")
//            }
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // デフォルト
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[0]),
                            keyword: self.imageNameList[0],
                            currentKeyword: self.$selectedImageName,
                            count: $magia.atScreenCountDefault,
                            minusCheck: $magia.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 356示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[1]),
                            keyword: self.imageNameList[1],
                            currentKeyword: self.$selectedImageName,
                            count: $magia.atScreenCount356,
                            minusCheck: $magia.minusCheck
                        )
                        // 246示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[2]),
                            keyword: self.imageNameList[2],
                            currentKeyword: self.$selectedImageName,
                            count: $magia.atScreenCount246,
                            minusCheck: $magia.minusCheck
                        )
                        // 6濃厚
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[3]),
                            keyword: self.imageNameList[3],
                            currentKeyword: self.$selectedImageName,
                            count: $magia.atScreenCountOver6,
                            minusCheck: $magia.minusCheck
                        )
                    }
                }
                .frame(height: 120)
//                .popoverTip(tipVer271MagiaAtScreen())
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $magia.atScreenCountDefault,
                    flashColor: .gray,
                    bigNumber: $magia.atScreenCountSum
                )
                // 356示唆
                unitResultCountListPercent(
                    title: "設定3,5,6 示唆",
                    count: $magia.atScreenCount356,
                    flashColor: .blue,
                    bigNumber: $magia.atScreenCountSum
                )
                // 246示唆
                unitResultCountListPercent(
                    title: "設定2,4,6 示唆",
                    count: $magia.atScreenCount246,
                    flashColor: .yellow,
                    bigNumber: $magia.atScreenCountSum
                )
                // 6濃厚
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $magia.atScreenCountOver6,
                    flashColor: .pink,
                    bigNumber: $magia.atScreenCountSum
                )
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver271.magiaMenuAtScreenBadgeStatus != "none" {
//                ver271.magiaMenuAtScreenBadgeStatus = "none"
//            }
//        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: self.$selectedImageName)
                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $magia.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetAtScreen)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    magiaViewAtScreen(magia: Magia())
}

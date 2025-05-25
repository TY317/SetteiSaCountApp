//
//  magiaViewBigScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaViewBigScreen: View {
//    @ObservedObject var ver300: Ver300
//    @ObservedObject var ver271 = Ver271()
//    @ObservedObject var magia = Magia()
    @ObservedObject var magia: Magia
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "magiaBigScreenDefault",
        "magiaBigScreen356",
        "magiaBigScreen246",
        "magiaBigScreenHigh1",
        "magiaBigScreenHigh2",
        "magiaBigScreenOver2",
        "magiaBigScreenOver4",
        "magiaBigScreenOver5",
        "magiaBigScreenOver6"
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
//                    Text("・人物が写っていない画面がデフォルト\n　選択楽曲によって変化する")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("・紹介のされ方的に以下の順で強そう")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("　フェリシア＆いろは ＜ いろは＆さな ＜ いろは＆やちよ＆鶴乃 ＜ いろは＆やちよ＆ももこチーム ＜ 水着")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .font(.caption)
//                    Text("・設定5,6のデフォルト比率は合算で6/10で60%だった")
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
                            count: $magia.bigScreenCountDefault,
                            minusCheck: $magia.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 356示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[1]),
                            keyword: self.imageNameList[1],
                            currentKeyword: self.$selectedImageName,
                            count: $magia.bigScreenCount356,
                            minusCheck: $magia.minusCheck
                        )
                        // 246示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[2]),
                            keyword: self.imageNameList[2],
                            currentKeyword: self.$selectedImageName,
                            count: $magia.bigScreenCount246,
                            minusCheck: $magia.minusCheck
                        )
                        // 高設定示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[3]),
                            keyword: self.imageNameList[3],
                            currentKeyword: self.$selectedImageName,
                            count: $magia.bigScreenCountHigh1,
                            minusCheck: $magia.minusCheck
                        )
                        // 高設定示唆 ももこチーム
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[4]),
                            keyword: self.imageNameList[4],
                            currentKeyword: self.$selectedImageName,
                            count: $magia.bigScreenCountHigh2,
                            minusCheck: $magia.minusCheck
                        )
                        // 設定2以上
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[5]),
                            keyword: self.imageNameList[5],
                            currentKeyword: self.$selectedImageName,
                            count: $magia.bigScreenCountOver2,
                            minusCheck: $magia.minusCheck
                        )
                        // 設定4以上
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[6]),
                            keyword: self.imageNameList[6],
                            currentKeyword: self.$selectedImageName,
                            count: $magia.bigScreenCountOver4,
                            minusCheck: $magia.minusCheck
                        )
                        // 設定5以上
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[7]),
                            keyword: self.imageNameList[7],
                            currentKeyword: self.$selectedImageName,
                            count: $magia.bigScreenCountOver5,
                            minusCheck: $magia.minusCheck
                        )
                        // 設定6以上
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[8]),
                            keyword: self.imageNameList[8],
                            currentKeyword: self.$selectedImageName,
                            count: $magia.bigScreenCountOver6,
                            minusCheck: $magia.minusCheck
                        )
                    }
                }
                .frame(height: 120)
//                .popoverTip(tipVer300MagiaScreen())
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $magia.bigScreenCountDefault,
                    flashColor: .gray,
                    bigNumber: $magia.bigScreenCountSum
                )
                // 356示唆
                unitResultCountListPercent(
                    title: "設定3,5,6 示唆",
                    count: $magia.bigScreenCount356,
                    flashColor: .blue,
                    bigNumber: $magia.bigScreenCountSum
                )
                // 246示唆
                unitResultCountListPercent(
                    title: "設定2,4,6 示唆",
                    count: $magia.bigScreenCount246,
                    flashColor: .yellow,
                    bigNumber: $magia.bigScreenCountSum
                )
                // 高設定示唆
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $magia.bigScreenCountHigh1,
                    flashColor: .personalSummerLightGreen,
                    bigNumber: $magia.bigScreenCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $magia.bigScreenCountHigh2,
                    flashColor: .green,
                    bigNumber: $magia.bigScreenCountSum
                )
                // 設定2以上
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $magia.bigScreenCountOver2,
                    flashColor: .cyan,
                    bigNumber: $magia.bigScreenCountSum
                )
                // 設定4以上
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $magia.bigScreenCountOver4,
                    flashColor: .red,
                    bigNumber: $magia.bigScreenCountSum
                )
                // 設定5以上
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $magia.bigScreenCountOver5,
                    flashColor: .purple,
                    bigNumber: $magia.bigScreenCountSum
                )
                // 設定6以上
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $magia.bigScreenCountOver6,
                    flashColor: .orange,
                    bigNumber: $magia.bigScreenCountSum
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
//            if ver300.magiaMenuBonusScreenBadgeStatus != "none" {
//                ver300.magiaMenuBonusScreenBadgeStatus = "none"
//            }
//        }
        .navigationTitle("BIG終了画面")
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
                    unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetBigScreen)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    magiaViewBigScreen(
//        ver300: Ver300(),
        magia: Magia()
    )
}

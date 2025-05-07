//
//  mahjongViewAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/19.
//

import SwiftUI

struct mahjongViewAtScreen: View {
    @ObservedObject var mahjong: Mahjong
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "mahjongAtScreenDefault",
        "mahjongAtScreenHighJaku",
        "mahjongAtScreenHighKyo",
        "mahjongAtScreen2Over",
        "mahjongAtScreen4Over",
        "mahjongAtScreen6Over"
    ]
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // デフォルト
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[0]),
                            keyword: self.imageNameList[0],
                            currentKeyword: self.$selectedImageName,
                            count: $mahjong.atScreenCountDefault,
                            minusCheck: $mahjong.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 高設定示唆　弱
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[1]),
                            keyword: self.imageNameList[1],
                            currentKeyword: self.$selectedImageName,
                            count: $mahjong.atScreenCountHighJaku,
                            minusCheck: $mahjong.minusCheck
                        )
                        // 高設定示唆　強
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[2]),
                            keyword: self.imageNameList[2],
                            currentKeyword: self.$selectedImageName,
                            count: $mahjong.atScreenCountHighKyo,
                            minusCheck: $mahjong.minusCheck
                        )
                        // 設定２以上
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[3]),
                            keyword: self.imageNameList[3],
                            currentKeyword: self.$selectedImageName,
                            count: $mahjong.atScreenCount2Over,
                            minusCheck: $mahjong.minusCheck
                        )
                        // 設定４以上
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[4]),
                            keyword: self.imageNameList[4],
                            currentKeyword: self.$selectedImageName,
                            count: $mahjong.atScreenCount4Over,
                            minusCheck: $mahjong.minusCheck
                        )
                        // 設定6以上
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[5]),
                            keyword: self.imageNameList[5],
                            currentKeyword: self.$selectedImageName,
                            count: $mahjong.atScreenCount6Over,
                            minusCheck: $mahjong.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $mahjong.atScreenCountDefault,
                    flashColor: .gray,
                    bigNumber: $mahjong.atScreenCountSum
                )
                // 高設定示唆　弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $mahjong.atScreenCountHighJaku,
                    flashColor: .blue,
                    bigNumber: $mahjong.atScreenCountSum
                )
                // 高設定示唆　強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $mahjong.atScreenCountHighKyo,
                    flashColor: .yellow,
                    bigNumber: $mahjong.atScreenCountSum
                )
                // 設定２以上
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $mahjong.atScreenCount2Over,
                    flashColor: .green,
                    bigNumber: $mahjong.atScreenCountSum
                )
                // 設定4以上
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $mahjong.atScreenCount4Over,
                    flashColor: .red,
                    bigNumber: $mahjong.atScreenCountSum
                )
                // 設定6以上
                unitResultCountListPercent(
                    title: "設定6 以上濃厚",
                    count: $mahjong.atScreenCount6Over,
                    flashColor: .purple,
                    bigNumber: $mahjong.atScreenCountSum
                )
            }
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
                    unitButtonMinusCheck(minusCheck: $mahjong.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: mahjong.resetAtScreen)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    mahjongViewAtScreen(mahjong: Mahjong())
}

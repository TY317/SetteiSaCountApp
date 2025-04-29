//
//  kaijiViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/23.
//

import SwiftUI
import TipKit

struct kaijiViewScreen: View {
//    @ObservedObject var ver260 = Ver260()
//    @ObservedObject var kaiji = Kaiji()
    @ObservedObject var kaiji: Kaiji
    @State var isShowAlert: Bool = false
    let imageNameList: [String] = [
        "kaijiScreenKaijiRed",
        "kaijiScreenDog",
        "kaijiScreenKaijiShower",
        "kaijiScreenGakubuchi1",
        "kaijiScreenGakubuchi2",
        "kaijiScreenKaijiWhite",
        "kaijiScreenTonegawa",
        "kaijiScreenHancho",
        "kaijiScreenMikoko",
        "kaijiScreenBunny"
    ]
    @State var selectedImageName: String = ""
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
                            count: $kaiji.screenCountDefault,
                            minusCheck: $kaiji.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 偶数示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[1]),
                            keyword: self.imageNameList[1],
                            currentKeyword: self.$selectedImageName,
                            count: $kaiji.screenCountGusu,
                            minusCheck: $kaiji.minusCheck
                        )
                        // 高設定示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[2]),
                            keyword: self.imageNameList[2],
                            currentKeyword: self.$selectedImageName,
                            count: $kaiji.screenCountShower,
                            minusCheck: $kaiji.minusCheck
                        )
                        // 設定２以上
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[3]),
                            keyword: self.imageNameList[3],
                            currentKeyword: self.$selectedImageName,
                            count: $kaiji.screenCountOver2,
                            minusCheck: $kaiji.minusCheck
                        )
                        // トネガワ
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[6]),
                            keyword: self.imageNameList[6],
                            currentKeyword: self.$selectedImageName,
                            count: $kaiji.screenCountTonegawa,
                            minusCheck: $kaiji.minusCheck
                        )
                        // ハンチョウ
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[7]),
                            keyword: self.imageNameList[7],
                            currentKeyword: self.$selectedImageName,
                            count: $kaiji.screenCountHancho,
                            minusCheck: $kaiji.minusCheck
                        )
                        // みここ
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[8]),
                            keyword: self.imageNameList[8],
                            currentKeyword: self.$selectedImageName,
                            count: $kaiji.screenCountMikoko,
                            minusCheck: $kaiji.minusCheck
                        )
                        // バニー
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[9]),
                            keyword: self.imageNameList[9],
                            currentKeyword: self.$selectedImageName,
                            count: $kaiji.screenCountBunny,
                            minusCheck: $kaiji.minusCheck
                        )
                        // 沼ボーナス後専用
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[4]),
                            keyword: self.imageNameList[4],
                            currentKeyword: self.$selectedImageName,
                            count: $kaiji.screenCountSenyo,
                            minusCheck: $kaiji.minusCheck
                        )
                        // エンディング後専用
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[5]),
                            keyword: self.imageNameList[5],
                            currentKeyword: self.$selectedImageName,
                            count: $kaiji.screenCountSenyo,
                            minusCheck: $kaiji.minusCheck
                        )
                    }
//                    .popoverTip(tipVer260KaijiScreen())
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $kaiji.screenCountDefault,
                    flashColor: .gray,
                    bigNumber: $kaiji.screenCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $kaiji.screenCountGusu,
                    flashColor: .yellow,
                    bigNumber: $kaiji.screenCountSum
                )
                // 高設定示唆
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $kaiji.screenCountShower,
                    flashColor: .green,
                    bigNumber: $kaiji.screenCountSum
                )
                // 設定２以上
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $kaiji.screenCountOver2,
                    flashColor: .blue,
                    bigNumber: $kaiji.screenCountSum
                )
                // トネガワ
                unitResultCountListPercent(
                    title: "設定2,3 否定\n+高設定示唆 強",
                    count: $kaiji.screenCountTonegawa,
                    flashColor: .cyan,
                    bigNumber: $kaiji.screenCountSum
                )
                // ハンチョウ
                unitResultCountListPercent(
                    title: "設定2,3,4 否定\n高設定示唆 強",
                    count: $kaiji.screenCountHancho,
                    flashColor: .red,
                    bigNumber: $kaiji.screenCountSum
                )
                // みここ
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $kaiji.screenCountMikoko,
                    flashColor: .purple,
                    bigNumber: $kaiji.screenCountSum
                )
                // 札束風呂
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $kaiji.screenCountBunny,
                    flashColor: .orange,
                    bigNumber: $kaiji.screenCountSum
                )
                // 専用画面
                unitResultCountListWithoutRatio(
                    title: "専用画面",
                    count: $kaiji.screenCountSenyo
                )
            }
        }
//        .onAppear {
//            if ver260.kaijiMenuScreenBadgeStatus != "none" {
//                ver260.kaijiMenuScreenBadgeStatus = "none"
//            }
//        }
        .navigationTitle("ボーナス終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: self.$selectedImageName)
                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $kaiji.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: kaiji.resetScreen)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    kaijiViewScreen(kaiji: Kaiji())
}

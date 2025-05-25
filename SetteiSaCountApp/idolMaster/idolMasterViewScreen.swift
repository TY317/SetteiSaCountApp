//
//  idolMasterViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct idolMasterViewScreen: View {
    @ObservedObject var idolMaster: IdolMaster
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "idolMasterScreenDefault",
        "idolMasterScreenKisuJaku",
        "idolMasterScreenKisuKyo",
        "idolMasterScreenGusuJaku",
        "idolMasterScreenGusuKyo",
        "idolMasterScreenHighJaku",
        "idolMasterScreenHighChu",
        "idolMasterScreenHighKyo",
        "idolMasterScreenGold",
        "idolMasterScreenRainbow"
    ]
    
    var body: some View {
        List {
            Section {
                VStack {
                    Text("・画面種類が多いので基本枠色で判断")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・白枠はバレンタインデー、ホワイトデー以外がデフォルト")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // デフォルト
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[0]),
                            keyword: self.imageNameList[0],
                            currentKeyword: self.$selectedImageName,
                            count: $idolMaster.screenCountDefault,
                            minusCheck: $idolMaster.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 奇数弱
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[1]),
                            keyword: self.imageNameList[1],
                            currentKeyword: self.$selectedImageName,
                            count: $idolMaster.screenCountKisuJaku,
                            minusCheck: $idolMaster.minusCheck
                        )
                        // 奇数弱
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[2]),
                            keyword: self.imageNameList[2],
                            currentKeyword: self.$selectedImageName,
                            count: $idolMaster.screenCountKisuKyo,
                            minusCheck: $idolMaster.minusCheck
                        )
                        // 偶数弱
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[3]),
                            keyword: self.imageNameList[3],
                            currentKeyword: self.$selectedImageName,
                            count: $idolMaster.screenCountGusuJaku,
                            minusCheck: $idolMaster.minusCheck
                        )
                        // 偶数強
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[4]),
                            keyword: self.imageNameList[4],
                            currentKeyword: self.$selectedImageName,
                            count: $idolMaster.screenCountGusuKyo,
                            minusCheck: $idolMaster.minusCheck
                        )
                        // 高設定弱
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[5]),
                            keyword: self.imageNameList[5],
                            currentKeyword: self.$selectedImageName,
                            count: $idolMaster.screenCountHighJaku,
                            minusCheck: $idolMaster.minusCheck
                        )
                        // 高設定中
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[6]),
                            keyword: self.imageNameList[6],
                            currentKeyword: self.$selectedImageName,
                            count: $idolMaster.screenCountHighChu,
                            minusCheck: $idolMaster.minusCheck
                        )
                        // 高設定強
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[7]),
                            keyword: self.imageNameList[7],
                            currentKeyword: self.$selectedImageName,
                            count: $idolMaster.screenCountHighKyo,
                            minusCheck: $idolMaster.minusCheck
                        )
                        // 金枠
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[8]),
                            keyword: self.imageNameList[8],
                            currentKeyword: self.$selectedImageName,
                            count: $idolMaster.screenCountGold,
                            minusCheck: $idolMaster.minusCheck
                        )
                        // 虹枠
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[9]),
                            keyword: self.imageNameList[9],
                            currentKeyword: self.$selectedImageName,
                            count: $idolMaster.screenCountRainbow,
                            minusCheck: $idolMaster.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $idolMaster.screenCountDefault,
                    flashColor: .gray,
                    bigNumber: $idolMaster.screenCountSum
                )
                // 奇数弱
                unitResultCountListPercent(
                    title: "奇数示唆 弱",
                    count: $idolMaster.screenCountKisuJaku,
                    flashColor: .cyan,
                    bigNumber: $idolMaster.screenCountSum
                )
                // 奇数強
                unitResultCountListPercent(
                    title: "奇数示唆 強",
                    count: $idolMaster.screenCountKisuKyo,
                    flashColor: .blue,
                    bigNumber: $idolMaster.screenCountSum
                )
                // 偶数弱
                unitResultCountListPercent(
                    title: "偶数示唆 弱",
                    count: $idolMaster.screenCountGusuJaku,
                    flashColor: .yellow,
                    bigNumber: $idolMaster.screenCountSum
                )
                // 偶数強
                unitResultCountListPercent(
                    title: "偶数示唆 強",
                    count: $idolMaster.screenCountGusuKyo,
                    flashColor: .green,
                    bigNumber: $idolMaster.screenCountSum
                )
                // 高設定示唆弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $idolMaster.screenCountHighJaku,
                    flashColor: .red,
                    bigNumber: $idolMaster.screenCountSum
                )
                // 高設定示唆中
                unitResultCountListPercent(
                    title: "高設定示唆 中",
                    count: $idolMaster.screenCountHighChu,
                    flashColor: .purple,
                    bigNumber: $idolMaster.screenCountSum
                )
                // 高設定示唆強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $idolMaster.screenCountHighKyo,
                    flashColor: .gray,
                    bigNumber: $idolMaster.screenCountSum
                )
                // 金枠
                unitResultCountListPercent(
                    title: "高設定示唆 強強",
                    count: $idolMaster.screenCountGold,
                    flashColor: .orange,
                    bigNumber: $idolMaster.screenCountSum
                )
                // 高設定示唆弱
                unitResultCountListPercent(
                    title: "高設定示唆 最強",
                    count: $idolMaster.screenCountRainbow,
                    flashColor: .pink,
                    bigNumber: $idolMaster.screenCountSum
                )
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "アイドルマスター ミリオンライブ！",
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: self.$selectedImageName)
                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $idolMaster.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: idolMaster.resetScreen)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    idolMasterViewScreen(idolMaster: IdolMaster())
}

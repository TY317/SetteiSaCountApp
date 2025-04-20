//
//  yoshimuneViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/19.
//

import SwiftUI

struct yoshimuneViewScreen: View {
    @ObservedObject var yoshimune: Yoshimune
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "yoshimuneHanafudaNone",
        "yoshimuneHanafudaAotan",
        "yoshimuneHanafudaAkatan",
        "yoshimuneHanafudaYanagi",
        "yoshimuneHanafudaMatsu",
        "yoshimuneHanafudaSusuki",
        "yoshimuneHanafudaSakura",
        "yoshimuneHanafudaKiri"
    ]
    
    var body: some View {
        List {
            VStack {
                Text("・リール左のミニウィンドウに花札が表示される場合がある")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・花札の種類で設定を示唆")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundStyle(Color.secondary)
            .font(.caption)
            
            // //// 画面選択ボタン
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    // なし
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[0]),
                        keyword: self.imageNameList[0],
                        currentKeyword: self.$selectedImageName,
                        count: $yoshimune.hanafudaCountDefault,
                        minusCheck: $yoshimune.minusCheck
                    )
                    .popoverTip(tipUnitButtonScreenChoice())
                    // 青短
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[1]),
                        keyword: self.imageNameList[1],
                        currentKeyword: self.$selectedImageName,
                        count: $yoshimune.hanafudaCountHighJaku,
                        minusCheck: $yoshimune.minusCheck
                    )
                    // 赤短
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[2]),
                        keyword: self.imageNameList[2],
                        currentKeyword: self.$selectedImageName,
                        count: $yoshimune.hanafudaCountHighKyo,
                        minusCheck: $yoshimune.minusCheck
                    )
                    // 柳
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[3]),
                        keyword: self.imageNameList[3],
                        currentKeyword: self.$selectedImageName,
                        count: $yoshimune.hanafudaCount2Over,
                        minusCheck: $yoshimune.minusCheck
                    )
                    // 松
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[4]),
                        keyword: self.imageNameList[4],
                        currentKeyword: self.$selectedImageName,
                        count: $yoshimune.hanafudaCount3Over,
                        minusCheck: $yoshimune.minusCheck
                    )
                    // ススキ
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[5]),
                        keyword: self.imageNameList[5],
                        currentKeyword: self.$selectedImageName,
                        count: $yoshimune.hanafudaCount4Over,
                        minusCheck: $yoshimune.minusCheck
                    )
                    // 桜
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[6]),
                        keyword: self.imageNameList[6],
                        currentKeyword: self.$selectedImageName,
                        count: $yoshimune.hanafudaCount5Over,
                        minusCheck: $yoshimune.minusCheck
                    )
                    // 桐
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[7]),
                        keyword: self.imageNameList[7],
                        currentKeyword: self.$selectedImageName,
                        count: $yoshimune.hanafudaCount6Over,
                        minusCheck: $yoshimune.minusCheck
                    )
                }
            }
            .frame(height: 120)
            
            // //// カウント結果
            // 花札なし
            unitResultCountListPercent(
                title: "花札なし",
                count: $yoshimune.hanafudaCountDefault,
                flashColor: .gray,
                bigNumber: $yoshimune.hanafudaCountSum
            )
            // 高設定示唆 弱
            unitResultCountListPercent(
                title: "高設定示唆 弱",
                count: $yoshimune.hanafudaCountHighJaku,
                flashColor: .blue,
                bigNumber: $yoshimune.hanafudaCountSum
            )
            // 高設定示唆 強
            unitResultCountListPercent(
                title: "高設定示唆 強",
                count: $yoshimune.hanafudaCountHighKyo,
                flashColor: .yellow,
                bigNumber: $yoshimune.hanafudaCountSum
            )
            // 設定2以上
            unitResultCountListPercent(
                title: "設定2 以上濃厚",
                count: $yoshimune.hanafudaCount2Over,
                flashColor: .cyan,
                bigNumber: $yoshimune.hanafudaCountSum
            )
            // 設定3以上
            unitResultCountListPercent(
                title: "設定3 以上濃厚",
                count: $yoshimune.hanafudaCount3Over,
                flashColor: .orange,
                bigNumber: $yoshimune.hanafudaCountSum
            )
            // 設定4以上
            unitResultCountListPercent(
                title: "設定4 以上濃厚",
                count: $yoshimune.hanafudaCount4Over,
                flashColor: .green,
                bigNumber: $yoshimune.hanafudaCountSum
            )
            // 設定5以上
            unitResultCountListPercent(
                title: "設定5 以上濃厚",
                count: $yoshimune.hanafudaCount5Over,
                flashColor: .red,
                bigNumber: $yoshimune.hanafudaCountSum
            )
            // 設定6以上
            unitResultCountListPercent(
                title: "設定6 濃厚",
                count: $yoshimune.hanafudaCount6Over,
                flashColor: .purple,
                bigNumber: $yoshimune.hanafudaCountSum
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
                    unitButtonMinusCheck(minusCheck: $yoshimune.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: yoshimune.resetScreen)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    yoshimuneViewScreen(yoshimune: Yoshimune())
}

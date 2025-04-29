//
//  mhrViewBonusScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/05.
//

import SwiftUI
import TipKit

struct mhrViewBonusScreen: View {
//    @ObservedObject var mhr = Mhr()
    @ObservedObject var mhr: Mhr
    @State var isShowAlert: Bool = false
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // 男性キャラ
                        unitButtonScreenChoice(
                            image: Image(mhr.bonusScreenKeywordList[0]),
                            keyword: mhr.bonusScreenKeywordList[0],
                            currentKeyword: $mhr.bonusScreenCurrentKeyword,
                            count: $mhr.bonusScreenCountMen,
                            minusCheck: $mhr.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 女性キャラ
                        unitButtonScreenChoice(
                            image: Image(mhr.bonusScreenKeywordList[1]),
                            keyword: mhr.bonusScreenKeywordList[1],
                            currentKeyword: $mhr.bonusScreenCurrentKeyword,
                            count: $mhr.bonusScreenCountWomen,
                            minusCheck: $mhr.minusCheck
                        )
                        // YOU
                        unitButtonScreenChoice(
                            image: Image(mhr.bonusScreenKeywordList[2]),
                            keyword: mhr.bonusScreenKeywordList[2],
                            currentKeyword: $mhr.bonusScreenCurrentKeyword,
                            count: $mhr.bonusScreenCountYou,
                            minusCheck: $mhr.minusCheck
                        )
                        // 3人
                        unitButtonScreenChoice(
                            image: Image(mhr.bonusScreenKeywordList[3]),
                            keyword: mhr.bonusScreenKeywordList[3],
                            currentKeyword: $mhr.bonusScreenCurrentKeyword,
                            count: $mhr.bonusScreenCount3Person,
                            minusCheck: $mhr.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // 男性キャラ
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $mhr.bonusScreenCountMen,
                    flashColor: .blue,
                    bigNumber: $mhr.bonusScreenCountSum
                )
                // 女性キャラ
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $mhr.bonusScreenCountWomen,
                    flashColor: .yellow,
                    bigNumber: $mhr.bonusScreenCountSum
                )
                // YOU
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $mhr.bonusScreenCountYou,
                    flashColor: .green,
                    bigNumber: $mhr.bonusScreenCountSum
                )
                // 3人
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $mhr.bonusScreenCount3Person,
                    flashColor: .red,
                    bigNumber: $mhr.bonusScreenCountSum
                )
            } header: {
                Text("ボーナス確定画面")
            }
            
            // //// ボイス示唆の情報
            Section {
                unitLinkButton(
                    title: "特殊停止ボイスでの示唆について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "特殊停止ボイスでの示唆",
                            textBody1: "・ボーナス図柄の狙えカットイン発生時のリール停止時に特殊ボイスで設定を示唆する場合あり",
                            image1: Image("mhrVoice")
                        )
                    )
                )
            } header: {
                Text("特殊停止ボイスでの示唆")
            }
//            .popoverTip(tipVer180MhrVoiceAdd())
        }
        .navigationTitle("ボーナス確定画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                // 画面選択解除
                unitButtonToolbarScreenSelectReset(currentKeyword: $mhr.bonusScreenCurrentKeyword)
                    .popoverTip(tipUnitButtonScreenChoiceClear())
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $mhr.minusCheck)
                // リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mhr.resetBonusScreen)
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    mhrViewBonusScreen(mhr: Mhr())
}

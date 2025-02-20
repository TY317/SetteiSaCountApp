//
//  sevenSwordsViewStScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/14.
//

import SwiftUI

struct sevenSwordsViewStScreen: View {
    @ObservedObject var sevenSwords = SevenSwords()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            // //// 画面選択ボタン
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    // ナナオ
                    unitButtonScreenChoice(
                        image: Image(sevenSwords.stScreenKeywordList[0]),
                        keyword: sevenSwords.stScreenKeywordList[0],
                        currentKeyword: $sevenSwords.stScreenCurrentKeyword,
                        count: $sevenSwords.stScreenCountDefault,
                        minusCheck: $sevenSwords.minusCheck
                    )
                    .popoverTip(tipUnitButtonScreenChoice())
                    // 裏切りの月夜
                    unitButtonScreenChoice(
                        image: Image(sevenSwords.stScreenKeywordList[1]),
                        keyword: sevenSwords.stScreenKeywordList[1],
                        currentKeyword: $sevenSwords.stScreenCurrentKeyword,
                        count: $sevenSwords.stScreenCountKisu,
                        minusCheck: $sevenSwords.minusCheck
                    )
                    // オリバー＆グレンヴィル
                    unitButtonScreenChoice(
                        image: Image(sevenSwords.stScreenKeywordList[2]),
                        keyword: sevenSwords.stScreenKeywordList[2],
                        currentKeyword: $sevenSwords.stScreenCurrentKeyword,
                        count: $sevenSwords.stScreenCountGusu,
                        minusCheck: $sevenSwords.minusCheck
                    )
                }
            }
            .frame(height: 120)
            
            // //// カウント結果
            // デフォルト
            unitResultCountListPercent(
                title: "デフォルト",
                count: $sevenSwords.stScreenCountDefault,
                flashColor: .gray,
                bigNumber: $sevenSwords.stScreenCountSum
            )
            // 奇数示唆
            unitResultCountListPercent(
                title: "奇数示唆",
                count: $sevenSwords.stScreenCountKisu,
                flashColor: .blue,
                bigNumber: $sevenSwords.stScreenCountSum
            )
            // 偶数示唆
            unitResultCountListPercent(
                title: "偶数示唆",
                count: $sevenSwords.stScreenCountGusu,
                flashColor: .yellow,
                bigNumber: $sevenSwords.stScreenCountSum
            )
        }
        .navigationTitle("ST終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: $sevenSwords.stScreenCurrentKeyword)
                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $sevenSwords.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: sevenSwords.resetStScreen)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    sevenSwordsViewStScreen()
}

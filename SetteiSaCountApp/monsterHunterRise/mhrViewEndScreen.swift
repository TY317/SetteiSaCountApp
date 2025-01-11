//
//  mhrViewEndScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/05.
//

import SwiftUI

struct mhrViewEndScreen: View {
    @ObservedObject var mhr = Mhr()
    @State var isShowAlert: Bool = false
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // ワドウ丸
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[0]),
                            keyword: mhr.endScreenKeywordList[0],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountKisu,
                            minusCheck: $mhr.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // ルーク
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[1]),
                            keyword: mhr.endScreenKeywordList[1],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountKisu,
                            minusCheck: $mhr.minusCheck
                        )
                        // HARUTO
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[2]),
                            keyword: mhr.endScreenKeywordList[2],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountKisu,
                            minusCheck: $mhr.minusCheck
                        )
                        // アッシュ
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[3]),
                            keyword: mhr.endScreenKeywordList[3],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountGusu,
                            minusCheck: $mhr.minusCheck
                        )
                        // Mimi
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[4]),
                            keyword: mhr.endScreenKeywordList[4],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountGusu,
                            minusCheck: $mhr.minusCheck
                        )
                        // つばき
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[5]),
                            keyword: mhr.endScreenKeywordList[5],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountTsubaki,
                            minusCheck: $mhr.minusCheck
                        )
                        // YOU&オトモ
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[6]),
                            keyword: mhr.endScreenKeywordList[6],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountYouOtomo,
                            minusCheck: $mhr.minusCheck
                        )
                        // Lara&ミランダ＆隊長
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[7]),
                            keyword: mhr.endScreenKeywordList[7],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountLaraMilandaTaichoIndoor,
                            minusCheck: $mhr.minusCheck
                        )
                        // イオリ＆ヨモギ
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[8]),
                            keyword: mhr.endScreenKeywordList[8],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountIoriYomogi,
                            minusCheck: $mhr.minusCheck
                        )
                        // ウツシ＆フゲン
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[9]),
                            keyword: mhr.endScreenKeywordList[9],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountUtsushiFugen,
                            minusCheck: $mhr.minusCheck
                        )
                        // 全員集合
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[10]),
                            keyword: mhr.endScreenKeywordList[10],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountAll,
                            minusCheck: $mhr.minusCheck
                        )
                        // ヒノエ＆ミノト＆エンタライオン
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[11]),
                            keyword: mhr.endScreenKeywordList[11],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountHinoeMinotoEnta,
                            minusCheck: $mhr.minusCheck
                        )
                        // ルーク＆HARUTO＆Mimi
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[12]),
                            keyword: mhr.endScreenKeywordList[12],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountLukeHarutoMimi,
                            minusCheck: $mhr.minusCheck
                        )
                        // ワドウ丸＆アッシュ＆つばき
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[13]),
                            keyword: mhr.endScreenKeywordList[13],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountWadoAshTsubaki,
                            minusCheck: $mhr.minusCheck
                        )
                        // Lara&ミランダ＆隊長 屋外
                        unitButtonScreenChoice(
                            image: Image(mhr.endScreenKeywordList[14]),
                            keyword: mhr.endScreenKeywordList[14],
                            currentKeyword: $mhr.endScreenCurrentKeyword,
                            count: $mhr.endScreenCountLaraMilandaTaichoOutdoor,
                            minusCheck: $mhr.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // 奇数示唆
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $mhr.endScreenCountKisu,
                    flashColor: .blue,
                    bigNumber: $mhr.endScreenCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $mhr.endScreenCountGusu,
                    flashColor: .yellow,
                    bigNumber: $mhr.endScreenCountSum
                )
                // つばき
                unitResultCountListPercent(
                    title: "１・４・５・６ 示唆",
                    count: $mhr.endScreenCountTsubaki,
                    flashColor: .green,
                    bigNumber: $mhr.endScreenCountSum
                )
                // YOU&オトモ
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $mhr.endScreenCountYouOtomo,
                    flashColor: .red,
                    bigNumber: $mhr.endScreenCountSum
                )
                // Lara＆ミランダ＆隊長　屋内
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $mhr.endScreenCountLaraMilandaTaichoIndoor,
                    flashColor: .purple,
                    bigNumber: $mhr.endScreenCountSum
                )
                // イオリ＆ヨモギ
                unitResultCountListPercent(
                    title: "設定2 否定",
                    count: $mhr.endScreenCountIoriYomogi,
                    flashColor: .mint,
                    bigNumber: $mhr.endScreenCountSum
                )
                // ウツシ＆フゲン
                unitResultCountListPercent(
                    title: "設定3 否定",
                    count: $mhr.endScreenCountUtsushiFugen,
                    flashColor: .orange,
                    bigNumber: $mhr.endScreenCountSum
                )
                // 全員集合
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $mhr.endScreenCountAll,
                    flashColor: .pink,
                    bigNumber: $mhr.endScreenCountSum
                )
                // ヒノエ＆ミノト＆エンタライオン
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $mhr.endScreenCountHinoeMinotoEnta,
                    flashColor: .brown,
                    bigNumber: $mhr.endScreenCountSum
                )
                // ルーク＆HARUTO＆Mimi
                unitResultCountListPercent(
                    title: "天国期待度 50％",
                    count: $mhr.endScreenCountLukeHarutoMimi,
                    flashColor: .blue,
                    bigNumber: $mhr.endScreenCountSum
                )
                // ワドウ丸＆アッシュ＆つばき
                unitResultCountListPercent(
                    title: "天国期待度 80％",
                    count: $mhr.endScreenCountWadoAshTsubaki,
                    flashColor: .yellow,
                    bigNumber: $mhr.endScreenCountSum
                )
                // Lara＆ミランダ＆隊長
                unitResultCountListPercent(
                    title: "天国 濃厚",
                    count: $mhr.endScreenCountLaraMilandaTaichoOutdoor,
                    flashColor: .red,
                    bigNumber: $mhr.endScreenCountSum
                )
            } header: {
                Text("AT終了画面")
            }
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                // 画面選択解除
                unitButtonToolbarScreenSelectReset(currentKeyword: $mhr.endScreenCurrentKeyword)
                    .popoverTip(tipUnitButtonScreenChoiceClear())
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $mhr.minusCheck)
                // リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mhr.resetEndScreen)
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    mhrViewEndScreen()
}

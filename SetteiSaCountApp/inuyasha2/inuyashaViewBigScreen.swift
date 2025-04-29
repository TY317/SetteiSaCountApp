//
//  inuyashaViewBigScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/21.
//

import SwiftUI
import TipKit


// /////////////////////
// Tip：Big種類選択について
// /////////////////////
struct tipInuyashaBigSelect: Tip {
    var title: Text {
        Text("Big種類の選択")
    }
    
    var message: Text? {
        Text("Big種類によって示唆内容変わるため最初にBig種類を選択してください")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}

struct inuyashaViewBigScreen: View {
//    @ObservedObject var inuyasha = Inuyasha()
    @ObservedObject var inuyasha: Inuyasha
    @State var isShowAlert: Bool = false
    var body: some View {
        List {
            Section {
                // //// Big種類の選択
                Picker("", selection: $inuyasha.selectedBigCharacter) {
                    ForEach(inuyasha.bigCharacterList, id: \.self) { chara in
                        Text(chara)
                    }
                }
                .pickerStyle(.segmented)
                .popoverTip(tipInuyashaBigSelect())
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20){
                        // 犬夜叉Bigの場合
                        if inuyasha.selectedBigCharacter == inuyasha.bigCharacterList[0] {
                            // デフォルト
                            unitButtonScreenChoice(
                                image: Image(inuyasha.bigScreenKeywordList[0]),
                                keyword: inuyasha.bigScreenKeywordList[0],
                                currentKeyword: $inuyasha.bigScreenCurrentKeyword,
                                count: $inuyasha.bigScreenCountDefault,
                                minusCheck: $inuyasha.minusCheck
                            )
                            .popoverTip(tipUnitButtonScreenChoice())
                            // 設定2以上
                            unitButtonScreenChoice(
                                image: Image(inuyasha.bigScreenKeywordList[3]),
                                keyword: inuyasha.bigScreenKeywordList[3],
                                currentKeyword: $inuyasha.bigScreenCurrentKeyword,
                                count: $inuyasha.bigScreenCountOver2,
                                minusCheck: $inuyasha.minusCheck
                            )
                        }
                        // 殺生丸Bigの場合
                        else {
                            // デフォルト
                            unitButtonScreenChoice(
                                image: Image(inuyasha.bigScreenKeywordList[2]),
                                keyword: inuyasha.bigScreenKeywordList[2],
                                currentKeyword: $inuyasha.bigScreenCurrentKeyword,
                                count: $inuyasha.bigScreenCountDefault,
                                minusCheck: $inuyasha.minusCheck
                            )
                            // 設定2以上
                            unitButtonScreenChoice(
                                image: Image(inuyasha.bigScreenKeywordList[1]),
                                keyword: inuyasha.bigScreenKeywordList[1],
                                currentKeyword: $inuyasha.bigScreenCurrentKeyword,
                                count: $inuyasha.bigScreenCountOver2,
                                minusCheck: $inuyasha.minusCheck
                            )
                        }
                        // 桔梗
                        unitButtonScreenChoice(
                            image: Image(inuyasha.bigScreenKeywordList[4]),
                            keyword: inuyasha.bigScreenKeywordList[4],
                            currentKeyword: $inuyasha.bigScreenCurrentKeyword,
                            count: $inuyasha.bigScreenCountHighSisa,
                            minusCheck: $inuyasha.minusCheck
                        )
                        // かごめ＆犬夜叉
                        unitButtonScreenChoice(
                            image: Image(inuyasha.bigScreenKeywordList[5]),
                            keyword: inuyasha.bigScreenKeywordList[5],
                            currentKeyword: $inuyasha.bigScreenCurrentKeyword,
                            count: $inuyasha.bigScreenCountOver4,
                            minusCheck: $inuyasha.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $inuyasha.bigScreenCountDefault,
                    flashColor: .gray,
                    bigNumber: $inuyasha.bigScreenCountSum
                )
                // 設定2 以上
                unitResultCountListPercent(
                    title: "設定2 以上",
                    count: $inuyasha.bigScreenCountOver2,
                    flashColor: .yellow,
                    bigNumber: $inuyasha.bigScreenCountSum
                )
                // 高設定示唆
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $inuyasha.bigScreenCountHighSisa,
                    flashColor: .green,
                    bigNumber: $inuyasha.bigScreenCountSum
                )
                // 設定4 以上
                unitResultCountListPercent(
                    title: "設定4 以上",
                    count: $inuyasha.bigScreenCountOver4,
                    flashColor: .red,
                    bigNumber: $inuyasha.bigScreenCountSum
                )
            } header: {
                Text("Big終了画面")
            }
        }
        .navigationTitle("Big終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                // 画面選択解除
                unitButtonToolbarScreenSelectReset(currentKeyword: $inuyasha.bigScreenCurrentKeyword)
                    .popoverTip(tipUnitButtonScreenChoiceClear())
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $inuyasha.minusCheck)
                // リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: inuyasha.resetBigScreen)
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    inuyashaViewBigScreen(inuyasha: Inuyasha())
}

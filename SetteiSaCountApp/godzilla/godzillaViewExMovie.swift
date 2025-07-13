//
//  godzillaViewExMovie.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/13.
//

import SwiftUI

struct godzillaViewExMovie: View {
    @ObservedObject var godzilla: Godzilla
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "godzillaExMovie1",
        "godzillaExMovie2",
        "godzillaExMovie3",
        "godzillaExMovie4",
        "godzillaExMovie5"
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
                            count: $godzilla.exMovieCountDefault,
                            minusCheck: $godzilla.minusCheck
                        )
                        // 高設定示唆 弱
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[1]),
                            keyword: self.imageNameList[1],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.exMovieCountHighJaku,
                            minusCheck: $godzilla.minusCheck
                        )
                        // 高設定示唆 中
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[2]),
                            keyword: self.imageNameList[2],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.exMovieCountHighChu,
                            minusCheck: $godzilla.minusCheck
                        )
                        // 高設定示唆 強
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[3]),
                            keyword: self.imageNameList[3],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.exMovieCountHighKyo,
                            minusCheck: $godzilla.minusCheck
                        )
                        // 設定5以上
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[4]),
                            keyword: self.imageNameList[4],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.exMovieCount5Over,
                            minusCheck: $godzilla.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $godzilla.exMovieCountDefault,
                    flashColor: .gray,
                    bigNumber: $godzilla.exMovieCountSum
                )
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $godzilla.exMovieCountHighJaku,
                    flashColor: .blue,
                    bigNumber: $godzilla.exMovieCountSum
                )
                // 高設定示唆 中
                unitResultCountListPercent(
                    title: "高設定示唆 中",
                    count: $godzilla.exMovieCountHighChu,
                    flashColor: .yellow,
                    bigNumber: $godzilla.exMovieCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $godzilla.exMovieCountHighKyo,
                    flashColor: .green,
                    bigNumber: $godzilla.exMovieCountSum
                )
                // 設定５以上
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $godzilla.exMovieCount5Over,
                    flashColor: .red,
                    bigNumber: $godzilla.exMovieCountSum
                )
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴジラ",
                screenClass: screenClass
            )
        }
        .navigationTitle("EXボーナス中のムービー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: self.$selectedImageName)
//                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $godzilla.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: godzilla.resetExMovie)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    godzillaViewExMovie(godzilla: Godzilla())
}

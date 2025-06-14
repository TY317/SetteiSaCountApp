//
//  midoriDonViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/08.
//

import SwiftUI

struct midoriDonViewEnding: View {
    @ObservedObject var ver340: Ver340
    @ObservedObject var midoriDon: MidoriDon
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "インディクラブ",
                            "レイリー",
                            "バックロール",
                            "ドンスペシャル",
                            "スーパーハイパードンビッグエアー",
                            "メランコリー",
                            "トゥイーク",
                            "オカワリ",
                            "ナミモリ",
                            "オニクモリモリカーニバル",
                            "グリーンマシマシハイパーアコンカグア",
                            "ヘッドスタンド",
                            "グランドクロス",
                            "ビリーグラブ",
                            "スイッチライド",
                            "オウギエアー",
                            "エアーピロウ",
                            "シラハグラブ",
                            "ピラニアングラブ",
                            "デマエ",
                            "ライダー",
                            "ハンマー",
                            "ブランコ",
                            "ナデヤネン",
                            "ミイラ",
                            "ロスト",
                            "ダン",
                            "サトウ",
                            "チュッパ",
                            "ファビオ",
                            "ハヅキ",
                            "マリア",
                            "グウカワ",
                            "ゼンインシュウゴウ",
                            "オヤジ",
                            "アオドン",
                            "ジッシャ",
                        ],
                        maxWidth: 200,
                        contentFont: .subheadline,
                        colorList: [
                            .white,
                            .white,
                            .white,
                            .white,
                            .white,
                            .white,
                            .white,
                            .white,
                            .white,
                            .white,
                            .white,
                            .personalSummerLightBlue,
                            .personalSummerLightBlue,
                            .personalSummerLightBlue,
                            .personalSummerLightBlue,
                            .personalSummerLightBlue,
                            .personalSummerLightBlue,
                            .personalSummerLightBlue,
                            .personalSummerLightBlue,
                            .personalSpringLightYellow,
                            .personalSpringLightYellow,
                            .personalSpringLightYellow,
                            .personalSpringLightYellow,
                            .personalSpringLightYellow,
                            .personalSpringLightYellow,
                            .personalSpringLightYellow,
                            .personalSummerLightGreen,
                            .personalSummerLightGreen,
                            .personalSummerLightGreen,
                            .personalSummerLightGreen,
                            .personalSummerLightRed,
                            .personalSummerLightRed,
                            .cyan,
                            .green,
                            .orange,
                            .purple,
                            .purple,
                        ]
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "必ず出現",
                            "デフォルト",
                            "高設定示唆 弱",
                            "高設定示唆 中",
                            "高設定示唆 強",
                            "設定2 以上濃厚",
                            "設定4 以上濃厚",
                            "設定5 以上濃厚",
                            "設定6 濃厚",
                        ],
                        lineList: [11,8,7,4,2,1,1,1,2],
                        contentFont: .body,
                        colorList: [
                            .white,
                            .personalSummerLightBlue,
                            .personalSpringLightYellow,
                            .personalSummerLightGreen,
                            .personalSummerLightRed,
                            .cyan,
                            .green,
                            .orange,
                            .purple,
                        ]
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } header: {
                Text("湯煙ボーナス中の紹介トリック")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver340.midoriDonMenuEndingBadgeStatus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "緑ドン",
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    midoriDonViewEnding(
        ver340: Ver340(),
        midoriDon: MidoriDon()
    )
}

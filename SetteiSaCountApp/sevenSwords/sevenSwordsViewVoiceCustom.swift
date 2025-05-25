//
//  sevenSwordsViewVoiceCustom.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import SwiftUI

struct sevenSwordsViewVoiceCustom: View {
//    @ObservedObject var ver270 = Ver270()
    
    var body: some View {
        List {
            VStack {
                Text("・総ゲーム数が2000G以上の状態でボイスカスタムをエスメラルダ（右下のキャラ）に変更した際、設定示唆ボイスが発生する場合がある")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・エスメラルダ→エスメラルダの変更ではボイスは再生されない")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・4000G,6000G,8000G以上消化でそれぞれ示唆ボイス発生率がアップ")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundStyle(Color.secondary)
            .font(.caption)
            HStack(spacing: 0, content: {
                unitTableString(
                    columTitle: "ボイス",
                    stringList: [
                        "準備はいいか！",
                        "15枚ベルを引けば引くほどデュアル状態の",
                        "七つの支配トリガーを制し、ST「Seven Spellbrades Battle」",
                        "Dual Domination Modeは、純増2倍！さらに上乗せ性能も",
                        "第4魔剣アングスタヴィア発動でフリーズ超高確率状態だ！"
                    ],
                    maxWidth: 200,
                    contentFont: .subheadline
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "偶数示唆",
                        "高設定示唆",
                        "設定 2以上",
                        "設定 4以上"
                    ],
                    maxWidth: 120
                )
            })
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "七つの魔剣が支配する",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver270.sevenSwordsMenuVoiceBadgeStatus != "none" {
//                ver270.sevenSwordsMenuVoiceBadgeStatus = "none"
//            }
//        }
        .navigationTitle("ボイスカスタムでの示唆")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    sevenSwordsViewVoiceCustom()
}

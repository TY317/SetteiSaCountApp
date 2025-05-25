//
//  kaijiViewRedBig.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct kaijiViewRedBig: View {
//    @ObservedObject var ver270 = Ver270()
    var body: some View {
        List {
            Text("赤7BIG中 1回目のBAR揃いの恩恵に設定差あり")
                .foregroundStyle(Color.secondary)
//                .font(.caption)
            HStack(spacing: 0) {
                unitTableSettingIndex(titleLine: 2)
                unitTablePercent(
                    columTitle: "運否天賦",
                    percentList: [96.9,95.3,94.9,92.2,90.6,90.2],
//                    numberofDicimal: 1
                    titleLine: 2
                )
                unitTablePercent(
                    columTitle: "トネガワ\nRUSH",
                    percentList: [2.7,4.3,4.7,7.4,9.0,9.4],
                    numberofDicimal: 1,
                    titleLine: 2,
                    titleFont: .body
                )
                unitTablePercent(
                    columTitle: "ハンチョウ\nRUSH",
                    percentList: [0.4],
                    numberofDicimal: 1,
                    titleLine: 2,
                    lineList: [6],
                    titleFont: .body
                )
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "回胴黙示録カイジ 狂宴",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver270.kaijiMenuRedBigBadgeStatus != "none" {
//                ver270.kaijiMenuRedBigBadgeStatus = "none"
//            }
//        }
        .navigationTitle("赤7BIG中のBAR揃い")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    kaijiViewRedBig()
}

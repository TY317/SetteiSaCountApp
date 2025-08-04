//
//  reSwordViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/31.
//

import SwiftUI

struct reSwordViewFirstHit: View {
    @ObservedObject var reSword: ReSword
    
    var body: some View {
        List {
            Section {
                // //// 注意書き
                Text("現在値はe-slot+で確認してください")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // //// 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率", linkText: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "CZ",
                            denominateList: reSword.ratioCz,
                        )
                        unitTableDenominate(
                            columTitle: "AT",
                            denominateList: reSword.ratioAt,
                        )
                    }
                }
            }
            
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: reSword.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    reSwordViewFirstHit(
        reSword: ReSword(),
    )
}

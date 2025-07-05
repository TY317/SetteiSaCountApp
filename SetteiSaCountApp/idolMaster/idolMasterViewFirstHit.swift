//
//  idolMasterViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct idolMasterViewFirstHit: View {
    @ObservedObject var idolMaster: IdolMaster
    
    var body: some View {
        List {
            Section {
                Text("現在値はスロプラNEXTで確認してください")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // 参考情報）初当り
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(idolMasterTableFirstHit(idolMaster: idolMaster))
                        )
                    )
                )
            } header: {
                Text("初当り")
            }
            
            // //// 広告
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "アイドルマスター ミリオンライブ！",
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ,ボーナス 初当り")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    idolMasterViewFirstHit(idolMaster: IdolMaster())
}

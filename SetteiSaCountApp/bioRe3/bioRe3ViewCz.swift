//
//  bioRe3ViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/14.
//

import SwiftUI

struct bioRe3ViewCz: View {
    @ObservedObject var bioRe3: BioRe3
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // ---- 失敗時のボイス
            Section {
                // 説明
                Text("CZ失敗時にPUSHでスルー天井を示唆")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // 参考情報）ボイス示唆
                unitLinkButtonViewBuilder(sheetTitle: "ボイス示唆") {
                    bioRe3TableCzVoice()
                }
            } header: {
                Text("失敗時のボイス")
            }
            
            // ---- スルー天井振り分け
            Section {
                // 説明
                Text("今作はスルー天井に設定差なし")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // スルー天井振り分け
                unitLinkButtonViewBuilder(sheetTitle: "スルー天井振分け") {
                    Text("・全設定共通")
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: ["1回","2回","3回","4回","5回","6回","7回",],
                            maxWidth: 80,
                        )
                        unitTablePercent(
                            columTitle: "振分け",
                            percentList: [3.5,3.5,12.5,4.7,25,4.7,46.1],
                            numberofDicimal: 1,
                        )
                    }
                }
                .popoverTip(tipVer420BioRe3Cz())
            } header: {
                Text("スルー天井")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bioRe3MenuCzBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bioRe3.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    bioRe3ViewCz(
        bioRe3: BioRe3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

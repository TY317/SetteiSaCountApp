//
//  thunderViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/15.
//

import SwiftUI

struct thunderViewScreen: View {
    @ObservedObject var thunder: Thunder
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // BIG
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("1G連時はタロットマスター風の終了画面になるが、流れ星がなければデフォルト")
                }
                
                // 示唆
                thunderTableScreenBig()
                    .frame(maxWidth: .infinity, alignment: .center)
            } header: {
                Text("BIG")
            }
            
            // REG
            Section {
                // 示唆
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "イッカククンなし",
                            "イッカククンあり",
                        ]
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "デフォルト",
                            "設定5 以上濃厚",
                        ]
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } header: {
                Text("REG")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.thunderMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: thunder.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("終了画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    thunderViewScreen(
        thunder: Thunder(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

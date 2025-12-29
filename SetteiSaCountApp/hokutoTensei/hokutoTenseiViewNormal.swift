//
//  hokutoTenseiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/27.
//

import SwiftUI

struct hokutoTenseiViewNormal: View {
    @ObservedObject var hokutoTensei: HokutoTensei
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // ---- レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    hokutoTenseiTableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // ---- 通常時のモード
            Section {
                // 参考情報）通常時のモード
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    
                }
            } header: {
                Text("通常時のモード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hokutoTenseiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hokutoTensei.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    hokutoTenseiViewNormal(
        hokutoTensei: HokutoTensei(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

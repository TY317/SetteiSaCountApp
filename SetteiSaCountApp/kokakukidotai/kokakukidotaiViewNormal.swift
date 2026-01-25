//
//  kokakukidotaiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/13.
//

import SwiftUI

struct kokakukidotaiViewNormal: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // タチコマの家出
            Section {
                // 注意書き
                HStack {
                    Text("⚠️")
                    VStack(alignment: .leading) {
                        Text("・AT終了後200or400Gでの当否がカウント対象")
                        Text("・リセット後、CZ終了後の200or400Gは対象外")
                    }
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                }
                
                // カウントボタン横並び
                
            } header: {
                Text("タチコマの家出")
            }
            
            // レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    kokakukidotaiTableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // モード
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "モードについて") {
                    
                }
            } header: {
                Text("通常時のモード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kokakukidotaiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    kokakukidotaiViewNormal(
        kokakukidotai: Kokakukidotai(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

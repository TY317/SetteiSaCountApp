//
//  darlingViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/27.
//

import SwiftUI

struct darlingViewNormal: View {
    @ObservedObject var darling: Darling
    var body: some View {
        List {
            // //// 小役関連
            Section {
                unitLinkButtonViewBuilder(
                    sheetTitle: "レア役停止系",
                    linkText: "レア役停止系",
                ) {
                        darlingTableKoyakuPattern()
                    }
            } header: {
                Text("小役")
            }
            
            // //// フランクス高確謎当り
//            Section {
//                unitLinkButtonViewBuilder(sheetTitle: "フランクス高確 謎当り") {
//                    VStack {
//                        Text("・レア役を引かずにビーチステージにいない状態でフランクス高確に当選する、いわゆる謎当りに設定差があると思われる")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                }
//            } header: {
//                Text("フランクス高確 謎当り")
//            }
            
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: darling.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    darlingViewNormal(
        darling: Darling(),
    )
}

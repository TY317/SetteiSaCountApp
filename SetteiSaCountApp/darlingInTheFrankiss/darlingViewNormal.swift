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

//
//  gundamSeedViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/10.
//

import SwiftUI

struct gundamSeedViewNormal: View {
    var body: some View {
        List {
            // //// 小役停止形
            Section {
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            tableView: AnyView(gundamSeedTableKoyakuPattern())
                        )
                    )
                )
            }
            
            // //// 広告
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ガンダムSEED",
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    gundamSeedViewNormal()
}

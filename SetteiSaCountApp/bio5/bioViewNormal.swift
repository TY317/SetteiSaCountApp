//
//  bioViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/22.
//

import SwiftUI

struct bioViewNormal: View {
//    @ObservedObject var bio = Bio()
    @ObservedObject var bio: Bio
    var body: some View {
        List {
            Section {
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            textBody1: "・弱スイカの停止形でも中リールがビタ止まりor4コマ滑りの場合は強スイカの可能性あり",
                            textBody2: "・チャンス目の停止形でも目押し位置によって強チャンス目の可能性あり",
                            image1: Image("bioKoyaku")
                        )
                    )
                )
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "バイオハザード5",
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    bioViewNormal(bio: Bio())
}

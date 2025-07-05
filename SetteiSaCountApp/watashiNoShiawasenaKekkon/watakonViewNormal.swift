//
//  watakonViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/25.
//

import SwiftUI

struct watakonViewNormal: View {
    @ObservedObject var watakon: Watakon
    var body: some View {
        List {
            // //// 小役関連
            Section {
                unitLinkButton(
                    title: "レア役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "レア役停止形",
                            tableView: AnyView(watakonTableKoyakuPattern())
                        )
                    )
                )
            } header: {
                Text("小役")
            }
            
            // //// モード
            Section {
                unitLinkButton(
                    title: "通常時のモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・5つのモードで規定ゲーム数での当選を管理",
                            textBody2: "・AT直撃時は通常時のモード・ゲーム数を引き継ぐ",
                            tableView: AnyView(watakonTableMode()),
                        )
                    )
                )
            } header: {
                Text("モード")
            }
            
            // //// 広告
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: watakon.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    watakonViewNormal(
        watakon: Watakon(),
    )
}

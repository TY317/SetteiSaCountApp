//
//  watakonViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/30.
//

import SwiftUI

struct watakonViewFirstHit: View {
    @ObservedObject var watakon: Watakon
    
    var body: some View {
        List {
            Section {
                // //// 注意書き
                Text("現在値はe-slot+で確認してください")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // //// 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(
                                watakonTableFirstHit(
                                    watakon: watakon
                                )
                            )
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
                screenName: watakon.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    watakonViewFirstHit(
        watakon: Watakon(),
    )
}

//
//  evaYakusokuViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/29.
//

import SwiftUI
//import GoogleMobileAds

struct evaYakusokuViewNormal: View {
    @ObservedObject var evaYakusoku: EvaYakusoku
    
    var body: some View {
        List {
            // //// 小役関連
            Section {
                // 小役停止形
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            tableView: AnyView(evaYakusokuTableKoyakuPattern())
                        )
                    )
                )
            } header: {
                Text("小役")
            }
            
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: evaYakusoku.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    evaYakusokuViewNormal(
        evaYakusoku: EvaYakusoku(),
    )
}

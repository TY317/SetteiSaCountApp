//
//  mahjongViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/16.
//

import SwiftUI

struct mahjongViewNormal: View {
//    @ObservedObject var mahjong = Mahjong()
    @ObservedObject var mahjong: Mahjong
    var body: some View {
        List {
            // //// 小役停止形
            unitLinkButton(
                title: "小役停止形",
                exview: AnyView(
                    unitExView5body2image(
                        title: "小役停止形",
                        image1: Image("mahjongKoyakuPattern")
                    )
                )
            )
            
            // //// 広告
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "麻雀物語",
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    mahjongViewNormal(mahjong: Mahjong())
}

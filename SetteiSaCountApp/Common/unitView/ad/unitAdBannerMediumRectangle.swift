//
//  unitAdBannerMediumRectangle.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/30.
//

import SwiftUI
import GoogleMobileAds

struct unitAdBannerMediumRectangle: View {
    @Environment(\.verticalSizeClass) private var vSize
    
    var body: some View {
        if self.vSize != .compact {
//            Section {
//                Text("")
//            }
//            .listRowBackground(Color.clear)
            Section {
//                BannerView(GADAdSizeMediumRectangle)   // ★ 300×250
                BannerAdView(AdSizeMediumRectangle)   // ★ 300×250
                    .frame(width: 300, height: 250)     // セル高さを固定
                    .frame(maxWidth: .infinity)         // 横中央寄せ
            } header: {
                Text("\n広告")    // 少し上のコンテンツとの距離を離すため頭に改行
            }
            .listRowBackground(Color.clear)
        }
    }
}

#Preview {
    unitAdBannerMediumRectangle()
}

//
//  godeaterViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/14.
//

import SwiftUI

struct godeaterViewEnding: View {
    var body: some View {
//        NavigationView {
            List {
                // //// ボイス
                Section {
                    unitLinkButton(title: "エンディング中のボイスについて", exview: AnyView(unitExView5body2image(title: "エンディング中のボイス", textBody1: "・エンディング中のレア役成立時にサブ液晶タッチで確認", textBody2: "・ボイスと示唆はストーリーパート後と同じ", image1: Image("godeaterVoice"))))
                } header: {
                    Text("ボイス")
                }
                // //// 神堕
                Section {
                    unitLinkButton(title: "エンディング後の神堕について", exview: AnyView(unitExView5body2image(title: "エンディング後の神堕", textBody1: "・エンディング後は漆黒の捕食者 or 神堕に突入", textBody2: "・高設定ほど神堕の選択率が優遇されていると言われている")))
                } header: {
                    Text("神堕")
                }
                
                // //// 広告
                unitAdBannerMediumRectangle()
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴッドイーター リザレクション",
                screenClass: screenClass
            )
        }
            .navigationTitle("エンディング")
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .navigationTitle("エンディング")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    godeaterViewEnding()
}

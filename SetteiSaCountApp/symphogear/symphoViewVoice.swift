//
//  symphoViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/18.
//

import SwiftUI

struct symphoViewVoice: View {
    var body: some View {
//        NavigationView {
            List {
                Text("AT終了画面で十字キーの下を押すと設定示唆ボイス")
                Text("上ボタンを押すとモード示唆アイコン")
                Text("どちらか片方しか確認できない")
                Image("symphoVoice1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image("symphoVoice2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "シンフォギア 正義の歌",
                screenClass: screenClass
            )
        }
            .navigationTitle("AT終了後のボイス")
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .navigationTitle("AT終了後のボイス")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    symphoViewVoice()
}

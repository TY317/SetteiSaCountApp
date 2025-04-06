//
//  magiaViewBigScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaViewBigScreen: View {
    @ObservedObject var magia = Magia()
    var body: some View {
        List {
            // /// 調査中表示
            Section {
                Text("詳細調査中")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            // //// ALL設定バトル動画の情報
            Section {
                VStack {
                    Text("・人物が写っていない画面がデフォルト\n　選択楽曲によって変化する")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・紹介のされ方的に以下の順で強そう")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("　フェリシア＆いろは ＜ いろは＆さな ＜ いろは＆やちよ＆鶴乃 ＜ いろは＆やちよ＆ももこチーム ＜ 水着")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)
                    Text("・設定5,6のデフォルト比率は合算で6/10で60%だった")
                }
                .foregroundStyle(Color.secondary)
            } header: {
                Text("試打動画からの考察")
            }
        }
        .navigationTitle("BIG終了画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    magiaViewBigScreen()
}

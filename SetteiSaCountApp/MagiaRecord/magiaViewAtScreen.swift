//
//  magiaViewAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaViewAtScreen: View {
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
                    Text("・人物が写っていない画面がデフォルトと思われる")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・確認できたのはデフォルト含めて3種類")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・設定5,6のデフォルト比率は合算で2/6で33%だった")
                }
                .foregroundStyle(Color.secondary)
            } header: {
                Text("試打動画からの考察")
            }
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    magiaViewAtScreen()
}

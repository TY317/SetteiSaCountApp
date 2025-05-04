//
//  magiaViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaViewVoice: View {
//    @ObservedObject var magia = Magia()
    @ObservedObject var magia: Magia
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
                    Text("・終了後にサブ液晶タッチでボイス発生")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・「運命を変えたいなら〜」がデフォルトと思われる")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・設定5,6のデフォルト比率は合算で6/10で60%だった")
                }
                .foregroundStyle(Color.secondary)
            } header: {
                Text("試打動画からの考察")
            }
        }
        .navigationTitle("BIG終了後ボイス")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    magiaViewVoice(magia: Magia())
}

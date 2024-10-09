//
//  exViewCzMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/12.
//

import SwiftUI

struct exViewCzModeVVV: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("・基本白マスで前兆が発生したらモードA以外")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・ただし、朝イチは前兆の状態がムチャクチャ")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・朝イチのはまりはそれほど気にしたくてもいいが、やっぱり高設定は朝も早いことが多い")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・ATか革命ボーナスを引くまでモードダウンはない")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・モード移行に設定差があると言われている")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・CZのキャラは基本設定差なし")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("　→しかし、モードD・Eの時はいいキャラ出やすい説がある")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("　→いいキャラが出る → いいモードにいる可能性アップ → 高設定の期待UP？")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding(.leading)
            
        }
        // //// タイトル
        .navigationTitle("CZ,モードに関する噂")
        .toolbarTitleDisplayMode(.inline)
        
        // //// ツールバー閉じるボタン
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("閉じる")
                        .fontWeight(.bold)
                })
            }
        }
    }
}

#Preview {
    exViewCzModeVVV()
}

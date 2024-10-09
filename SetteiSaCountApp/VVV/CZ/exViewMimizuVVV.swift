//
//  exViewMimizu.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/12.
//

import SwiftUI

struct exViewMimizuVVV: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("・朝イチ１回目の革命ボーナスまではミミズ挙動しない")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・朝イチは深くはまりやすい")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・400のゾーンで当たりやすい")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・CZは9割クリア")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・ATは伸びても超革命の保証まで(=5セット)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("（ただし、ハラキリチャレンジ中のレア役で無理やり継続はあり得る）")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("・AT後の引き戻しをしない")
                    .frame(maxWidth: .infinity, alignment: .leading)
//                Text("　→いいキャラが出る → いいモードにいる可能性アップ → 高設定の期待UP？")
//                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding(.leading)
            
        }
        // //// タイトル
        .navigationTitle("ミミズに関する噂")
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
    exViewMimizuVVV()
}

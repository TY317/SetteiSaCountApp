//
//  kingHanaExViewRegLamp.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/18.
//

import SwiftUI

struct kingHanaExViewRegLamp: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
//                    Text("[参考] キングハナハナでの確率")
//                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("・REG中に1度だけ確認可能")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・左リール中段に白７ビタ押し")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("　成功したら中・右にスイカを狙う")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・奇数設定は青・緑が６割、偶数は黄・赤が６割")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("　ただし、設定６のみ全色均等に出現する")
                        .frame(maxWidth: .infinity, alignment: .leading)
    //                Text("・CZのキャラは基本設定差なし")
    //                    .frame(maxWidth: .infinity, alignment: .leading)
    //                Text("　→しかし、モードD・Eの時はいいキャラ出やすい説がある")
    //                    .frame(maxWidth: .infinity, alignment: .leading)
    //                Text("　→いいキャラが出る → いいモードにいる可能性アップ → 高設定の期待UP？")
    //                    .frame(maxWidth: .infinity, alignment: .leading)
                    Image("kingHanaRegLampAnalysis")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding([.top, .bottom, .trailing])
                        .frame(height: 250)
                        
//                    Image("modeChange")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding(.all)
                        
                    Spacer()
                }
                .padding(.leading)
            }
            // //// タイトル
            .navigationTitle("REG中サイドランプ確率")
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
//        // //// タイトル
//        .navigationTitle("モード詳細")
//        .toolbarTitleDisplayMode(.inline)
//
//        // //// ツールバー閉じるボタン
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                Button(action: {
//                    dismiss()
//                }, label: {
//                    Text("閉じる")
//                        .fontWeight(.bold)
//                })
//            }
//        }
    }
}

#Preview {
    kingHanaExViewRegLamp()
}

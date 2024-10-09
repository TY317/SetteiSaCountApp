//
//  happyJugV3exView.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/16.
//

import SwiftUI

struct happyJugV3exView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
//                    Text("・ハラキリドライブ確率に本機最大の設定差")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("・有利区間切断は差枚+1001枚が最も有力")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("・有利切断でドライブ確率が切り替わる説が有力")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("→有利切断前はドライブ出なくても焦らずに\n　とはいえ、高設定は切断前でもドライブ\n　しやすいので、切断前に確認できれば好材料")
//                        .frame(maxWidth: .infinity, alignment: .leading)
    //                Text("・ATか革命ボーナスを引くまでモードダウンはない")
    //                    .frame(maxWidth: .infinity, alignment: .leading)
    //                Text("・モード移行に設定差があると言われている")
    //                    .frame(maxWidth: .infinity, alignment: .leading)
    //                Text("・CZのキャラは基本設定差なし")
    //                    .frame(maxWidth: .infinity, alignment: .leading)
    //                Text("　→しかし、モードD・Eの時はいいキャラ出やすい説がある")
    //                    .frame(maxWidth: .infinity, alignment: .leading)
    //                Text("　→いいキャラが出る → いいモードにいる可能性アップ → 高設定の期待UP？")
    //                    .frame(maxWidth: .infinity, alignment: .leading)
                    Image("happyJugV3Analysis")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding([.top, .bottom, .trailing])
                        
//                    Image("modeChange")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding(.all)
                        
                    Spacer()
                }
                .padding(.leading)
            }
            // //// タイトル
            .navigationTitle("ハッピージャグラーV3設定差")
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
    happyJugV3exView()
}

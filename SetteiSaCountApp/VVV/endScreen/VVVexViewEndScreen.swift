//
//  VVVexViewEndScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/13.
//

import SwiftUI

struct VVVexViewEndScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("・CZ,ボーナス終了後で共通")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・ベットボタンで画面を飛ばさないよう注意")
                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("・モードによって天井規定ゲーム数が異なる")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("・CZ、決戦ボーナスではモードダウンはない")
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
                    Image("VVVendScreenAnalysis")
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
            .navigationTitle("終了画面について")
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
    VVVexViewEndScreen()
}

//
//  kingHanaExViewAfterRegLamp.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/18.
//

import SwiftUI

struct kingHanaExViewAfterRegLamp: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
//                    Text("[参考] キングハナハナでの確率")
//                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("・色によって設定を否定してくれる")
                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("・左リール中段に白７ビタ押し")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("　成功したら中・右にスイカを狙う")
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
                    Image("kingHanaAfterRegLampAnalysis")
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
            .navigationTitle("REG後のフェザーランプ確率")
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
    kingHanaExViewAfterRegLamp()
}

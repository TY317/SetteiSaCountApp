//
//  VVVexViewMarie.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/13.
//

import SwiftUI

struct VVVexViewMarie: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("・革命ボーナス当選時に確定するマリエ覚醒\n　の確率に設定差あり")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・HOLDが一度も発生せずに出てきた覚醒が対象")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(" (通常は最低保証で1回はHOLDが出る。\n  内部的にマリエ覚醒確定時のみ最低保証が出ない)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
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
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "内部マリエ覚醒",
                            percentList: [5,6,7,9,10,13]
                        )
                    }
//                    Image("VVVmarieRatio")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding([.top, .bottom, .trailing])
                        
//                    Image("modeChange")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding(.all)
                        
                    Spacer()
                }
//                .padding(.leading)
                .padding(.horizontal)
            }
            // //// タイトル
            .navigationTitle("マリエ覚醒について")
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
    VVVexViewMarie()
}

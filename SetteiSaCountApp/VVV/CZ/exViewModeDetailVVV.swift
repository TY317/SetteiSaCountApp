//
//  exViewModeDetail.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/12.
//

import SwiftUI

struct exViewModeDetailVVV: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("・CZの当選規定ゲーム数はモードで管理")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・A,B,C,D の4モードがある")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・モードによって天井規定ゲーム数が異なる")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・CZ、決戦ボーナスではモードダウンはない")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
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
//                    Image("modeTenjo")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding(.all)
                    Text("[モード別天井]")
                        .font(.title2)
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "モードA",
                                "モードB",
                                "モードC",
                                "モードD",
                            ]
                        )
                        unitTableString(
                            columTitle: "天井",
                            stringList: [
                                "1000G",
                                "700Gゾーン",
                                "500Gゾーン",
                                "300Gゾーン",
                            ]
                        )
                    }
                    .padding(.bottom)
                    Text("[移行契機での抽選]")
                        .font(.title2)
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "設定変更",
                                "CZ終了時",
                                "決戦ボーナス終了時",
                                "革命ボーナス終了時",
                                "革命ラッシュ終了時",
                            ],
                            maxWidth: 200,
                        )
                        unitTableString(
                            columTitle: "モード移行抽選",
                            stringList: [
                                "再セット",
                                "昇格抽選\n(モードダウンなし)",
                                "再セット\n(モードダウンあり)",
                            ],
                            maxWidth: 200,
                            lineList: [1,2,2],
                        )
                    }
//                    Image("modeChange")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding(.all)
                        
                    Spacer()
                }
//                .padding(.leading)
                .padding(.horizontal)
            }
        }
        // //// タイトル
        .navigationTitle("モード詳細")
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
    exViewModeDetailVVV()
}

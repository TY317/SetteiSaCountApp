//
//  godzillaViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/13.
//

import SwiftUI

struct godzillaViewNormal: View {
    @ObservedObject var godzilla = Godzilla()
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
            // //// 小役停止形
            Section {
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            image1: Image("godzillaKoyakuPattern")
                        )
                    )
                )
            } header: {
                Text("小役停止形")
            }
            
            // //// 探索ゾーン
            Section {
                // 通常ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $godzilla.normalGame,
                    unitText: "Ｇ"
                )
                .focused($isFocused)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button(action: {
                                isFocused = false
                            }, label: {
                                Text("完了")
                                    .fontWeight(.bold)
                            })
                        }
                    }
                }
                // 探索ゾーンカウント
                unitCountButtonVerticalDenominate(
                    title: "探索ゾーン初当り",
                    count: $godzilla.tansakuCount,
                    color: .personalSummerLightBlue,
                    bigNumber: $godzilla.normalGame,
                    numberofDicimal: 0,
                    minusBool: $godzilla.minusCheck
                )
                // 参考情報）探索ゾーン初当り確率
                unitLinkButton(
                    title: "探索ゾーン初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "探索ゾーン初当り確率",
                            tableView: AnyView(godzillaTableTansakuZone())
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(godzillaView95Ci(selection: 5)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("探索ゾーン初当り")
            }
            
            // //// オペレーター示唆
            Section {
                unitLinkButton(
                    title: "オペレーターのセリフによる示唆",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "オペレータのセリフによる示唆",
                            textBody1: "・オペレーターのセリフに設定示唆のパターンがある",
                            tableView: AnyView(godzillaTableOpelatorMessage())
                        )
                    )
                )
            } header: {
                Text("オペレーターのセリフ")
            }
            
            // //// メニュー画面のキャラ
            Section {
                // 説明がき
                VStack {
                    Text("・下記乗り物の画像の場合は設定を示唆")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・デフォルトはゴジラ。他にモード示唆キャラなどもあり")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.caption)
                .foregroundStyle(Color.secondary)
                
                // 画面スクロールビュー
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // ヘリ
                        Image("godzillaMenuScreenGusu")
                            .resizable()
                            .scaledToFit()
                        // 戦車
                        Image("godzillaMenuScreenHighJaku")
                            .resizable()
                            .scaledToFit()
                        // めーさー車
                        Image("godzillaMenuScreenHighKyo")
                            .resizable()
                            .scaledToFit()
                        // 轟天豪
                        Image("godzillaMenuScreen2Over")
                            .resizable()
                            .scaledToFit()
                        // スーパーXⅢ
                        Image("godzillaMenuScreen4Over")
                            .resizable()
                            .scaledToFit()
                        // ３式機龍
                        Image("godzillaMenuScreen6Over")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(height: 140)
            } header: {
                Text("メニュー画面のキャラ")
            }
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $godzilla.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: godzilla.resetNormal)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    godzillaViewNormal()
}

//
//  goevaViewBonusScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/28.
//

import SwiftUI

struct goevaViewBonusScreen: View {
    @ObservedObject var goeva = Goeva()
    @State var tips = tipUnitButtonScreenChoice()
    @State var isShowAlert = false
    
    var body: some View {
//        NavigationView {
            List {
                Section {
                    // //// 画面選択ボタン
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            // シンジ
                            unitButtonScreenChoice(image: Image("goevaBonusScreenShinji"), keyword: goeva.bonusScreenShinjiKeyword, currentKeyword: $goeva.bonusScreenCurrentKeyword, count: $goeva.bonusScreenShinjiCount, minusCheck: $goeva.minusCheck)
                                .popoverTip(tips)
                            // レイ
                            unitButtonScreenChoice(image: Image("goevaBonusScreenRei"), keyword: goeva.bonusScreenReiKeyword, currentKeyword: $goeva.bonusScreenCurrentKeyword, count: $goeva.bonusScreenReiCount, minusCheck: $goeva.minusCheck)
                            // マリ
                            unitButtonScreenChoice(image: Image("goevaBonusScreenMari"), keyword: goeva.bonusScreenMariKeyword, currentKeyword: $goeva.bonusScreenCurrentKeyword, count: $goeva.bonusScreenMariCount, minusCheck: $goeva.minusCheck)
                            // アスカ
                            unitButtonScreenChoice(image: Image("goevaBonusScreenAsuka"), keyword: goeva.bonusScreenAsukaKeyword, currentKeyword: $goeva.bonusScreenCurrentKeyword, count: $goeva.bonusScreenAsukaCount, minusCheck: $goeva.minusCheck)
                            // レイ背景
                            unitButtonScreenChoice(image: Image("goevaBonusScreenReiBack"), keyword: goeva.bonusScreenReiBackKeyword, currentKeyword: $goeva.bonusScreenCurrentKeyword, count: $goeva.bonusScreenReiBackCount, minusCheck: $goeva.minusCheck)
                            // ゴジエヴァ
                            unitButtonScreenChoice(image: Image("goevaBonusScreenGoeva"), keyword: goeva.bonusScreenGoevaKeyword, currentKeyword: $goeva.bonusScreenCurrentKeyword, count: $goeva.bonusScreenGoevaCount, minusCheck: $goeva.minusCheck)
                            
                        }
                    }
                    .frame(height: 120)
                    // //// カウント結果
                    // シンジ
                    unitResultCountListPercent(title: "デフォルト", count: $goeva.bonusScreenShinjiCount, flashColor: .gray, bigNumber: $goeva.bonusScreenCountSum)
                    // レイ
                    unitResultCountListPercent(title: "偶数設定示唆", count: $goeva.bonusScreenReiCount, flashColor: .yellow, bigNumber: $goeva.bonusScreenCountSum)
                    // マリ
                    unitResultCountListPercent(title: "高設定示唆(弱)", count: $goeva.bonusScreenMariCount, flashColor: .pink, bigNumber: $goeva.bonusScreenCountSum)
                    // アスカ
                    unitResultCountListPercent(title: "高設定示唆(強)", count: $goeva.bonusScreenAsukaCount, flashColor: .red, bigNumber: $goeva.bonusScreenCountSum)
                    // レイ背景
                    unitResultCountListPercent(title: "設定2以上濃厚", count: $goeva.bonusScreenReiBackCount, flashColor: .blue, bigNumber: $goeva.bonusScreenCountSum)
                    // ゴジエヴァ
                    unitResultCountListPercent(title: "設定4以上濃厚", count: $goeva.bonusScreenGoevaCount, flashColor: .purple, bigNumber: $goeva.bonusScreenCountSum)
                } header: {
                    Text("終了画面")
                }
                
                // //// 終了時ボイス
                Section {
                    unitLinkButton(title: "終了時のボイスについて", exview: AnyView(unitExView5body2image(title: "ボーナス終了時のボイス", textBody1: "・AT非当選時のボイスが対象", textBody2: "・PUSHボタンを押して確認", image1: Image("goevaBonusVoice"))))
                } header: {
                    Text("ボイス")
                }
            }
            .navigationTitle("ボーナス終了画面")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonToolbarScreenSelectReset(currentKeyword: $goeva.bonusScreenCurrentKeyword)
                            .popoverTip(tipUnitButtonScreenChoiceClear())
                        unitButtonMinusCheck(minusCheck: $goeva.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: goeva.resetBonusScreen, message: "このページのデータをリセットします")
                    }
                }
            }
//        }
//        .navigationTitle("ボーナス終了画面")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonToolbarScreenSelectReset(currentKeyword: $goeva.bonusScreenCurrentKeyword)
//                        .popoverTip(tipUnitButtonScreenChoiceClear())
//                    unitButtonMinusCheck(minusCheck: $goeva.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: goeva.resetBonusScreen, message: "このページのデータをリセットします")
//                }
//            }
//        }
    }
}

#Preview {
    goevaViewBonusScreen()
}

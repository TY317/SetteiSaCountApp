//
//  godeaterViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/12.
//

import SwiftUI
import TipKit

struct godeaterViewVoice: View {
//    @ObservedObject var godeater = Godeater()
    @ObservedObject var godeater: Godeater
    @State var isShowAlert = false
    
    var body: some View {
//        NavigationView {
            List {
                Section {
                    // //// サークルピッカー
                    Picker(selection: $godeater.selectedVoice) {
                        ForEach(godeater.selectListVoice, id: \.self) { voice in
                            Text(voice)
                        }
                    } label: {
                        
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 120)
                    // //// 選択されているボイスのカウント表示
                    // コウタ
                    if godeater.selectedVoice == godeater.selectListVoice[0] {
                        unitResultCountListPercent(title: "デフォルト", count: $godeater.voiceDefaultCount, flashColor: .gray, bigNumber: $godeater.voiceCountSum)
                    }
                    // ヒバリ
                    else if godeater.selectedVoice == godeater.selectListVoice[2] {
                        unitResultCountListPercent(title: "偶数設定示唆(弱)", count: $godeater.voiceHibariCount, flashColor: .blue, bigNumber: $godeater.voiceCountSum)
                    }
                    // サクヤ
                    else if godeater.selectedVoice == godeater.selectListVoice[3] {
                        unitResultCountListPercent(title: "偶数設定示唆(強)", count: $godeater.voiceSakuyaCount, flashColor: .yellow, bigNumber: $godeater.voiceCountSum)
                    }
                    // ソーマ
                    else if godeater.selectedVoice == godeater.selectListVoice[4] {
                        unitResultCountListPercent(title: "高設定示唆(弱)", count: $godeater.voiceSomaCount, flashColor: .green, bigNumber: $godeater.voiceCountSum)
                    }
                    // レン
                    else if godeater.selectedVoice == godeater.selectListVoice[5] {
                        unitResultCountListPercent(title: "高設定示唆(強)", count: $godeater.voiceRenCount, flashColor: .red, bigNumber: $godeater.voiceCountSum)
                    }
                    // ユウ
                    else if godeater.selectedVoice == godeater.selectListVoice[6] {
                        unitResultCountListPercent(title: "設定2,3否定", count: $godeater.voiceYuCount, flashColor: .orange, bigNumber: $godeater.voiceCountSum)
                    }
                    // エリナ
                    else if godeater.selectedVoice == godeater.selectListVoice[7] {
                        unitResultCountListPercent(title: "偶数設定濃厚", count: $godeater.voiceErinaCount, flashColor: .yellow, bigNumber: $godeater.voiceCountSum)
                    }
                    // リンドウ
                    else if godeater.selectedVoice == godeater.selectListVoice[8] {
                        unitResultCountListPercent(title: "設定2以上", count: $godeater.voiceRindoCount, flashColor: .purple, bigNumber: $godeater.voiceCountSum)
                    }
                    // シオ
                    else if godeater.selectedVoice == godeater.selectListVoice[9] {
                        unitResultCountListPercent(title: "設定5以上", count: $godeater.voiceShioCount, flashColor: .red, bigNumber: $godeater.voiceCountSum)
                    }
                    // アリサ
                    else {
                        unitResultCountListPercent(title: "デフォルト", count: $godeater.voiceDefaultCount, flashColor: .gray, bigNumber: $godeater.voiceCountSum)
                    }
                    
                    // //// 登録ボタン
                    Button(action: {
                        // コウタ
                        if godeater.selectedVoice == godeater.selectListVoice[0] {
                            godeater.voiceDefaultCount = countUpDown(minusCheck: godeater.minusCheck, count: godeater.voiceDefaultCount)
                        }
                        // ヒバリ
                        else if godeater.selectedVoice == godeater.selectListVoice[2] {
                            godeater.voiceHibariCount = countUpDown(minusCheck: godeater.minusCheck, count: godeater.voiceHibariCount)
                        }
                        // サクヤ
                        else if godeater.selectedVoice == godeater.selectListVoice[3] {
                            godeater.voiceSakuyaCount = countUpDown(minusCheck: godeater.minusCheck, count: godeater.voiceSakuyaCount)
                        }
                        // ソーマ
                        else if godeater.selectedVoice == godeater.selectListVoice[4] {
                            godeater.voiceSomaCount = countUpDown(minusCheck: godeater.minusCheck, count: godeater.voiceSomaCount)
                        }
                        // レン
                        else if godeater.selectedVoice == godeater.selectListVoice[5] {
                            godeater.voiceRenCount = countUpDown(minusCheck: godeater.minusCheck, count: godeater.voiceRenCount)
                        }
                        // ユウ
                        else if godeater.selectedVoice == godeater.selectListVoice[6] {
                            godeater.voiceYuCount = countUpDown(minusCheck: godeater.minusCheck, count: godeater.voiceYuCount)
                        }
                        // エリナ
                        else if godeater.selectedVoice == godeater.selectListVoice[7] {
                            godeater.voiceErinaCount = countUpDown(minusCheck: godeater.minusCheck, count: godeater.voiceErinaCount)
                        }
                        // リンドウ
                        else if godeater.selectedVoice == godeater.selectListVoice[8] {
                            godeater.voiceRindoCount = countUpDown(minusCheck: godeater.minusCheck, count: godeater.voiceRindoCount)
                        }
                        // シオ
                        else if godeater.selectedVoice == godeater.selectListVoice[9] {
                            godeater.voiceShioCount = countUpDown(minusCheck: godeater.minusCheck, count: godeater.voiceShioCount)
                        }
                        // アリサ
                        else {
                            godeater.voiceDefaultCount = countUpDown(minusCheck: godeater.minusCheck, count: godeater.voiceDefaultCount)
                        }
                    }, label: {
                        HStack {
                            Spacer()
                            if godeater.minusCheck == false {
                                Text("登録")
                                    .fontWeight(.bold)
//                                    .foregroundColor(Color.blue)
                                    .foregroundStyle(Color.blue)
                            } else {
                                Text("マイナス")
                                    .fontWeight(.bold)
//                                    .foregroundColor(Color.red)
                                    .foregroundStyle(Color.red)
                            }
                            Spacer()
                        }
                    })
                } header: {
                    Text("ボイス選択")
                }
                // //// カウント結果表示
                Section {
                    // デフォルト
                    unitResultCountListPercent(title: "デフォルト", count: $godeater.voiceDefaultCount, flashColor: .gray, bigNumber: $godeater.voiceCountSum)
                    // ヒバリ
                    unitResultCountListPercent(title: "偶数設定示唆(弱)", count: $godeater.voiceHibariCount, flashColor: .blue, bigNumber: $godeater.voiceCountSum)
                    // サクヤ
                    unitResultCountListPercent(title: "偶数設定示唆(強)", count: $godeater.voiceSakuyaCount, flashColor: .yellow, bigNumber: $godeater.voiceCountSum)
                    // ソーマ
                    unitResultCountListPercent(title: "高設定示唆(弱)", count: $godeater.voiceSomaCount, flashColor: .green, bigNumber: $godeater.voiceCountSum)
                    // レン
                    unitResultCountListPercent(title: "高設定示唆(強)", count: $godeater.voiceRenCount, flashColor: .red, bigNumber: $godeater.voiceCountSum)
                    // ユウ
                    unitResultCountListPercent(title: "設定2,3否定", count: $godeater.voiceYuCount, flashColor: .orange, bigNumber: $godeater.voiceCountSum)
                    // エリナ
                    unitResultCountListPercent(title: "偶数設定濃厚", count: $godeater.voiceErinaCount, flashColor: .yellow, bigNumber: $godeater.voiceCountSum)
                    // リンドウ
                    unitResultCountListPercent(title: "設定2以上", count: $godeater.voiceRindoCount, flashColor: .purple, bigNumber: $godeater.voiceCountSum)
                    // シオ
                    unitResultCountListPercent(title: "設定5以上", count: $godeater.voiceShioCount, flashColor: .red, bigNumber: $godeater.voiceCountSum)
                    // 参考情報
                    unitLinkButton(
                        title: "ストーリーパート後のボイスについて",
                        exview: AnyView(
                            unitExView5body2image(
                                title: "ストーリーパート後のボイス",
                                textBody1: "・ストーリーパート終了画面でサブ液晶にタッチで確認",
                                textBody2: "・高設定は、3回に1回はデフォルト以外になるくらいの感じらしい(噂)",
//                                image1: Image("godeaterVoice")
                                tableView: AnyView(godeaterTableVoice(godeater: godeater))
                            )
                        )
                    )
                } header: {
                    Text("カウント結果")
                }
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴッドイーター リザレクション",
                screenClass: screenClass
            )
        }
            .navigationTitle("ストーリーパート後のボイス")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: godeater.$minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: godeater.resetVoice)
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("ストーリーパート後のボイス")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: godeater.$minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: godeater.resetVoice)
//                        .popoverTip(tipUnitButtonReset())
//                }
//            }
//        }
    }
}

#Preview {
    godeaterViewVoice(godeater: Godeater())
}

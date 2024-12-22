//
//  lupinViewAtVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/13.
//

import SwiftUI

struct lupinViewAtVoice: View {
    @ObservedObject var lupin = Lupin()
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                // //// セリフの説明
                Text("AT後のメニュー画面下部にセリフが表示されることがあり、そのセリフで設定や規定ゲーム数を示唆")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // //// サークルピッカー
                Picker(selection: $lupin.selectedAtVoice) {
                    ForEach(lupin.selectListAtVoice, id:  \.self) { voice in
                        Text(voice)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                // //// 選択されているボイスのカウント表示
                // デフォルト
                if lupin.selectedAtVoice == lupin.selectListAtVoice[0] {
                    unitResultCountListPercent(
                        title: "デフォルト",
                        count: $lupin.atVoiceCountDefault,
                        flashColor: .gray,
                        bigNumber: $lupin.atVoiceCountSum
                    )
                }
                // 偶数示唆
                else if lupin.selectedAtVoice == lupin.selectListAtVoice[1] {
                    unitResultCountListPercent(
                        title: "偶数示唆",
                        count: $lupin.atVoiceCountGusu,
                        flashColor: .yellow,
                        bigNumber: $lupin.atVoiceCountSum
                    )
                }
                // 設定3,5,6示唆
                else if lupin.selectedAtVoice == lupin.selectListAtVoice[2] {
                    unitResultCountListPercent(
                        title: "設定3,5,6示唆",
                        count: $lupin.atVoiceCount356Sisa,
                        flashColor: .blue,
                        bigNumber: $lupin.atVoiceCountSum
                    )
                }
                // 設定2 以上示唆
                else if lupin.selectedAtVoice == lupin.selectListAtVoice[3] {
                    unitResultCountListPercent(
                        title: "設定2 以上示唆",
                        count: $lupin.atVoiceCountOver2Sisa,
                        flashColor: .green,
                        bigNumber: $lupin.atVoiceCountSum
                    )
                }
                // 設定4 以上示唆
                else if lupin.selectedAtVoice == lupin.selectListAtVoice[4] {
                    unitResultCountListPercent(
                        title: "設定4 以上示唆",
                        count: $lupin.atVoiceCountOver4Sisa,
                        flashColor: .purple,
                        bigNumber: $lupin.atVoiceCountSum
                    )
                }
                // 高設定示唆 強
                else if lupin.selectedAtVoice == lupin.selectListAtVoice[5] {
                    unitResultCountListPercent(
                        title: "高設定示唆 強",
                        count: $lupin.atVoiceCountHighSisa,
                        flashColor: .red,
                        bigNumber: $lupin.atVoiceCountSum
                    )
                }
                // 銀・金 セリフ
                else if lupin.selectedAtVoice == lupin.selectListAtVoice[6] ||
                            lupin.selectedAtVoice == lupin.selectListAtVoice[7] {
                    unitResultCountListPercent(
                        title: "銀・金 セリフ",
                        count: $lupin.atVoiceCountSilverGold,
                        flashColor: .orange,
                        bigNumber: $lupin.atVoiceCountSum
                    )
                }
                // //// 登録ボタン
                Button {
                    // デフォルト
                    if lupin.selectedAtVoice == lupin.selectListAtVoice[0] {
                        lupin.atVoiceCountDefault = countUpDown(minusCheck: lupin.minusCheck, count: lupin.atVoiceCountDefault)
                    }
                    // 偶数示唆
                    else if lupin.selectedAtVoice == lupin.selectListAtVoice[1] {
                        lupin.atVoiceCountGusu = countUpDown(minusCheck: lupin.minusCheck, count: lupin.atVoiceCountGusu)
                    }
                    // 設定3,5,6示唆
                    else if lupin.selectedAtVoice == lupin.selectListAtVoice[2] {
                        lupin.atVoiceCount356Sisa = countUpDown(minusCheck: lupin.minusCheck, count: lupin.atVoiceCount356Sisa)
                    }
                    // 設定2 以上示唆
                    else if lupin.selectedAtVoice == lupin.selectListAtVoice[3] {
                        lupin.atVoiceCountOver2Sisa = countUpDown(minusCheck: lupin.minusCheck, count: lupin.atVoiceCountOver2Sisa)
                    }
                    // 設定4 以上示唆
                    else if lupin.selectedAtVoice == lupin.selectListAtVoice[4] {
                        lupin.atVoiceCountOver4Sisa = countUpDown(minusCheck: lupin.minusCheck, count: lupin.atVoiceCountOver4Sisa)
                    }
                    // 高設定示唆 強
                    else if lupin.selectedAtVoice == lupin.selectListAtVoice[5] {
                        lupin.atVoiceCountHighSisa = countUpDown(minusCheck: lupin.minusCheck, count: lupin.atVoiceCountHighSisa)
                    }
                    // 銀・金 セリフ
                    else if lupin.selectedAtVoice == lupin.selectListAtVoice[6] ||
                                lupin.selectedAtVoice == lupin.selectListAtVoice[7] {
                        lupin.atVoiceCountSilverGold = countUpDown(minusCheck: lupin.minusCheck, count: lupin.atVoiceCountSilverGold)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if lupin.minusCheck == false {
                            Text("登録")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.blue)
                        } else {
                            Text("マイナス")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.red)
                        }
                        Spacer()
                    }
                }
            } header: {
                Text("セリフ選択")
            }
            // //// カウント結果表示
            Section {
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $lupin.atVoiceCountDefault,
                    flashColor: .gray,
                    bigNumber: $lupin.atVoiceCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $lupin.atVoiceCountGusu,
                    flashColor: .yellow,
                    bigNumber: $lupin.atVoiceCountSum
                )
                // 設定3,5,6示唆
                unitResultCountListPercent(
                    title: "設定3,5,6示唆",
                    count: $lupin.atVoiceCount356Sisa,
                    flashColor: .blue,
                    bigNumber: $lupin.atVoiceCountSum
                )
                // 設定2 以上示唆
                unitResultCountListPercent(
                    title: "設定2 以上示唆",
                    count: $lupin.atVoiceCountOver2Sisa,
                    flashColor: .green,
                    bigNumber: $lupin.atVoiceCountSum
                )
                // 設定4 以上示唆
                unitResultCountListPercent(
                    title: "設定4 以上示唆",
                    count: $lupin.atVoiceCountOver4Sisa,
                    flashColor: .purple,
                    bigNumber: $lupin.atVoiceCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $lupin.atVoiceCountHighSisa,
                    flashColor: .red,
                    bigNumber: $lupin.atVoiceCountSum
                )
                // 銀・金 セリフ
                VStack {
                    unitResultCountListPercent(
                        title: "銀・金 セリフ",
                        count: $lupin.atVoiceCountSilverGold,
                        flashColor: .orange,
                        bigNumber: $lupin.atVoiceCountSum
                    )
                    Text("※示唆内容はメニュー画面セリフ一覧を参照")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                // //// 参考情報
                unitLinkButton(
                    title: "メニュー画面セリフ一覧",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "メニュー画面セリフ",
                            image1: Image("lupinMenuMessage")
                        )
                    )
                )
            } header: {
                Text("カウント結果")
            }
        }
        .navigationTitle("AT終了後のセリフ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: lupin.$minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: lupin.resetAtVoice)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    lupinViewAtVoice()
}

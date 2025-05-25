//
//  sevenSwordsViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/14.
//

import SwiftUI

struct sevenSwordsViewEnding: View {
//    @ObservedObject var sevenSwords = SevenSwords()
    @ObservedObject var sevenSwords: SevenSwords
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                // 注意書き
                Text("エンディング中レア役成立時にボタン押すとボイス発生")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // //// サークルピッカー
                Picker(selection: $sevenSwords.selectedVoice) {
                    ForEach(sevenSwords.selectListVoice, id: \.self) { voice in
                        Text(voice)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                // //// 選択されているボイスのカウント表示
                // 奇数示唆
                if sevenSwords.selectedVoice == sevenSwords.selectListVoice[1] {
                    unitResultCountListPercent(
                        title: "奇数示唆",
                        count: $sevenSwords.voiceCountKisu,
                        flashColor: .blue,
                        bigNumber: $sevenSwords.voiceCountSum
                    )
                }
                // 偶数示唆
                else if sevenSwords.selectedVoice == sevenSwords.selectListVoice[2] {
                    unitResultCountListPercent(
                        title: "偶数示唆",
                        count: $sevenSwords.voiceCountGusu,
                        flashColor: .yellow,
                        bigNumber: $sevenSwords.voiceCountSum
                    )
                }
                // 設定2 以上
                else if sevenSwords.selectedVoice == sevenSwords.selectListVoice[3] {
                    unitResultCountListPercent(
                        title: "設定2 以上濃厚",
                        count: $sevenSwords.voiceCountOver2,
                        flashColor: .green,
                        bigNumber: $sevenSwords.voiceCountSum
                    )
                }
                // 設定4 以上
                else if sevenSwords.selectedVoice == sevenSwords.selectListVoice[4] {
                    unitResultCountListPercent(
                        title: "設定4 以上濃厚",
                        count: $sevenSwords.voiceCountOver4,
                        flashColor: .red,
                        bigNumber: $sevenSwords.voiceCountSum
                    )
                }
                // 設定6 以上
                else if sevenSwords.selectedVoice == sevenSwords.selectListVoice[5] {
                    unitResultCountListPercent(
                        title: "設定6 濃厚",
                        count: $sevenSwords.voiceCountOver6,
                        flashColor: .purple,
                        bigNumber: $sevenSwords.voiceCountSum
                    )
                }
                // デフォルト
                else {
                    unitResultCountListPercent(
                        title: "デフォルト",
                        count: $sevenSwords.voiceCountDefault,
                        flashColor: .gray,
                        bigNumber: $sevenSwords.voiceCountSum
                    )
                }
                // //// 登録ボタン
                Button {
                    // 奇数示唆
                    if sevenSwords.selectedVoice == sevenSwords.selectListVoice[1] {
                        sevenSwords.voiceCountKisu = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.voiceCountKisu)
                    }
                    // 偶数示唆
                    else if sevenSwords.selectedVoice == sevenSwords.selectListVoice[2] {
                        sevenSwords.voiceCountGusu = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.voiceCountGusu)
                    }
                    // 設定2 以上
                    else if sevenSwords.selectedVoice == sevenSwords.selectListVoice[3] {
                        sevenSwords.voiceCountOver2 = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.voiceCountOver2)
                    }
                    // 設定4 以上
                    else if sevenSwords.selectedVoice == sevenSwords.selectListVoice[4] {
                        sevenSwords.voiceCountOver4 = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.voiceCountOver4)
                    }
                    // 設定6 以上
                    else if sevenSwords.selectedVoice == sevenSwords.selectListVoice[5] {
                        sevenSwords.voiceCountOver6 = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.voiceCountOver6)
                    }
                    // デフォルト
                    else {
                        sevenSwords.voiceCountDefault = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.voiceCountDefault)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if sevenSwords.minusCheck == false {
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
                Text("ボイス選択")
            }
            
            // //// カウント結果表示
            Section {
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $sevenSwords.voiceCountDefault,
                    flashColor: .gray,
                    bigNumber: $sevenSwords.voiceCountSum
                )
                // 奇数示唆
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $sevenSwords.voiceCountKisu,
                    flashColor: .blue,
                    bigNumber: $sevenSwords.voiceCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $sevenSwords.voiceCountGusu,
                    flashColor: .yellow,
                    bigNumber: $sevenSwords.voiceCountSum
                )
                // 設定2 以上
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $sevenSwords.voiceCountOver2,
                    flashColor: .green,
                    bigNumber: $sevenSwords.voiceCountSum
                )
                // 設定4 以上
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $sevenSwords.voiceCountOver4,
                    flashColor: .red,
                    bigNumber: $sevenSwords.voiceCountSum
                )
                // 設定6 以上
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $sevenSwords.voiceCountOver6,
                    flashColor: .purple,
                    bigNumber: $sevenSwords.voiceCountSum
                )
            } header: {
                Text("カウント結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "七つの魔剣が支配する",
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング中レア役でのボイス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $sevenSwords.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: sevenSwords.resetVoice)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    sevenSwordsViewEnding(sevenSwords: SevenSwords())
}

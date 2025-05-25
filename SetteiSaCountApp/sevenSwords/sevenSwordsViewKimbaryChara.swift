//
//  sevenSwordsViewKimbaryChara.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/14.
//

import SwiftUI

struct sevenSwordsViewKimbaryChara: View {
//    @ObservedObject var sevenSwords = SevenSwords()
    @ObservedObject var sevenSwords: SevenSwords
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                // 注意書き
                Text("青背景キャラは全てデフォルト")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // //// サークルピッカー
                Picker(selection: $sevenSwords.selectedKimbaryCharacter) {
                    ForEach(sevenSwords.selectListKimbaryCharacter, id: \.self) { chara in
                        Text(chara)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                // //// 選択されているキャラのカウント表示
                // 奇数示唆
                if sevenSwords.selectedKimbaryCharacter == sevenSwords.selectListKimbaryCharacter[1] {
                    unitResultCountListPercent(
                        title: "奇数示唆",
                        count: $sevenSwords.kimbaryCharacterCountKisu,
                        flashColor: .red,
                        bigNumber: $sevenSwords.kimbaryCharacterCountSum
                    )
                }
                // 偶数示唆
                else if sevenSwords.selectedKimbaryCharacter == sevenSwords.selectListKimbaryCharacter[2] {
                    unitResultCountListPercent(
                        title: "偶数示唆",
                        count: $sevenSwords.kimbaryCharacterCountGusu,
                        flashColor: .red,
                        bigNumber: $sevenSwords.kimbaryCharacterCountSum
                    )
                }
                // 高設定示唆示唆
                else if sevenSwords.selectedKimbaryCharacter == sevenSwords.selectListKimbaryCharacter[3] {
                    unitResultCountListPercent(
                        title: "高設定示唆",
                        count: $sevenSwords.kimbaryCharacterCountHigh,
                        flashColor: .red,
                        bigNumber: $sevenSwords.kimbaryCharacterCountSum
                    )
                }
                // 奇数かつ高設定示唆
                else if sevenSwords.selectedKimbaryCharacter == sevenSwords.selectListKimbaryCharacter[4] {
                    unitResultCountListPercent(
                        title: "奇数かつ高設定示唆",
                        count: $sevenSwords.kimbaryCharacterCountKisuHigh,
                        flashColor: .purple,
                        bigNumber: $sevenSwords.kimbaryCharacterCountSum
                    )
                }
                // 偶数かつ高設定示唆
                else if sevenSwords.selectedKimbaryCharacter == sevenSwords.selectListKimbaryCharacter[5] {
                    unitResultCountListPercent(
                        title: "偶数かつ高設定示唆",
                        count: $sevenSwords.kimbaryCharacterCountGusuHigh,
                        flashColor: .purple,
                        bigNumber: $sevenSwords.kimbaryCharacterCountSum
                    )
                }
                // 高設定示唆　強
                else if sevenSwords.selectedKimbaryCharacter == sevenSwords.selectListKimbaryCharacter[6] {
                    unitResultCountListPercent(
                        title: "高設定示唆 強",
                        count: $sevenSwords.kimbaryCharacterCountHighKyo,
                        flashColor: .purple,
                        bigNumber: $sevenSwords.kimbaryCharacterCountSum
                    )
                }
                // デフォルト
                else {
                    unitResultCountListPercent(
                        title: "デフォルト",
                        count: $sevenSwords.kimbaryCharacterCountDefault,
                        flashColor: .blue,
                        bigNumber: $sevenSwords.kimbaryCharacterCountSum
                    )
                }
                // 登録ボタン
                Button {
                    // 奇数示唆
                    if sevenSwords.selectedKimbaryCharacter == sevenSwords.selectListKimbaryCharacter[1] {
                        sevenSwords.kimbaryCharacterCountKisu = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.kimbaryCharacterCountKisu)
                    }
                    // 偶数示唆
                    else if sevenSwords.selectedKimbaryCharacter == sevenSwords.selectListKimbaryCharacter[2] {
                        sevenSwords.kimbaryCharacterCountGusu = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.kimbaryCharacterCountGusu)
                    }
                    // 高設定示唆示唆
                    else if sevenSwords.selectedKimbaryCharacter == sevenSwords.selectListKimbaryCharacter[3] {
                        sevenSwords.kimbaryCharacterCountHigh = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.kimbaryCharacterCountHigh)
                    }
                    // 奇数かつ高設定示唆
                    else if sevenSwords.selectedKimbaryCharacter == sevenSwords.selectListKimbaryCharacter[4] {
                        sevenSwords.kimbaryCharacterCountKisuHigh = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.kimbaryCharacterCountKisuHigh)
                    }
                    // 偶数かつ高設定示唆
                    else if sevenSwords.selectedKimbaryCharacter == sevenSwords.selectListKimbaryCharacter[5] {
                        sevenSwords.kimbaryCharacterCountGusuHigh = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.kimbaryCharacterCountGusuHigh)
                    }
                    // 高設定示唆　強
                    else if sevenSwords.selectedKimbaryCharacter == sevenSwords.selectListKimbaryCharacter[6] {
                        sevenSwords.kimbaryCharacterCountHighKyo = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.kimbaryCharacterCountHighKyo)
                    }
                    // デフォルト
                    else {
                        sevenSwords.kimbaryCharacterCountDefault = countUpDown(minusCheck: sevenSwords.minusCheck, count: sevenSwords.kimbaryCharacterCountDefault)
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
                Text("キャラ選択")
            }
            
            // //// カウント結果表示
            Section {
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $sevenSwords.kimbaryCharacterCountDefault,
                    flashColor: .blue,
                    bigNumber: $sevenSwords.kimbaryCharacterCountSum
                )
                // 奇数示唆
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $sevenSwords.kimbaryCharacterCountKisu,
                    flashColor: .red,
                    bigNumber: $sevenSwords.kimbaryCharacterCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $sevenSwords.kimbaryCharacterCountGusu,
                    flashColor: .red,
                    bigNumber: $sevenSwords.kimbaryCharacterCountSum
                )
                // 高設定示唆示唆
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $sevenSwords.kimbaryCharacterCountHigh,
                    flashColor: .red,
                    bigNumber: $sevenSwords.kimbaryCharacterCountSum
                )
                // 奇数かつ高設定示唆
                unitResultCountListPercent(
                    title: "奇数かつ高設定示唆",
                    count: $sevenSwords.kimbaryCharacterCountKisuHigh,
                    flashColor: .purple,
                    bigNumber: $sevenSwords.kimbaryCharacterCountSum
                )
                // 偶数かつ高設定示唆
                unitResultCountListPercent(
                    title: "偶数かつ高設定示唆",
                    count: $sevenSwords.kimbaryCharacterCountGusuHigh,
                    flashColor: .purple,
                    bigNumber: $sevenSwords.kimbaryCharacterCountSum
                )
                // 高設定示唆　強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $sevenSwords.kimbaryCharacterCountHighKyo,
                    flashColor: .purple,
                    bigNumber: $sevenSwords.kimbaryCharacterCountSum
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
        .navigationTitle("キンバリーBONUS中のキャラ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $sevenSwords.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: sevenSwords.resetKimbaryCharacter)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    sevenSwordsViewKimbaryChara(sevenSwords: SevenSwords())
}

//
//  girlsSSSubViewCountInput.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct girlsSSSubViewCountInput: View {
    @ObservedObject var girlsSS: GirlsSS
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 実ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "ぶどう",
                        inputValue: $girlsSS.personalBellCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
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
                    // チェリー
                    unitTextFieldNumberInputWithUnit(
                        title: "🍒",
                        inputValue: $girlsSS.personalCherryCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // BIG
                    unitTextFieldNumberInputWithUnit(
                        title: "BIG",
                        inputValue: $girlsSS.personalBigCountSum,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // REG
                    unitTextFieldNumberInputWithUnit(
                        title: "単独REG",
                        inputValue: $girlsSS.personalAloneRegCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // REG
                    unitTextFieldNumberInputWithUnit(
                        title: "🍒REG",
                        inputValue: $girlsSS.personalCherryRegCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                }
            }
            .navigationTitle("カウント値 直接入力")
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
}

#Preview {
    girlsSSSubViewCountInput(
        girlsSS: GirlsSS()
    )
}

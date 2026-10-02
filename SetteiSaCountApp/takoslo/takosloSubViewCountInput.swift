//
//  takosloSubViewCountInput.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct takosloSubViewCountInput: View {
    @ObservedObject var takoslo: Takoslo
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section {
                    // プラム
                    unitTextFieldNumberInputWithUnit(
                        title: "プラム",
                        inputValue: $takoslo.koyakuCountPlum,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // 🍉
                    unitTextFieldNumberInputWithUnit(
                        title: "🍉",
                        inputValue: $takoslo.koyakuCountSuika,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // 🍒
                    unitTextFieldNumberInputWithUnit(
                        title: "🍒",
                        inputValue: $takoslo.koyakuCountCherry,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                } header: {
                    Text("小役")
                }

                Section {
                    // 🍉A
                    unitTextFieldNumberInputWithUnit(
                        title: "🍉A",
                        inputValue: $takoslo.koyakuDetailCountSuikaA,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // 🍉B
                    unitTextFieldNumberInputWithUnit(
                        title: "🍉B",
                        inputValue: $takoslo.koyakuDetailCountSuikaB,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // 🍒B
                    unitTextFieldNumberInputWithUnit(
                        title: "🍒B",
                        inputValue: $takoslo.koyakuDetailCountCherryB,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // 🍒C
                    unitTextFieldNumberInputWithUnit(
                        title: "🍒C",
                        inputValue: $takoslo.koyakuDetailCountCherryC,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                } header: {
                    Text("小役詳細")
                }
            }
            .navigationTitle("カウント値 直接入力")
            .toolbar {
                // //// ツールバー閉じるボタン
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("閉じる")
                            .fontWeight(.bold)
                    })
                }
                // //// キーボードの完了ボタン
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
        }
    }
}

#Preview {
    takosloSubViewCountInput(
        takoslo: Takoslo()
    )
}

//
//  happyJugV3SubViewCountInput.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct happyJugV3SubViewCountInput: View {
    @ObservedObject var happyJugV3: HappyJugV3
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 実ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "ぶどう",
                        inputValue: $happyJugV3.personalBellCount,
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
                    // BIG
                    unitTextFieldNumberInputWithUnit(
                        title: "単独BIG",
                        inputValue: $happyJugV3.personalAloneBigCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // BIG
                    unitTextFieldNumberInputWithUnit(
                        title: "🍒BIG",
                        inputValue: $happyJugV3.personalCherryBigCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // REG
                    unitTextFieldNumberInputWithUnit(
                        title: "単独REG",
                        inputValue: $happyJugV3.personalAloneRegCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // REG
                    unitTextFieldNumberInputWithUnit(
                        title: "🍒REG",
                        inputValue: $happyJugV3.personalCherryRegCount,
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
    happyJugV3SubViewCountInput(
        happyJugV3: HappyJugV3()
    )
}

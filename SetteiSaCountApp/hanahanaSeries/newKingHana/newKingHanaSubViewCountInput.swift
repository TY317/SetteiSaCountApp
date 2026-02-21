//
//  newKingHanaSubViewCountInput.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/21.
//

import SwiftUI

struct newKingHanaSubViewCountInput: View {
    @ObservedObject var newKingHana: NewKingHana
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 実ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "ベル",
                        inputValue: $newKingHana.bellCount,
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
                    .onChange(of: newKingHana.bellCount) { oldValue, newValue in
                        newKingHana.totalBellSumFunc()
                    }
                    
                    // BIG
                    unitTextFieldNumberInputWithUnit(
                        title: "BIG",
                        inputValue: $newKingHana.bigCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    .onChange(of: newKingHana.bigCount) { oldValue, newValue in
                        newKingHana.totalBonusSumFunc()
                        newKingHana.bonusSumFunc()
                    }
                    
                    // REG
                    unitTextFieldNumberInputWithUnit(
                        title: "REG",
                        inputValue: $newKingHana.regCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    .onChange(of: newKingHana.regCount) { oldValue, newValue in
                        newKingHana.totalBonusSumFunc()
                        newKingHana.bonusSumFunc()
                    }
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
    newKingHanaSubViewCountInput(
        newKingHana: NewKingHana(),
    )
}

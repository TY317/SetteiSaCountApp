//
//  kingHanaSubViewCountInput.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct kingHanaSubViewCountInput: View {
    @ObservedObject var kingHana: KingHana
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 実ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "ベル",
                        inputValue: $kingHana.bellCount,
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
                        title: "BIG",
                        inputValue: $kingHana.bigCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // REG
                    unitTextFieldNumberInputWithUnit(
                        title: "REG",
                        inputValue: $kingHana.regCount,
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
    kingHanaSubViewCountInput(
        kingHana: KingHana()
    )
}

//
//  hanaTenshoSubViewCountInput.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct hanaTenshoSubViewCountInput: View {
    @ObservedObject var hanaTensho: HanaTensho
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 実ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "ベル",
                        inputValue: $hanaTensho.bellCount,
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
                        inputValue: $hanaTensho.bigCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // REG
                    unitTextFieldNumberInputWithUnit(
                        title: "REG",
                        inputValue: $hanaTensho.regCount,
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
    hanaTenshoSubViewCountInput(
        hanaTensho: HanaTensho()
    )
}

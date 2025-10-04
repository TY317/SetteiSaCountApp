//
//  urmiraSubViewCountInput.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/01.
//

import SwiftUI

struct urmiraSubViewCountInput: View {
    @ObservedObject var urmira: Urmira
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 実ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "ぶどう",
                        inputValue: $urmira.personalBellCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // チェリー
                    unitTextFieldNumberInputWithUnit(
                        title: "🍒",
                        inputValue: $urmira.personalCherryCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // BIG
                    unitTextFieldNumberInputWithUnit(
                        title: "単独BIG",
                        inputValue: $urmira.personalAloneBigCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // BIG
                    unitTextFieldNumberInputWithUnit(
                        title: "🍒BIG",
                        inputValue: $urmira.personalCherryBigCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // REG
                    unitTextFieldNumberInputWithUnit(
                        title: "単独REG",
                        inputValue: $urmira.personalAloneRegCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
                    // REG
                    unitTextFieldNumberInputWithUnit(
                        title: "🍒REG",
                        inputValue: $urmira.personalCherryRegCount,
                        unitText: "回"
                    )
                    .focused(self.$isFocused)
//                    // BIG
//                    unitTextFieldNumberInputWithUnit(
//                        title: "BIG",
//                        inputValue: $urmira.personalBigCountSum,
//                        unitText: "回"
//                    )
//                    .focused(self.$isFocused)
//                    // REG
//                    unitTextFieldNumberInputWithUnit(
//                        title: "REG",
//                        inputValue: $urmira.personalRegCountSum,
//                        unitText: "回"
//                    )
//                    .focused(self.$isFocused)
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
    urmiraSubViewCountInput(
        urmira: Urmira(),
    )
}

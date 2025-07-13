//
//  unitSheetCountDirectInput.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/12.
//

import SwiftUI

struct unitSheetCountDirectInput<inputView: View>: View {
    @ViewBuilder var inputView: () -> inputView
//    @FocusState private var isFocused: Bool
    var focus: FocusState<Bool>.Binding
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    self.inputView()
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
                            focus.wrappedValue = false
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

//#Preview {
//    unitSheetCountDirectInput(){
//        Text("test")
//    }
//}

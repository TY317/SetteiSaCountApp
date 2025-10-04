//
//  unitToolbarButtonCountDirectInput.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/12.
//

import SwiftUI

struct unitToolbarButtonCountDirectInput<inputView: View>: View {
    @ViewBuilder var inputView: () -> inputView
    var focus: FocusState<Bool>.Binding
    @State private var isShowInputView: Bool = false
//    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            self.isShowInputView.toggle()
        } label: {
            Image(systemName: "keyboard")
        }
        .sheet(isPresented: self.$isShowInputView) {
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
//                            dismiss()
                            self.isShowInputView = false
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
}

#Preview {
    @FocusState var dummyFocus: Bool
    unitToolbarButtonCountDirectInput(inputView: {
        Text("test")
    }, focus: $dummyFocus)
}

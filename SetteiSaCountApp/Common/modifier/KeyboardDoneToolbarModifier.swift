//
//  KeyboardDoneToolbarModifier.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/30.
//

import Foundation
import SwiftUI

/// キーボード上に「完了」ボタンを置き、タップでフォーカスを外すモディファイア
struct KeyboardDoneToolbarModifier: ViewModifier {
    /// フォーカス状態を親から受け取る
//    @Binding var isFocused: Bool
    var focus: FocusState<Bool>.Binding
    
    func body(content: Content) -> some View {
        content
//            .focused(self.$isFocused)                        // フォーカスを紐付け
            .focused(self.focus)                        // フォーカスを紐付け
            .toolbar {                                 // キーボード上のツールバー
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("完了") {                    // ボタンを押したらキーボードを閉じる
//                        isFocused = false
                        focus.wrappedValue = false    // フォーカスを外す
                    }
                    .fontWeight(.bold)
                }
            }
    }
}

// 呼び出しを簡単にする拡張
extension View {
    /// - Parameter focus: `@FocusState` で定義した Bool の Binding (`$isFocused` など)
    func keyboardDoneToolbar(focus: FocusState<Bool>.Binding) -> some View {
        modifier(KeyboardDoneToolbarModifier(focus: focus))
    }
}

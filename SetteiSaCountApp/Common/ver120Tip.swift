//
//  ver120Tip.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/07.
//

import SwiftUI
import TipKit

// ver1.2.0リリース　24/10/12

// //////////////////
// Tip：5枚役の機能追加
// //////////////////
struct mt5TipAdd5Coins: Tip {
    var title: Text {
        Text("5枚役カウント")
    }
    var message: Text? {
        Text("5枚役のカウント機能を追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

struct ver120Tip: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    ver120Tip()
}

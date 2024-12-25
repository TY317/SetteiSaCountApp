//
//  ver180Tip.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/25.
//

import SwiftUI
import TipKit

struct ver180Tip: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer180AddMachine: Tip {
    var title: Text {
        Text("機種追加しました！")
    }
    var message: Text? {
        Text("ダンバイン\nダンベル何キロ持てる？ を追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

#Preview {
    ver180Tip()
}

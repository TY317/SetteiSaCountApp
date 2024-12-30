//
//  ver170Tip.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/08.
//

import SwiftUI
import TipKit

struct ver170Tip: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer170AddMachine: Tip {
    var title: Text {
        Text("機種追加しました！")
    }
    var message: Text? {
        Text("ルパン3世\n犬夜叉2 を追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


#Preview {
    ver170Tip()
}

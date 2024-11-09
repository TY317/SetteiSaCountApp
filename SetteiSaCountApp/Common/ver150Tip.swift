//
//  ver150Tip.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/06.
//

import SwiftUI
import TipKit

struct ver150Tip: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer150AddMachine: Tip {
    var title: Text {
        Text("機種追加しました！")
    }
    var message: Text? {
        Text("バンドリ!を追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


#Preview {
    ver150Tip()
}

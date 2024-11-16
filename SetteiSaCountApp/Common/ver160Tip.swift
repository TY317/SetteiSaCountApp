//
//  ver160Tip.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/16.
//

import SwiftUI
import TipKit

struct ver160Tip: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


// //////////////////
// Tip：リゼロ　死に戻り確率の情報追加
// //////////////////
struct tipVer160rezero2ComebackRatio: Tip {
    var title: Text {
        Text("引き戻し確率の情報追記")
    }
    var message: Text? {
        Text("設定ごとの確率が判明したので情報追記しました！")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer160AddMachine: Tip {
    var title: Text {
        Text("機種追加しました！")
    }
    var message: Text? {
        Text("モンスターハンター ライズを追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


#Preview {
    ver160Tip()
}

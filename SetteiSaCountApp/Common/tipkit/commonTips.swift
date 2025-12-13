//
//  commonTips.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/16.
//

import SwiftUI
import TipKit

struct commonTips: View {
    var body: some View {
        Text("Hello, World!")
    }
}


// //////////////////
// Tip：キーボード非表示のTips
// //////////////////
struct commonTipKeybordHidden: Tip {
    var title: Text {
        Text("キーボード非表示")
    }
    var message: Text? {
        Text("このボタンをタップ")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// //////////////////
// Tip：自動ゲーム数カウント
// //////////////////
struct commonTipAutoGameCount: Tip {
    var title: Text {
        Text("ゲーム数自動カウント")
    }
    var message: Text? {
        Text("ONにすると現在ゲーム数を4.1秒ごとに自動で＋１します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


#Preview {
    commonTips()
}

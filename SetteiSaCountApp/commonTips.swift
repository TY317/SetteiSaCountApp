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


#Preview {
    commonTips()
}

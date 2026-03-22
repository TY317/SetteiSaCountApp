//
//  ver3221.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/22.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3221UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


// //////////////////
// Tip：DMC 上位ST後のモード移行
// //////////////////
struct tipVer3221Dmc5PremiumStMode: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("上位ST後のモード振分け 特大設定差が判明")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

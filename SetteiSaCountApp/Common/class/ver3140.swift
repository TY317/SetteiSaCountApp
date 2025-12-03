//
//  ver3140.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/03.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3140UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・化物語\n・\n・")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

// //////////////////
// Tip：ネオプラ 朝一
// //////////////////
struct tipVer3140neoplaNormal: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("朝一の高確移行の設定差が判明")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

//
//  ver3230.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/28.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3230UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・真打 吉宗")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


// //////////////////
// Tip：カバネリウナと　キャラ紹介
// //////////////////
struct tipVer3230KabaneriUnatoChara: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("キャラ紹介振分けが判明\n設定判別機能を更新")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

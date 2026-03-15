//
//  ver3220.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/09.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3220UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・サンダーV")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


// //////////////////
// Tip：カバネリ２　小吉
// //////////////////
struct tipVer3220KabaneriUnatoShokichi: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("小吉に関する法則が判明！")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：炎炎２　モード
// //////////////////
struct tipVer3220enen2Mode: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("モードの振分け、ミニキャラでの示唆が判明！")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：新鬼武者３　裏モード
// //////////////////
struct tipVer3220newOni3UraMode: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("AT裏モードの存在と移行率が判明！")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

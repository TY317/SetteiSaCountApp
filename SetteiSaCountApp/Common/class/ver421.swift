//
//  ver421.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/27.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer421UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer421Karakuri2Voice: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("AT終了画面でのボイス示唆の情報を追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer421Karakuri2Mode: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("強🍒設定差、モード関連の情報を更新")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer421ShinYoshiBatto: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("抜刀メーターMAXからのチャンス当選率の設定差が判明\nカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

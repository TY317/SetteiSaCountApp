//
//  ver411.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/06.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer411UpdateInfo: Tip {
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
struct tipVer411Karakuri2Mode: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("モードの情報を追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer411Karakuri2CzScreen: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("CZ終了画面の種類を追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer411IzabanchoKoyaku: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("共通🔔、弱🍒の設定差が全て判明")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

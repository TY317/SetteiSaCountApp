//
//  ver491.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/10/18.
//

import Foundation
import SwiftUI
import TipKit

//////////////////
// Tip：更新情報（機種追加／機能追加の告知）
//////////////////
struct tipVer491UpdateInfo: Tip {
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
struct tipVer491: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：獣王 レア役成立時のSC高確移行率
//////////////////
struct tipVer491JuoScHigh: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("チェリー・レアリプレイ成立時のSC高確移行率のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

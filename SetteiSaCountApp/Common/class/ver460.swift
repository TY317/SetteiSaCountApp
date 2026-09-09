//
//  ver460.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/30.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer460UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・リコリス・リコイル")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer460: Tip {
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
// Tip：攻殻機動隊 上位裏AT突入率
//////////////////
struct tipVer460KokakukidotaiHighAt: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("上位裏AT突入率のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：真打吉宗 AT終了画面
//////////////////
struct tipVer460ShinYoshiScreen: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("AT終了画面のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

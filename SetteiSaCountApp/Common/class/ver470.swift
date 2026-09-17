//
//  ver470.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/09/13.
//

import Foundation
import SwiftUI
import TipKit

//////////////////
// Tip：更新情報（機種追加／機能追加の告知）
//////////////////
struct tipVer470UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・青春ブタ野郎")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer470: Tip {
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
// Tip：喰霊 RB中のキャラ紹介
//////////////////
struct tipVer470GareiChara: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("RB中のキャラ紹介のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：喰霊 通常時の小役
//////////////////
struct tipVer470GareiKoyaku: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("・共通🔔のカウント機能を追加\n・強🍒と弱チャンス目の確率が判明したので設定期待値に反映しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：喰霊 CZの背景色
//////////////////
struct tipVer470GareiCzBackColor: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("CZの背景色ごとの期待度を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：禁書目録2 CZの種類別カウント
//////////////////
struct tipVer470Index2Cz: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("CZを超電磁砲CZと一方通行CZに分けてカウントできるようにしました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

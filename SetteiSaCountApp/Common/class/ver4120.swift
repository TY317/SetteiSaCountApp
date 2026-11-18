//
//  ver4120.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/11/15.
//

import Foundation
import SwiftUI
import TipKit

//////////////////
// Tip：更新情報（機種追加／機能追加の告知）
//////////////////
struct tipVer4120UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・ラグナドール")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer4120: Tip {
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
// Tip：ゴジエヴァ2 エンディング エピソード映像
//////////////////
struct tipVer4120Goeva2Episode: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("エピソード映像の情報を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：聖闘士星矢 通常時 守護星座の加護
//////////////////
struct tipVer4120SeiyaShugoSeiza: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("守護星座の加護の設定変更時の振分けを追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：GGO 通常時 グレネードジャッジ報酬
//////////////////
struct tipVer4120GgoGrenade: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("グレネードジャッジ報酬のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

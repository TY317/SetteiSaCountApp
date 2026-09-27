//
//  ver480.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/09/22.
//

import Foundation
import SwiftUI
import TipKit

//////////////////
// Tip：更新情報（機種追加／機能追加の告知）
//////////////////
struct tipVer480UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・タコスロ\n・彼女、お借りします")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer480: Tip {
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
// Tip：禁書目録2 終了画面の振り分け
//////////////////
struct tipVer480Index2Screen: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("終了画面の振り分けを追加し、設定期待値の計算に反映しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：戦国コレクション6 天魔一閃 上乗せ枚数
//////////////////
struct tipVer480Sencole6TenmaIssen: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("天魔一閃の上乗せ枚数のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：リコリス・リコイル 150G 変換高確移行
//////////////////
struct tipVer480RicoricoHenkan150G: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("150Gでの変換高確移行率のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：リコリス・リコイル AT中エピソードの示唆
//////////////////
struct tipVer480RicoricoEpisode: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("EP3・EP4の示唆内容を更新しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

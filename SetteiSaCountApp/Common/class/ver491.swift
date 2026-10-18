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


//////////////////
// Tip：彼女、お借りします 終了画面の振分け
//////////////////
struct tipVer491KanokariScreen: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("終了画面の振分けを追加し、設定期待値に反映しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：彼女、お借りします RB中 キャラ紹介シナリオの振分け
//////////////////
struct tipVer491KanokariRbChara: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("キャラ紹介シナリオの振分けを追加し、設定期待値に反映しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：彼女、お借りします 1Gレンチャンス 攻略キャラ順の振分け
//////////////////
struct tipVer491KanokariRenChance: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("攻略キャラ順の振分けを追加し、設定期待値に反映しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：彼女、お借りします エンディング 強チャンス目時のボイス振分け
//////////////////
struct tipVer491KanokariEnding: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("強チャンス目時のボイス振分けを追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：彼女、お借りします 引き戻し期待度・ななかりDREAM当選率
//////////////////
struct tipVer491KanokariComeback: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("引き戻し期待度・ななかりDREAM当選率のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

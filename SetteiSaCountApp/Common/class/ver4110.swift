//
//  ver4110.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/11/09.
//

import Foundation
import SwiftUI
import TipKit

//////////////////
// Tip：更新情報（機種追加／機能追加の告知）
//////////////////
struct tipVer4110UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・ガンゲイル・オンライン\n・Vivy")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer4110: Tip {
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
// Tip：SAO2 AT終了時のセット継続率
//////////////////
struct tipVer4110Sao2AtSetContinue: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("AT終了時のセット継続率のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：モンハンSB 終了画面の振分け
//////////////////
struct tipVer4110MhrsbScreenRatio: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("終了画面の高設定示唆の振分けを追加し、設定期待値に反映しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：ゴジエヴァ2 月蝕変異の発生率
//////////////////
struct tipVer4110Goeva2Gesshoku: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("月蝕変異の発生率のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

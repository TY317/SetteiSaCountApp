//
//  ver430.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/02.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer430UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("とある魔術の禁書目録2\nワールダイスター")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer430Mt5Medal: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("青・黄メダルの比率設定差が判明\n算出機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer430TokyoGhoulUraAt: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("規定ゲーム数での当選時 裏AT突入率の情報を追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer430SbjBbTenjo: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("BBスルー天井の振分けを追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer430Tekken6ChanceColor: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("鉄拳チャンス赤の割合に設定差あり\nカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer430Otome5Voice: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("エンディング中のボイスに設定示唆あり\nカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

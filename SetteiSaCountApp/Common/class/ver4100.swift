//
//  ver4100.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/11/01.
//

import Foundation
import SwiftUI
import TipKit

//////////////////
// Tip：更新情報（機種追加／機能追加の告知）
//////////////////
struct tipVer4100UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・ゴジラ対エヴァンゲリオン2\n・聖闘士星矢 黄金十二宮")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer4100: Tip {
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
// Tip：モンハンSB 通常時 レア役からのBZ当選率
//////////////////
struct tipVer4100MhrsbRareBz: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("レア役からのBZ当選率、リプレイメーター周期当選、規定周期当選時のCZ種別振分けのカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

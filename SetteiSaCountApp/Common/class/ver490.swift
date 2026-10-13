//
//  ver490.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/10/04.
//

import Foundation
import SwiftUI
import TipKit

//////////////////
// Tip：更新情報（機種追加／機能追加の告知）
//////////////////
struct tipVer490UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・モンハンライズ サンブレイク\n・獣王")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer490: Tip {
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
// Tip：SAO2 GGOモード キリトモード移行率
//////////////////
struct tipVer490Sao2GgoKirito: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("GGOモードのキリトモード移行率のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：ストリートファイター6 モード・初期ランク
//////////////////
struct tipVer490Sf6Mode: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("モード・初期ランクの情報を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：リコリス・リコイル 短縮天井・弱リコリス目の変換高確移行率
//////////////////
struct tipVer490RicoricoTanshuku: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("短縮天井・弱リコリス目の変換高確移行率のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

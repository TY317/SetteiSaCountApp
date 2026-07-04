//
//  ver410.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/27.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer410UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer410BioRe3Cz: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("CZ確率の詳細が判明\n設定期待値計算に追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

//////////////////
// Tip：
//////////////////
struct tipVer410: Tip {
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

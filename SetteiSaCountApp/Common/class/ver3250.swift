//
//  ver3250.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/02.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3250UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・バイオRE3\n・スーパーリオエース2")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


 //////////////////
 // Tip：カバネリ　おみくじ
 //////////////////
struct tipVer3250KabaneriUnatoOmikuji: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("おみくじの示唆内容 一部が判明")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

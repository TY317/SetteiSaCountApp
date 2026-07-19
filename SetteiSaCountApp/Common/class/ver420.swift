//
//  ver420.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/19.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer420UpdateInfo: Tip {
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
struct tipVer420: Tip {
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

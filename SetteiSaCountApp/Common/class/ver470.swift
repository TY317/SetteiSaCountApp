//
//  ver470.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/09/13.
//

import Foundation
import SwiftUI
import TipKit

//////////////////
// Tip：更新情報（機種追加／機能追加の告知）
//////////////////
struct tipVer470UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・青春ブタ野郎")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer470: Tip {
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

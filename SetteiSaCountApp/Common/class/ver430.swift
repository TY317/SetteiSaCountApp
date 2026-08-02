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
struct tipVer430: Tip {
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

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
        Text("・スーパーリオエース2")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


// //////////////////
// Tip：アクダマ　終了画面
// //////////////////
//struct tipVer3240AkudamaScreen: Tip {
//    var title: Text {
//        Text("情報更新")
//    }
//    var message: Text? {
//        Text("終了画面示唆の内容が判明")
//    }
//    var image: Image? {
//        Image(systemName: "exclamationmark.bubble")
//    }
//}

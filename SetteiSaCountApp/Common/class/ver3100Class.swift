//
//  ver3100Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/22.
//

import Foundation
import SwiftUI
import TipKit

// //////////////////
// Tip：エヴァ
// //////////////////
struct tipVer3100EvaYakusokuNormal: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("重複当選をカウントする機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


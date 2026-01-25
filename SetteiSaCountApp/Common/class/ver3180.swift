//
//  ver3180.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/25.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3180UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・炎炎ノ消防隊2\n・攻殻機動隊")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

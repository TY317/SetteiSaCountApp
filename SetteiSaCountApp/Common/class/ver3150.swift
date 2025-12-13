//
//  ver3150.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import Foundation
import TipKit

struct tipVer3150UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・秘宝伝")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

//
//  ver3130.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/08.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3130UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・とある科学の超電磁砲2\n・")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

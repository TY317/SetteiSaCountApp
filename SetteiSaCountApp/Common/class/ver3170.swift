//
//  ver3170.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3170UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・シェイクBT")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

//
//  ver3220.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/09.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3220UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・サンダーBT")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

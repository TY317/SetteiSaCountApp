//
//  ver3160.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/26.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3160UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・北斗 転生の章\n・鉄拳6\n・無職転生")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

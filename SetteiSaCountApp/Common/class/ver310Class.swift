//
//  ver310Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/05.
//

import Foundation
import SwiftUI
import TipKit

class Ver310: ObservableObject {
    
}

// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer310MachineAdd: Tip {
    var title: Text {
        Text("機種追加！")
    }
    var message: Text? {
        Text("・ガンダムSEED")
    }
    var image: Image? {
//        Image(systemName: "exclamationmark.bubble")
        Image(systemName: "star")
    }
}

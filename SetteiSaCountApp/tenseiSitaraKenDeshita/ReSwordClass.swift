//
//  ReSwordClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/31.
//

import Foundation
import SwiftUI

class ReSword: ObservableObject {
    // /////////////
    // 初当り
    // /////////////
    let ratioCz: [Double] = [215.8, 214.2, 211.0, 204.8, 201.2, 197.8]
    let ratioAt: [Double] = [403.8, 396.0, 373.4, 340.7, 325.9, 312.8]
    
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "転生したら剣でした"
    @AppStorage("reSwordMinusCheck") var minusCheck: Bool = false
    @AppStorage("reSwordSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}

//
//  newKingHanaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/16.
//

import Foundation
import SwiftUI

class NewKingHana: ObservableObject {
    // -------
    // 確率値
    // -------
    
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ニューキングハナハナ"
    @AppStorage("newKingHanaMinusCheck") var minusCheck: Bool = false
    @AppStorage("newKingHanaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
    
    // ////////
    // 島合算
    // ////////
    @AppStorage("newKingHanaShimaGames") var shimaGames: Int = 0
    @AppStorage("newKingHanaShimaBigs") var shimaBigs: Int = 0
    @AppStorage("newKingHanaShimaRegs") var shimaRegs: Int = 0
    @AppStorage("newKingHanaShimaBonusSum") var shimaBonusSum: Int = 0
}

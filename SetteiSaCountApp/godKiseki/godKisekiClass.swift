//
//  godKisekiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/13.
//

import Foundation
import SwiftUI
import Combine

class GodKiseki: ObservableObject {
    // -------
    // 通常時
    // -------
    // 3連
    @AppStorage("godKisekiRen3CountBlue") var ren3CountBlue: Int = 0
    @AppStorage("godKisekiRen3CountBlueHit") var ren3CountBlueHit: Int = 0
    @AppStorage("godKisekiRen3CountYellow") var ren3CountYellow: Int = 0
    @AppStorage("godKisekiRen3CountYellowHit") var ren3CountYellowHit: Int = 0
    
    func resetNormal() {
        ren3CountBlue = 0
        ren3CountBlueHit = 0
        ren3CountYellow = 0
        ren3CountYellowHit = 0
        minusCheck = false
        
        ren4CountBlue = 0
        ren4CountBlueHit = 0
        
        bellGame = 0
        bellCountOshijun = 0
        bellCountGedan = 0
    }
    // ---------
    // 初当り
    // ---------
    let ratioFirstHitAt: [Double] = [533,420,496,338,455,295]
    @AppStorage("godKisekiNormalGame") var normalGame: Int = 0
    @AppStorage("godKisekiFirstHitCountAt") var firstHitCountAt: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        minusCheck = false
        
        riseZzoneCount = 0
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ミリオンゴッド〜神々の軌跡〜"
    @AppStorage("godKisekiMinusCheck") var minusCheck: Bool = false
    @AppStorage("godKisekiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
    
    // ---------
    // ver3.24.1
    // ---------
    let ratioReplay3Hit: [Double] = [1.2,10.2,-1,-1,-1,-1]
    let ratioReplay4Hit: [Double] = [33.2,50,-1,-1,-1,-1]
    @AppStorage("godKisekiRen4CountBlue") var ren4CountBlue: Int = 0
    @AppStorage("godKisekiRen4CountBlueHit") var ren4CountBlueHit: Int = 0
    
    // --------
    // ver3.27.0
    // --------
    let ratioRiseZzone: [Double] = [1.2,1.0,4.2,1.0,11.6,1]
    @AppStorage("godKisekiRiseZzoneCount") var riseZzoneCount: Int = 0
    
    // ---------
    // ver4.1.2
    // ---------
    @AppStorage("godKisekiBellGame") var bellGame: Int = 0
    @AppStorage("godKisekiBellCountOshijun") var bellCountOshijun: Int = 0
    @AppStorage("godKisekiBellCountGedan") var bellCountGedan: Int = 0
}


class GodKisekiMemory1: ObservableObject {
    @AppStorage("godKisekiRen3CountBlueMemory1") var ren3CountBlue: Int = 0
    @AppStorage("godKisekiRen3CountBlueHitMemory1") var ren3CountBlueHit: Int = 0
    @AppStorage("godKisekiRen3CountYellowMemory1") var ren3CountYellow: Int = 0
    @AppStorage("godKisekiRen3CountYellowHitMemory1") var ren3CountYellowHit: Int = 0
    @AppStorage("godKisekiNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("godKisekiFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("godKisekiMemoMemory1") var memo = ""
    @AppStorage("godKisekiDateMemory1") var dateDouble = 0.0
    
    // ---------
    // ver3.24.1
    // ---------
    @AppStorage("godKisekiRen4CountBlueMemory1") var ren4CountBlue: Int = 0
    @AppStorage("godKisekiRen4CountBlueHitMemory1") var ren4CountBlueHit: Int = 0
    
    // --------
    // ver3.27.0
    // --------
    @AppStorage("godKisekiRiseZzoneCountMemory1") var riseZzoneCount: Int = 0
}


class GodKisekiMemory2: ObservableObject {
    @AppStorage("godKisekiRen3CountBlueMemory2") var ren3CountBlue: Int = 0
    @AppStorage("godKisekiRen3CountBlueHitMemory2") var ren3CountBlueHit: Int = 0
    @AppStorage("godKisekiRen3CountYellowMemory2") var ren3CountYellow: Int = 0
    @AppStorage("godKisekiRen3CountYellowHitMemory2") var ren3CountYellowHit: Int = 0
    @AppStorage("godKisekiNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("godKisekiFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("godKisekiMemoMemory2") var memo = ""
    @AppStorage("godKisekiDateMemory2") var dateDouble = 0.0
    
    // ---------
    // ver3.24.1
    // ---------
    @AppStorage("godKisekiRen4CountBlueMemory2") var ren4CountBlue: Int = 0
    @AppStorage("godKisekiRen4CountBlueHitMemory2") var ren4CountBlueHit: Int = 0
    
    // --------
    // ver3.27.0
    // --------
    @AppStorage("godKisekiRiseZzoneCountMemory2") var riseZzoneCount: Int = 0
}


class GodKisekiMemory3: ObservableObject {
    @AppStorage("godKisekiRen3CountBlueMemory3") var ren3CountBlue: Int = 0
    @AppStorage("godKisekiRen3CountBlueHitMemory3") var ren3CountBlueHit: Int = 0
    @AppStorage("godKisekiRen3CountYellowMemory3") var ren3CountYellow: Int = 0
    @AppStorage("godKisekiRen3CountYellowHitMemory3") var ren3CountYellowHit: Int = 0
    @AppStorage("godKisekiNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("godKisekiFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("godKisekiMemoMemory3") var memo = ""
    @AppStorage("godKisekiDateMemory3") var dateDouble = 0.0
    
    // ---------
    // ver3.24.1
    // ---------
    @AppStorage("godKisekiRen4CountBlueMemory3") var ren4CountBlue: Int = 0
    @AppStorage("godKisekiRen4CountBlueHitMemory3") var ren4CountBlueHit: Int = 0
    
    // --------
    // ver3.27.0
    // --------
    @AppStorage("godKisekiRiseZzoneCountMemory3") var riseZzoneCount: Int = 0
}

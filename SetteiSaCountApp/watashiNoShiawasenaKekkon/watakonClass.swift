//
//  watakonClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/25.
//

import Foundation
import SwiftUI

class Watakon: ObservableObject {
    // //////////////////
    // 初当り
    // //////////////////
    let ratioBonus: [Double] = [290.8,286.5,277.3,255.3,251.4,249.4]
    let ratioAt: [Double] = [594.3,583.4,558.8,494.7,484.3,479.4]
    
    
    // /////////////////
    // AT終了画面
    // /////////////////
    @AppStorage("watakonScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("watakonScreenCountGusu") var screenCountGusu: Int = 0
    @AppStorage("watakonScreenCountHigh") var screenCountHigh: Int = 0
    @AppStorage("watakonScreenCountOver2") var screenCountOver2: Int = 0
    @AppStorage("watakonScreenCountOver4") var screenCountOver4: Int = 0
    @AppStorage("watakonScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("watakonScreenCountSum") var screenCountSum: Int = 0
    
    func screenCountSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountGusu,
            screenCountHigh,
            screenCountOver2,
            screenCountOver4,
            screenCountOver6,
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountGusu = 0
        screenCountHigh = 0
        screenCountOver2 = 0
        screenCountOver4 = 0
        screenCountOver6 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "わたしの幸せな結婚"
    @AppStorage("watakonMinusCheck") var minusCheck: Bool = false
    @AppStorage("watakonSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetScreen()
    }
}


// //// メモリー1
class WatakonMemory1: ObservableObject {
    @AppStorage("watakonScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("watakonScreenCountGusuMemory1") var screenCountGusu: Int = 0
    @AppStorage("watakonScreenCountHighMemory1") var screenCountHigh: Int = 0
    @AppStorage("watakonScreenCountOver2Memory1") var screenCountOver2: Int = 0
    @AppStorage("watakonScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("watakonScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("watakonScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("watakonMemoMemory1") var memo = ""
    @AppStorage("watakonDateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class WatakonMemory2: ObservableObject {
    @AppStorage("watakonScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("watakonScreenCountGusuMemory2") var screenCountGusu: Int = 0
    @AppStorage("watakonScreenCountHighMemory2") var screenCountHigh: Int = 0
    @AppStorage("watakonScreenCountOver2Memory2") var screenCountOver2: Int = 0
    @AppStorage("watakonScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("watakonScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("watakonScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("watakonMemoMemory2") var memo = ""
    @AppStorage("watakonDateMemory2") var dateDouble = 0.0
}


// //// メモリー3
class WatakonMemory3: ObservableObject {
    @AppStorage("watakonScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("watakonScreenCountGusuMemory3") var screenCountGusu: Int = 0
    @AppStorage("watakonScreenCountHighMemory3") var screenCountHigh: Int = 0
    @AppStorage("watakonScreenCountOver2Memory3") var screenCountOver2: Int = 0
    @AppStorage("watakonScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("watakonScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("watakonScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("watakonMemoMemory3") var memo = ""
    @AppStorage("watakonDateMemory3") var dateDouble = 0.0
}

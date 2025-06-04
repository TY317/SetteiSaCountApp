//
//  izaBanchoClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import Foundation
import SwiftUI

class IzaBancho: ObservableObject {
    // /////////////////
    // 通常時
    // /////////////////
    let ratioCommonBellA: [Double] = [-1,-1,-1,-1,-1,-1]
    
    
    
    // /////////////////
    // 初当り
    // /////////////////
    let ratioFirstHit: [Double] = [386.9,368.5,375.8,332.4,351.6,312.1]
    let ratioBBChokugeki: [Double] = [-1,-1,-1,-1,-1,-1]
    
    
    // /////////////////
    // AT終了画面
    // /////////////////
    @AppStorage("izaBanchoScreenCountDefault") var screenCountDefault: Int = 0 {
        didSet {
            screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
        }
    }
        @AppStorage("izaBanchoScreenCountScreen2") var screenCountScreen2: Int = 0 {
            didSet {
                screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
            }
        }
            @AppStorage("izaBanchoScreenCountScreen3") var screenCountScreen3: Int = 0 {
                didSet {
                    screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
                }
            }
                @AppStorage("izaBanchoScreenCountScreen4") var screenCountScreen4: Int = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
                    }
                }
                    @AppStorage("izaBanchoScreenCountScreen5") var screenCountScreen5: Int = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
                        }
                    }
                        @AppStorage("izaBanchoScreenCountScreen6") var screenCountScreen6: Int = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
                            }
                        }
                            @AppStorage("izaBanchoScreenCountScreen7") var screenCountScreen7: Int = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
                                }
                            }
                                @AppStorage("izaBanchoScreenCountScreen8") var screenCountScreen8: Int = 0 {
                                    didSet {
                                        screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
                                    }
                                }
    @AppStorage("izaBanchoScreenCountSum") var screenCountSum: Int = 0
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountScreen2 = 0
        screenCountScreen3 = 0
        screenCountScreen4 = 0
        screenCountScreen5 = 0
        screenCountScreen6 = 0
        screenCountScreen7 = 0
        screenCountScreen8 = 0
        minusCheck = false
    }
    
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "いざ！番長"
    @AppStorage("izaBanchoMinusCheck") var minusCheck: Bool = false
    @AppStorage("izaBanchoSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetScreen()
    }
}

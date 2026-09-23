//
//  takosloClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Takoslo: ObservableObject {
    // -------
    // 通常時
    // -------
    // 設定1,2,5,6 の4段階設定
    let ratioKoyakuPlum: [Double] = [9.8,9.7,9.4,9.0]
    let ratioKoyakuSuika: [Double] = [60.0,56.2,53.0,50.0]
    let ratioKoyakuCherry: [Double] = [22.9,21.9,21.0,20.1]
    @AppStorage("takosloKoyakuCountPlum") var koyakuCountPlum: Int = 0
    @AppStorage("takosloKoyakuCountSuika") var koyakuCountSuika: Int = 0
    @AppStorage("takosloKoyakuCountCherry") var koyakuCountCherry: Int = 0
    let ratioKoyakuDetailSuikaA: [Double] = [66.6,62.4,58.8,55.5]
    let ratioKoyakuDetailSuikaB: [Double] = [601.2,565.0,541.6,504.1]
    let ratioKoyakuDetailCherryB: [Double] = [136.5,126.0,117.0,109.2]
    let ratioKoyakuDetailCherryC: [Double] = [32.3,30.9,29.7,28.5]
    @AppStorage("takosloKoyakuDetailCountSuikaA") var koyakuDetailCountSuikaA: Int = 0
    @AppStorage("takosloKoyakuDetailCountSuikaB") var koyakuDetailCountSuikaB: Int = 0
    @AppStorage("takosloKoyakuDetailCountCherryB") var koyakuDetailCountCherryB: Int = 0
    @AppStorage("takosloKoyakuDetailCountCherryC") var koyakuDetailCountCherryC: Int = 0
    @AppStorage("takosloGameNumberStart") var gameNumberStart: Int = 0
    @AppStorage("takosloGameNumberCurrent") var gameNumberCurrent: Int = 0
    @AppStorage("takosloGameNumberPlay") var gameNumberPlay: Int = 0

    func resetNormal() {
        koyakuCountPlum = 0
        koyakuCountSuika = 0
        koyakuCountCherry = 0
        koyakuDetailCountSuikaA = 0
        koyakuDetailCountSuikaB = 0
        koyakuDetailCountCherryB = 0
        koyakuDetailCountCherryC = 0
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
        minusCheck = false
    }

    // --------
    // 初当り
    // --------

    func resetFirstHit() {
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "タコスロ"
    @AppStorage("takosloMinusCheck") var minusCheck: Bool = false
    @AppStorage("takosloSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class TakosloMemory1: ObservableObject {
    @AppStorage("takosloMemoMemory1") var memo = ""
    @AppStorage("takosloDateMemory1") var dateDouble = 0.0
}


class TakosloMemory2: ObservableObject {
    @AppStorage("takosloMemoMemory2") var memo = ""
    @AppStorage("takosloDateMemory2") var dateDouble = 0.0
}


class TakosloMemory3: ObservableObject {
    @AppStorage("takosloMemoMemory3") var memo = ""
    @AppStorage("takosloDateMemory3") var dateDouble = 0.0
}

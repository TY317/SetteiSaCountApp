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
    let ratioFirstHitBig: [Double] = [324.4,318.1,309.1,297.9]
    let ratioFirstHitReg: [Double] = [352.3,336.1,312.1,300.6]
    @AppStorage("takosloNormalGame") var normalGame: Int = 0
    @AppStorage("takosloFirstHitCountBig") var firstHitCountBig: Int = 0
    @AppStorage("takosloFirstHitCountReg") var firstHitCountReg: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountBig = 0
        firstHitCountReg = 0
        minusCheck = false
    }

    // -------
    // BT中
    // -------
    let ratioReplayTacoGame: [Double] = [728.2,728.2,366.1,242.7]

    // -------
    // 画面選択
    // -------
    @AppStorage("takosloScreenCount1") var screenCount1: Int = 0
    @AppStorage("takosloScreenCount2") var screenCount2: Int = 0
    @AppStorage("takosloScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
        )
    }

    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCountSum = 0
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
        resetScreen()
    }
}


class TakosloMemory1: ObservableObject {
    @AppStorage("takosloKoyakuCountPlumMemory1") var koyakuCountPlum: Int = 0
    @AppStorage("takosloKoyakuCountSuikaMemory1") var koyakuCountSuika: Int = 0
    @AppStorage("takosloKoyakuCountCherryMemory1") var koyakuCountCherry: Int = 0
    @AppStorage("takosloKoyakuDetailCountSuikaAMemory1") var koyakuDetailCountSuikaA: Int = 0
    @AppStorage("takosloKoyakuDetailCountSuikaBMemory1") var koyakuDetailCountSuikaB: Int = 0
    @AppStorage("takosloKoyakuDetailCountCherryBMemory1") var koyakuDetailCountCherryB: Int = 0
    @AppStorage("takosloKoyakuDetailCountCherryCMemory1") var koyakuDetailCountCherryC: Int = 0
    @AppStorage("takosloGameNumberStartMemory1") var gameNumberStart: Int = 0
    @AppStorage("takosloGameNumberCurrentMemory1") var gameNumberCurrent: Int = 0
    @AppStorage("takosloGameNumberPlayMemory1") var gameNumberPlay: Int = 0
    @AppStorage("takosloNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("takosloFirstHitCountBigMemory1") var firstHitCountBig: Int = 0
    @AppStorage("takosloFirstHitCountRegMemory1") var firstHitCountReg: Int = 0
    @AppStorage("takosloScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("takosloScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("takosloScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("takosloMemoMemory1") var memo = ""
    @AppStorage("takosloDateMemory1") var dateDouble = 0.0
}


class TakosloMemory2: ObservableObject {
    @AppStorage("takosloKoyakuCountPlumMemory2") var koyakuCountPlum: Int = 0
    @AppStorage("takosloKoyakuCountSuikaMemory2") var koyakuCountSuika: Int = 0
    @AppStorage("takosloKoyakuCountCherryMemory2") var koyakuCountCherry: Int = 0
    @AppStorage("takosloKoyakuDetailCountSuikaAMemory2") var koyakuDetailCountSuikaA: Int = 0
    @AppStorage("takosloKoyakuDetailCountSuikaBMemory2") var koyakuDetailCountSuikaB: Int = 0
    @AppStorage("takosloKoyakuDetailCountCherryBMemory2") var koyakuDetailCountCherryB: Int = 0
    @AppStorage("takosloKoyakuDetailCountCherryCMemory2") var koyakuDetailCountCherryC: Int = 0
    @AppStorage("takosloGameNumberStartMemory2") var gameNumberStart: Int = 0
    @AppStorage("takosloGameNumberCurrentMemory2") var gameNumberCurrent: Int = 0
    @AppStorage("takosloGameNumberPlayMemory2") var gameNumberPlay: Int = 0
    @AppStorage("takosloNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("takosloFirstHitCountBigMemory2") var firstHitCountBig: Int = 0
    @AppStorage("takosloFirstHitCountRegMemory2") var firstHitCountReg: Int = 0
    @AppStorage("takosloScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("takosloScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("takosloScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("takosloMemoMemory2") var memo = ""
    @AppStorage("takosloDateMemory2") var dateDouble = 0.0
}


class TakosloMemory3: ObservableObject {
    @AppStorage("takosloKoyakuCountPlumMemory3") var koyakuCountPlum: Int = 0
    @AppStorage("takosloKoyakuCountSuikaMemory3") var koyakuCountSuika: Int = 0
    @AppStorage("takosloKoyakuCountCherryMemory3") var koyakuCountCherry: Int = 0
    @AppStorage("takosloKoyakuDetailCountSuikaAMemory3") var koyakuDetailCountSuikaA: Int = 0
    @AppStorage("takosloKoyakuDetailCountSuikaBMemory3") var koyakuDetailCountSuikaB: Int = 0
    @AppStorage("takosloKoyakuDetailCountCherryBMemory3") var koyakuDetailCountCherryB: Int = 0
    @AppStorage("takosloKoyakuDetailCountCherryCMemory3") var koyakuDetailCountCherryC: Int = 0
    @AppStorage("takosloGameNumberStartMemory3") var gameNumberStart: Int = 0
    @AppStorage("takosloGameNumberCurrentMemory3") var gameNumberCurrent: Int = 0
    @AppStorage("takosloGameNumberPlayMemory3") var gameNumberPlay: Int = 0
    @AppStorage("takosloNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("takosloFirstHitCountBigMemory3") var firstHitCountBig: Int = 0
    @AppStorage("takosloFirstHitCountRegMemory3") var firstHitCountReg: Int = 0
    @AppStorage("takosloScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("takosloScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("takosloScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("takosloMemoMemory3") var memo = ""
    @AppStorage("takosloDateMemory3") var dateDouble = 0.0
}

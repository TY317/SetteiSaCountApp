//
//  ragnadorClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Ragnador: ObservableObject {
    // -------
    // 通常時
    // -------

    // 弱チェリーの状態昇格率
    let ratioWeakCherryUpNone: [Double] = [40.6,37.5,34.4,25.0,19.5,17.2]
    let ratioWeakCherryUpHigh: [Double] = [50.0,51.6,53.1,58.6,62.5,64.1]
    let ratioWeakCherryUpSuperHigh: [Double] = [9.4,10.9,12.5,16.4,18.0,18.8]
    // 高確以上（高確＋超高確）
    let ratioWeakCherryUpHighOver: [Double] = [59.4,62.5,65.6,75.0,80.5,82.8]
    @AppStorage("ragnadorWeakCherryCount") var weakCherryCount: Int = 0
    @AppStorage("ragnadorWeakCherryUpCountHigh") var weakCherryUpCountHigh: Int = 0
    @AppStorage("ragnadorWeakCherryUpCountSuperHigh") var weakCherryUpCountSuperHigh: Int = 0
    @AppStorage("ragnadorWeakCherryUpCountHighOver") var weakCherryUpCountHighOver: Int = 0

    func weakCherryUpSumFunc() {
        weakCherryUpCountHighOver = weakCherryUpCountHigh + weakCherryUpCountSuperHigh
    }

    // レア役からのCZ・AT当選率（設定差のあるものだけカウント）
    // 通常状態
    let ratioRareCzNormalChance: [Double] = [19.9,21.1,22.3,23.4,23.4,23.4]
    let ratioRareCzNormalKyo: [Double] = [32.8,35.2,37.5,43.0,43.0,43.0]
    let ratioRareAtNormalSuika: [Double] = [0.4,0.4,0.4,0.8,1.2,1.2]
    let ratioRareAtNormalChance: [Double] = [0.4,0.4,0.4,0.8,1.2,1.2]
    let ratioRareAtNormalKyo: [Double] = [0.4,0.4,0.8,1.6,2.0,2.3]
    let ratioRareAtNormalGoku: [Double] = [0.4,0.4,0.4,0.8,1.2,1.2]
    // 高確
    let ratioRareCzHighChance: [Double] = [39.8,41.4,43.0,54.7,54.7,54.7]
    let ratioRareCzHighKyo: [Double] = [65.6,66.4,68.8,73.4,75.0,76.6]
    let ratioRareAtHighSuika: [Double] = [0.4,0.4,0.4,0.8,1.2,1.2]
    let ratioRareAtHighChance: [Double] = [0.4,0.4,0.4,0.8,1.2,1.2]
    let ratioRareAtHighKyo: [Double] = [0.4,0.4,0.8,1.6,2.0,2.3]
    @AppStorage("ragnadorRareCountNormalSuika") var rareCountNormalSuika: Int = 0
    @AppStorage("ragnadorRareAtCountNormalSuika") var rareAtCountNormalSuika: Int = 0
    @AppStorage("ragnadorRareCountNormalChance") var rareCountNormalChance: Int = 0
    @AppStorage("ragnadorRareCzCountNormalChance") var rareCzCountNormalChance: Int = 0
    @AppStorage("ragnadorRareAtCountNormalChance") var rareAtCountNormalChance: Int = 0
    @AppStorage("ragnadorRareCountNormalKyo") var rareCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareCzCountNormalKyo") var rareCzCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareAtCountNormalKyo") var rareAtCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareCountNormalGoku") var rareCountNormalGoku: Int = 0
    @AppStorage("ragnadorRareAtCountNormalGoku") var rareAtCountNormalGoku: Int = 0
    @AppStorage("ragnadorRareCountHighSuika") var rareCountHighSuika: Int = 0
    @AppStorage("ragnadorRareAtCountHighSuika") var rareAtCountHighSuika: Int = 0
    @AppStorage("ragnadorRareCountHighChance") var rareCountHighChance: Int = 0
    @AppStorage("ragnadorRareCzCountHighChance") var rareCzCountHighChance: Int = 0
    @AppStorage("ragnadorRareAtCountHighChance") var rareAtCountHighChance: Int = 0
    @AppStorage("ragnadorRareCountHighKyo") var rareCountHighKyo: Int = 0
    @AppStorage("ragnadorRareCzCountHighKyo") var rareCzCountHighKyo: Int = 0
    @AppStorage("ragnadorRareAtCountHighKyo") var rareAtCountHighKyo: Int = 0

    func resetNormal() {
        weakCherryCount = 0
        weakCherryUpCountHigh = 0
        weakCherryUpCountSuperHigh = 0
        weakCherryUpCountHighOver = 0
        rareCountNormalSuika = 0
        rareAtCountNormalSuika = 0
        rareCountNormalChance = 0
        rareCzCountNormalChance = 0
        rareAtCountNormalChance = 0
        rareCountNormalKyo = 0
        rareCzCountNormalKyo = 0
        rareAtCountNormalKyo = 0
        rareCountNormalGoku = 0
        rareAtCountNormalGoku = 0
        rareCountHighSuika = 0
        rareAtCountHighSuika = 0
        rareCountHighChance = 0
        rareCzCountHighChance = 0
        rareAtCountHighChance = 0
        rareCountHighKyo = 0
        rareCzCountHighKyo = 0
        rareAtCountHighKyo = 0
        minusCheck = false
    }

    // --------
    // 初当り
    // --------

    func resetFirstHit() {
        minusCheck = false
    }

    // -------
    // ボイス選択
    // -------
    let ratioVoiceOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioVoiceOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioVoiceOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioVoiceOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("ragnadorVoiceCount1") var voiceCount1: Int = 0
    @AppStorage("ragnadorVoiceCount2") var voiceCount2: Int = 0
    @AppStorage("ragnadorVoiceCount3") var voiceCount3: Int = 0
    @AppStorage("ragnadorVoiceCount4") var voiceCount4: Int = 0
    @AppStorage("ragnadorVoiceCount5") var voiceCount5: Int = 0
    @AppStorage("ragnadorVoiceCount6") var voiceCount6: Int = 0
    @AppStorage("ragnadorVoiceCount7") var voiceCount7: Int = 0
    @AppStorage("ragnadorVoiceCount8") var voiceCount8: Int = 0
    @AppStorage("ragnadorVoiceCountSum") var voiceCountSum: Int = 0

    func voiceSumFunc() {
        voiceCountSum = countSum(
            voiceCount1,
            voiceCount2,
            voiceCount3,
            voiceCount4,
            voiceCount5,
            voiceCount6,
            voiceCount7,
            voiceCount8,
        )
    }

    func resetVoice() {
        voiceCount1 = 0
        voiceCount2 = 0
        voiceCount3 = 0
        voiceCount4 = 0
        voiceCount5 = 0
        voiceCount6 = 0
        voiceCount7 = 0
        voiceCount8 = 0
        voiceCountSum = 0
        minusCheck = false
    }

    // -------
    // CZ,AT終了時のボイス
    // -------
    // ボイスは9種類あるが、カウントは示唆の分類ごと（1:デフォルト 2:テーブル示唆 3:高設定示唆）にまとめる
    @AppStorage("ragnadorEndVoiceCount1") var endVoiceCount1: Int = 0
    @AppStorage("ragnadorEndVoiceCount2") var endVoiceCount2: Int = 0
    @AppStorage("ragnadorEndVoiceCount3") var endVoiceCount3: Int = 0
    @AppStorage("ragnadorEndVoiceCountSum") var endVoiceCountSum: Int = 0

    func endVoiceSumFunc() {
        endVoiceCountSum = countSum(
            endVoiceCount1,
            endVoiceCount2,
            endVoiceCount3,
        )
    }

    func resetEndVoice() {
        endVoiceCount1 = 0
        endVoiceCount2 = 0
        endVoiceCount3 = 0
        endVoiceCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "ラグナドール"
    @AppStorage("ragnadorMinusCheck") var minusCheck: Bool = false
    @AppStorage("ragnadorSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetVoice()
        resetEndVoice()
    }
}


class RagnadorMemory1: ObservableObject {
    @AppStorage("ragnadorMemoMemory1") var memo = ""
    @AppStorage("ragnadorDateMemory1") var dateDouble = 0.0
}


class RagnadorMemory2: ObservableObject {
    @AppStorage("ragnadorMemoMemory2") var memo = ""
    @AppStorage("ragnadorDateMemory2") var dateDouble = 0.0
}


class RagnadorMemory3: ObservableObject {
    @AppStorage("ragnadorMemoMemory3") var memo = ""
    @AppStorage("ragnadorDateMemory3") var dateDouble = 0.0
}

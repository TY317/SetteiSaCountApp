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
    // 通常時
    // /////////////
    // ゾーン当選
    let ratioZone300: [Double] = [25,-1,-1,-1,-1,-1]
    let ratioZone600: [Double] = [21,-1,-1,-1,-1,-1]
    @AppStorage("reSwordZoneCount350Miss") var zoneCount350Miss: Int = 0
    @AppStorage("reSwordZoneCount350Hit") var zoneCount350Hit: Int = 0
    @AppStorage("reSwordZoneCount350Sum") var zoneCount350Sum: Int = 0
    @AppStorage("reSwordZoneCount650Miss") var zoneCount650Miss: Int = 0
    @AppStorage("reSwordZoneCount650Hit") var zoneCount650Hit: Int = 0
    @AppStorage("reSwordZoneCount650Sum") var zoneCount650Sum: Int = 0
    
    func zoneCountSumFunc() {
        zoneCount350Sum = zoneCount350Miss + zoneCount350Hit
        zoneCount650Sum = zoneCount650Miss + zoneCount650Hit
    }
    
    // ボーナス当選率
    let ratioBonusJakuChance: [Double] = [3,-1,-1,-1,-1,-1]
    let ratioBonusSuika: [Double] = [10,-1,-1,-1,-1,-1]
    let ratioBonusKyoSuika: [Double] = [25,-1,-1,-1,-1,-1]
    let ratioBonusKokakuJakuChance: [Double] = [20,-1,-1,-1,-1,-1]
    let ratioBonusKokakuSuika: [Double] = [30,-1,-1,-1,-1,-1]
    let ratioBonusKokakuKyoSuika: [Double] = [50,-1,-1,-1,-1,-1]
    let ratioBonusChokokakuJakuChance: [Double] = [50,-1,-1,-1,-1,-1]
    let ratioBonusChokokakuSuika: [Double] = [63,-1,-1,-1,-1,-1]
    let ratioBonusChokokakuKyoSuika: [Double] = [100,-1,-1,-1,-1,-1]
    @AppStorage("reSwordRareBonusCountJakuChanceMiss") var rareBonusCountJakuChanceMiss: Int = 0
    @AppStorage("reSwordRareBonusCountJakuChanceHit") var rareBonusCountJakuChanceHit: Int = 0
    @AppStorage("reSwordRareBonusCountJakuChanceSum") var rareBonusCountJakuChanceSum: Int = 0
    @AppStorage("reSwordRareBonusCountSuikaMiss") var rareBonusCountSuikaMiss: Int = 0
    @AppStorage("reSwordRareBonusCountSuikaHit") var rareBonusCountSuikaHit: Int = 0
    @AppStorage("reSwordRareBonusCountSuikaSum") var rareBonusCountSuikaSum: Int = 0
    @AppStorage("reSwordRareBonusCountKyoChanceMiss") var rareBonusCountKyoChanceMiss: Int = 0
    @AppStorage("reSwordRareBonusCountKyoChanceHit") var rareBonusCountKyoChanceHit: Int = 0
    @AppStorage("reSwordRareBonusCountKyoChanceSum") var rareBonusCountKyoChanceSum: Int = 0
    
    func rareBonusSumFunc() {
        rareBonusCountJakuChanceSum = rareBonusCountJakuChanceMiss + rareBonusCountJakuChanceHit
        rareBonusCountSuikaSum = rareBonusCountSuikaMiss + rareBonusCountSuikaHit
        rareBonusCountKyoChanceSum = rareBonusCountKyoChanceMiss + rareBonusCountKyoChanceHit
    }
    
    // CZ当選率
    let ratioCzJakuCherry: [Double] = [3,-1,-1,-1,-1,-1]
    let ratioCzKyoCherry: [Double] = [48,-1,-1,-1,-1,-1]
    let ratioCzKokakuJakuCherry: [Double] = [25,-1,-1,-1,-1,-1]
    let ratioCzKokakuKyoCherry: [Double] = [83,-1,-1,-1,-1,-1]
    let ratioCzChokokakuJakuCherry: [Double] = [63,-1,-1,-1,-1,-1]
    let ratioCzChokokakuKyoCherry: [Double] = [100,-1,-1,-1,-1,-1]
    @AppStorage("reSwordRareCzCountCherryJakuMiss") var rareCzCountCherryJakuMiss: Int = 0
    @AppStorage("reSwordRareCzCountCherryJakuHit") var rareCzCountCherryJakuHit: Int = 0
    @AppStorage("reSwordRareCzCountCherryJakuSum") var rareCzCountCherryJakuSum: Int = 0
    @AppStorage("reSwordRareCzCountCherryKyoMiss") var rareCzCountCherryKyoMiss: Int = 0
    @AppStorage("reSwordRareCzCountCherryKyoHit") var rareCzCountCherryKyoHit: Int = 0
    @AppStorage("reSwordRareCzCountCherryKyoSum") var rareCzCountCherryKyoSum: Int = 0
    
    func rareCzSumFunc() {
        rareCzCountCherryJakuSum = rareCzCountCherryJakuMiss + rareCzCountCherryJakuHit
        rareCzCountCherryKyoSum = rareCzCountCherryKyoMiss + rareCzCountCherryKyoHit
    }
    
    func resetNormal() {
        zoneCount350Miss = 0
        zoneCount350Hit = 0
        zoneCount350Sum = 0
        zoneCount650Miss = 0
        zoneCount650Hit = 0
        zoneCount650Sum = 0
        rareBonusCountJakuChanceMiss = 0
        rareBonusCountJakuChanceHit = 0
        rareBonusCountJakuChanceSum = 0
        rareBonusCountSuikaMiss = 0
        rareBonusCountSuikaHit = 0
        rareBonusCountSuikaSum = 0
        rareBonusCountKyoChanceMiss = 0
        rareBonusCountKyoChanceHit = 0
        rareBonusCountKyoChanceSum = 0
        rareCzCountCherryJakuMiss = 0
        rareCzCountCherryJakuHit = 0
        rareCzCountCherryJakuSum = 0
        rareCzCountCherryKyoMiss = 0
        rareCzCountCherryKyoHit = 0
        rareCzCountCherryKyoSum = 0
        minusCheck = false
    }
    
    // /////////////
    // 初当り
    // /////////////
    let ratioCz: [Double] = [215.8, 214.2, 211.0, 204.8, 201.2, 197.8]
    let ratioAt: [Double] = [403.8, 396.0, 373.4, 340.7, 325.9, 312.8]
    
    // ////////////
    // CZ
    // ////////////
    
    
    // ////////////
    // AT終了画面
    // ////////////
    @AppStorage("reSwordAtScreenCount1") var atScreenCount1: Int = 0
    @AppStorage("reSwordAtScreenCount2") var atScreenCount2: Int = 0
    @AppStorage("reSwordAtScreenCount3") var atScreenCount3: Int = 0
    @AppStorage("reSwordAtScreenCount4") var atScreenCount4: Int = 0
    @AppStorage("reSwordAtScreenCount5") var atScreenCount5: Int = 0
    @AppStorage("reSwordAtScreenCount6") var atScreenCount6: Int = 0
    @AppStorage("reSwordAtScreenCountSum") var atScreenCountSum: Int = 0
    
    func screenCountSumFunc() {
        atScreenCountSum = countSum(
            atScreenCount1,
            atScreenCount2,
            atScreenCount3,
            atScreenCount4,
            atScreenCount5,
            atScreenCount6,
        )
    }
    
    func resetAtScreen() {
        atScreenCount1 = 0
        atScreenCount2 = 0
        atScreenCount3 = 0
        atScreenCount4 = 0
        atScreenCount5 = 0
        atScreenCount6 = 0
        atScreenCountSum = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "転生したら剣でした"
    @AppStorage("reSwordMinusCheck") var minusCheck: Bool = false
    @AppStorage("reSwordSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetAtScreen()
    }
}


// //// メモリー1
class ReSwordMemory1: ObservableObject {
    @AppStorage("reSwordZoneCount350MissMemory1") var zoneCount350Miss: Int = 0
    @AppStorage("reSwordZoneCount350HitMemory1") var zoneCount350Hit: Int = 0
    @AppStorage("reSwordZoneCount350SumMemory1") var zoneCount350Sum: Int = 0
    @AppStorage("reSwordZoneCount650MissMemory1") var zoneCount650Miss: Int = 0
    @AppStorage("reSwordZoneCount650HitMemory1") var zoneCount650Hit: Int = 0
    @AppStorage("reSwordZoneCount650SumMemory1") var zoneCount650Sum: Int = 0
    @AppStorage("reSwordRareBonusCountJakuChanceMissMemory1") var rareBonusCountJakuChanceMiss: Int = 0
    @AppStorage("reSwordRareBonusCountJakuChanceHitMemory1") var rareBonusCountJakuChanceHit: Int = 0
    @AppStorage("reSwordRareBonusCountJakuChanceSumMemory1") var rareBonusCountJakuChanceSum: Int = 0
    @AppStorage("reSwordRareBonusCountSuikaMissMemory1") var rareBonusCountSuikaMiss: Int = 0
    @AppStorage("reSwordRareBonusCountSuikaHitMemory1") var rareBonusCountSuikaHit: Int = 0
    @AppStorage("reSwordRareBonusCountSuikaSumMemory1") var rareBonusCountSuikaSum: Int = 0
    @AppStorage("reSwordRareBonusCountKyoChanceMissMemory1") var rareBonusCountKyoChanceMiss: Int = 0
    @AppStorage("reSwordRareBonusCountKyoChanceHitMemory1") var rareBonusCountKyoChanceHit: Int = 0
    @AppStorage("reSwordRareBonusCountKyoChanceSumMemory1") var rareBonusCountKyoChanceSum: Int = 0
    @AppStorage("reSwordRareCzCountCherryJakuMissMemory1") var rareCzCountCherryJakuMiss: Int = 0
    @AppStorage("reSwordRareCzCountCherryJakuHitMemory1") var rareCzCountCherryJakuHit: Int = 0
    @AppStorage("reSwordRareCzCountCherryJakuSumMemory1") var rareCzCountCherryJakuSum: Int = 0
    @AppStorage("reSwordRareCzCountCherryKyoMissMemory1") var rareCzCountCherryKyoMiss: Int = 0
    @AppStorage("reSwordRareCzCountCherryKyoHitMemory1") var rareCzCountCherryKyoHit: Int = 0
    @AppStorage("reSwordRareCzCountCherryKyoSumMemory1") var rareCzCountCherryKyoSum: Int = 0
    @AppStorage("reSwordAtScreenCount1Memory1") var atScreenCount1: Int = 0
    @AppStorage("reSwordAtScreenCount2Memory1") var atScreenCount2: Int = 0
    @AppStorage("reSwordAtScreenCount3Memory1") var atScreenCount3: Int = 0
    @AppStorage("reSwordAtScreenCount4Memory1") var atScreenCount4: Int = 0
    @AppStorage("reSwordAtScreenCount5Memory1") var atScreenCount5: Int = 0
    @AppStorage("reSwordAtScreenCount6Memory1") var atScreenCount6: Int = 0
    @AppStorage("reSwordAtScreenCountSumMemory1") var atScreenCountSum: Int = 0
    @AppStorage("reSwordMemoMemory1") var memo = ""
    @AppStorage("reSwordDateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class ReSwordMemory2: ObservableObject {
    @AppStorage("reSwordZoneCount350MissMemory2") var zoneCount350Miss: Int = 0
    @AppStorage("reSwordZoneCount350HitMemory2") var zoneCount350Hit: Int = 0
    @AppStorage("reSwordZoneCount350SumMemory2") var zoneCount350Sum: Int = 0
    @AppStorage("reSwordZoneCount650MissMemory2") var zoneCount650Miss: Int = 0
    @AppStorage("reSwordZoneCount650HitMemory2") var zoneCount650Hit: Int = 0
    @AppStorage("reSwordZoneCount650SumMemory2") var zoneCount650Sum: Int = 0
    @AppStorage("reSwordRareBonusCountJakuChanceMissMemory2") var rareBonusCountJakuChanceMiss: Int = 0
    @AppStorage("reSwordRareBonusCountJakuChanceHitMemory2") var rareBonusCountJakuChanceHit: Int = 0
    @AppStorage("reSwordRareBonusCountJakuChanceSumMemory2") var rareBonusCountJakuChanceSum: Int = 0
    @AppStorage("reSwordRareBonusCountSuikaMissMemory2") var rareBonusCountSuikaMiss: Int = 0
    @AppStorage("reSwordRareBonusCountSuikaHitMemory2") var rareBonusCountSuikaHit: Int = 0
    @AppStorage("reSwordRareBonusCountSuikaSumMemory2") var rareBonusCountSuikaSum: Int = 0
    @AppStorage("reSwordRareBonusCountKyoChanceMissMemory2") var rareBonusCountKyoChanceMiss: Int = 0
    @AppStorage("reSwordRareBonusCountKyoChanceHitMemory2") var rareBonusCountKyoChanceHit: Int = 0
    @AppStorage("reSwordRareBonusCountKyoChanceSumMemory2") var rareBonusCountKyoChanceSum: Int = 0
    @AppStorage("reSwordRareCzCountCherryJakuMissMemory2") var rareCzCountCherryJakuMiss: Int = 0
    @AppStorage("reSwordRareCzCountCherryJakuHitMemory2") var rareCzCountCherryJakuHit: Int = 0
    @AppStorage("reSwordRareCzCountCherryJakuSumMemory2") var rareCzCountCherryJakuSum: Int = 0
    @AppStorage("reSwordRareCzCountCherryKyoMissMemory2") var rareCzCountCherryKyoMiss: Int = 0
    @AppStorage("reSwordRareCzCountCherryKyoHitMemory2") var rareCzCountCherryKyoHit: Int = 0
    @AppStorage("reSwordRareCzCountCherryKyoSumMemory2") var rareCzCountCherryKyoSum: Int = 0
    @AppStorage("reSwordAtScreenCount1Memory2") var atScreenCount1: Int = 0
    @AppStorage("reSwordAtScreenCount2Memory2") var atScreenCount2: Int = 0
    @AppStorage("reSwordAtScreenCount3Memory2") var atScreenCount3: Int = 0
    @AppStorage("reSwordAtScreenCount4Memory2") var atScreenCount4: Int = 0
    @AppStorage("reSwordAtScreenCount5Memory2") var atScreenCount5: Int = 0
    @AppStorage("reSwordAtScreenCount6Memory2") var atScreenCount6: Int = 0
    @AppStorage("reSwordAtScreenCountSumMemory2") var atScreenCountSum: Int = 0
    @AppStorage("reSwordMemoMemory2") var memo = ""
    @AppStorage("reSwordDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class ReSwordMemory3: ObservableObject {
    @AppStorage("reSwordZoneCount350MissMemory3") var zoneCount350Miss: Int = 0
    @AppStorage("reSwordZoneCount350HitMemory3") var zoneCount350Hit: Int = 0
    @AppStorage("reSwordZoneCount350SumMemory3") var zoneCount350Sum: Int = 0
    @AppStorage("reSwordZoneCount650MissMemory3") var zoneCount650Miss: Int = 0
    @AppStorage("reSwordZoneCount650HitMemory3") var zoneCount650Hit: Int = 0
    @AppStorage("reSwordZoneCount650SumMemory3") var zoneCount650Sum: Int = 0
    @AppStorage("reSwordRareBonusCountJakuChanceMissMemory3") var rareBonusCountJakuChanceMiss: Int = 0
    @AppStorage("reSwordRareBonusCountJakuChanceHitMemory3") var rareBonusCountJakuChanceHit: Int = 0
    @AppStorage("reSwordRareBonusCountJakuChanceSumMemory3") var rareBonusCountJakuChanceSum: Int = 0
    @AppStorage("reSwordRareBonusCountSuikaMissMemory3") var rareBonusCountSuikaMiss: Int = 0
    @AppStorage("reSwordRareBonusCountSuikaHitMemory3") var rareBonusCountSuikaHit: Int = 0
    @AppStorage("reSwordRareBonusCountSuikaSumMemory3") var rareBonusCountSuikaSum: Int = 0
    @AppStorage("reSwordRareBonusCountKyoChanceMissMemory3") var rareBonusCountKyoChanceMiss: Int = 0
    @AppStorage("reSwordRareBonusCountKyoChanceHitMemory3") var rareBonusCountKyoChanceHit: Int = 0
    @AppStorage("reSwordRareBonusCountKyoChanceSumMemory3") var rareBonusCountKyoChanceSum: Int = 0
    @AppStorage("reSwordRareCzCountCherryJakuMissMemory3") var rareCzCountCherryJakuMiss: Int = 0
    @AppStorage("reSwordRareCzCountCherryJakuHitMemory3") var rareCzCountCherryJakuHit: Int = 0
    @AppStorage("reSwordRareCzCountCherryJakuSumMemory3") var rareCzCountCherryJakuSum: Int = 0
    @AppStorage("reSwordRareCzCountCherryKyoMissMemory3") var rareCzCountCherryKyoMiss: Int = 0
    @AppStorage("reSwordRareCzCountCherryKyoHitMemory3") var rareCzCountCherryKyoHit: Int = 0
    @AppStorage("reSwordRareCzCountCherryKyoSumMemory3") var rareCzCountCherryKyoSum: Int = 0
    @AppStorage("reSwordAtScreenCount1Memory3") var atScreenCount1: Int = 0
    @AppStorage("reSwordAtScreenCount2Memory3") var atScreenCount2: Int = 0
    @AppStorage("reSwordAtScreenCount3Memory3") var atScreenCount3: Int = 0
    @AppStorage("reSwordAtScreenCount4Memory3") var atScreenCount4: Int = 0
    @AppStorage("reSwordAtScreenCount5Memory3") var atScreenCount5: Int = 0
    @AppStorage("reSwordAtScreenCount6Memory3") var atScreenCount6: Int = 0
    @AppStorage("reSwordAtScreenCountSumMemory3") var atScreenCountSum: Int = 0
    @AppStorage("reSwordMemoMemory3") var memo = ""
    @AppStorage("reSwordDateMemory3") var dateDouble = 0.0
}

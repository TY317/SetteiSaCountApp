//
//  aobutaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Aobuta: ObservableObject {
    // -------
    // 通常時
    // -------
    // アオハルチャンス確率（分母は専用のゲーム数。初当りの normalGame とは別管理）
    let ratioAoharu: [Double] = [63.7,62.4,59.4,58.6,57.2]
    @AppStorage("aobutaAoharuCount") var aoharuCount: Int = 0
    @AppStorage("aobutaAoharuGame") var aoharuGame: Int = 0
    // アオハルチャンス当選率（通常滞在時）
    let ratioAoharuSuika: [Double] = [0.4,0.4,0.4,0.4,0.4]
    let ratioAoharuCherry: [Double] = [30.1,30.9,36.3,37.5,40.2]
    let ratioAoharuChance: [Double] = [50,53.5,57.8,59,60.2]
    // アオハルチャンス当選率（高確・リラックス滞在時。全設定共通）
    let ratioAoharuHighSuika: [Double] = [30.1]
    let ratioAoharuHighCherry: [Double] = [50]
    let ratioAoharuHighChance: [Double] = [85.2]
    @AppStorage("aobutaAoharuCherryCount") var aoharuCherryCount: Int = 0
    @AppStorage("aobutaAoharuCherryCountHit") var aoharuCherryCountHit: Int = 0
    @AppStorage("aobutaAoharuChanceCount") var aoharuChanceCount: Int = 0
    @AppStorage("aobutaAoharuChanceCountHit") var aoharuChanceCountHit: Int = 0

    func resetNormal() {
        aoharuCount = 0
        aoharuGame = 0
        aoharuCherryCount = 0
        aoharuCherryCountHit = 0
        aoharuChanceCount = 0
        aoharuChanceCountHit = 0
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitSt: [Double] = [350.8,336.5,295.1,274.6,207.8]
    @AppStorage("aobutaNormalGame") var normalGame: Int = 0
    @AppStorage("aobutaFirstHitCountSt") var firstHitCountSt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountSt = 0
        minusCheck = false
    }

    // -------
    // CZ
    // -------
    // 後半最終ゲームの役別ボーナス当選率（キャラ＝不可思議モード）
    // 数値は設定2・3のみ判明。設定4〜6は未公表のため -1
    let selectListCzChara: [String] = ["古賀朋絵", "豊浜のどか", "双葉理央", "桜島麻衣", "梓川かえで", "牧之原翔子"]
    @AppStorage("aobutaSelectedCzChara") var selectedCzChara: String = "古賀朋絵"
    // 古賀朋絵
    let ratioCzKogaReplay: [Double] = [41,42,-1,-1,-1]
    let ratioCzKogaBell: [Double] = [8,10,-1,-1,-1]
    let ratioCzKogaCherry: [Double] = [41,42,-1,-1,-1]
    let ratioCzKogaChance: [Double] = [61,62,-1,-1,-1]
    // 豊浜のどか
    let ratioCzNodokaReplay: [Double] = [8,10,-1,-1,-1]
    let ratioCzNodokaBell: [Double] = [41,42,-1,-1,-1]
    let ratioCzNodokaSuikaCherry: [Double] = [41,42,-1,-1,-1]
    let ratioCzNodokaChance: [Double] = [61,62,-1,-1,-1]
    // 双葉理央
    let ratioCzRioReplay: [Double] = [41,42,-1,-1,-1]
    let ratioCzRioBell: [Double] = [8,10,-1,-1,-1]
    let ratioCzRioSuika: [Double] = [41,42,-1,-1,-1]
    let ratioCzRioChance: [Double] = [61,62,-1,-1,-1]
    // 桜島麻衣
    let ratioCzMaiReplay: [Double] = [67,68,-1,-1,-1]
    let ratioCzMaiBell: [Double] = [8,10,-1,-1,-1]
    let ratioCzMaiSuika: [Double] = [41,42,-1,-1,-1]
    let ratioCzMaiCherry: [Double] = [41,42,-1,-1,-1]
    // 梓川かえで
    let ratioCzKaedeReplay: [Double] = [51,52,-1,-1,-1]
    let ratioCzKaedeBell: [Double] = [51,52,-1,-1,-1]
    // 牧之原翔子
    let ratioCzShokoReplay: [Double] = [41,42,-1,-1,-1]
    let ratioCzShokoBell: [Double] = [8,10,-1,-1,-1]
    // 咲太ポイント解放確率（規定ポイント到達確率）
    let ratioCzSakutaPoint: [Double] = [12387.9,12163.0,12210.3,11518.1,8348.9]

    @AppStorage("aobutaCzKogaReplayCountMiss") var czKogaReplayCountMiss: Int = 0
    @AppStorage("aobutaCzKogaReplayCountHit") var czKogaReplayCountHit: Int = 0
    @AppStorage("aobutaCzKogaReplayCountSum") var czKogaReplayCountSum: Int = 0
    @AppStorage("aobutaCzKogaBellCountMiss") var czKogaBellCountMiss: Int = 0
    @AppStorage("aobutaCzKogaBellCountHit") var czKogaBellCountHit: Int = 0
    @AppStorage("aobutaCzKogaBellCountSum") var czKogaBellCountSum: Int = 0
    @AppStorage("aobutaCzKogaCherryCountMiss") var czKogaCherryCountMiss: Int = 0
    @AppStorage("aobutaCzKogaCherryCountHit") var czKogaCherryCountHit: Int = 0
    @AppStorage("aobutaCzKogaCherryCountSum") var czKogaCherryCountSum: Int = 0
    @AppStorage("aobutaCzKogaChanceCountMiss") var czKogaChanceCountMiss: Int = 0
    @AppStorage("aobutaCzKogaChanceCountHit") var czKogaChanceCountHit: Int = 0
    @AppStorage("aobutaCzKogaChanceCountSum") var czKogaChanceCountSum: Int = 0
    @AppStorage("aobutaCzNodokaReplayCountMiss") var czNodokaReplayCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaReplayCountHit") var czNodokaReplayCountHit: Int = 0
    @AppStorage("aobutaCzNodokaReplayCountSum") var czNodokaReplayCountSum: Int = 0
    @AppStorage("aobutaCzNodokaBellCountMiss") var czNodokaBellCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaBellCountHit") var czNodokaBellCountHit: Int = 0
    @AppStorage("aobutaCzNodokaBellCountSum") var czNodokaBellCountSum: Int = 0
    @AppStorage("aobutaCzNodokaSuikaCherryCountMiss") var czNodokaSuikaCherryCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaSuikaCherryCountHit") var czNodokaSuikaCherryCountHit: Int = 0
    @AppStorage("aobutaCzNodokaSuikaCherryCountSum") var czNodokaSuikaCherryCountSum: Int = 0
    @AppStorage("aobutaCzNodokaChanceCountMiss") var czNodokaChanceCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaChanceCountHit") var czNodokaChanceCountHit: Int = 0
    @AppStorage("aobutaCzNodokaChanceCountSum") var czNodokaChanceCountSum: Int = 0
    @AppStorage("aobutaCzRioReplayCountMiss") var czRioReplayCountMiss: Int = 0
    @AppStorage("aobutaCzRioReplayCountHit") var czRioReplayCountHit: Int = 0
    @AppStorage("aobutaCzRioReplayCountSum") var czRioReplayCountSum: Int = 0
    @AppStorage("aobutaCzRioBellCountMiss") var czRioBellCountMiss: Int = 0
    @AppStorage("aobutaCzRioBellCountHit") var czRioBellCountHit: Int = 0
    @AppStorage("aobutaCzRioBellCountSum") var czRioBellCountSum: Int = 0
    @AppStorage("aobutaCzRioSuikaCountMiss") var czRioSuikaCountMiss: Int = 0
    @AppStorage("aobutaCzRioSuikaCountHit") var czRioSuikaCountHit: Int = 0
    @AppStorage("aobutaCzRioSuikaCountSum") var czRioSuikaCountSum: Int = 0
    @AppStorage("aobutaCzRioChanceCountMiss") var czRioChanceCountMiss: Int = 0
    @AppStorage("aobutaCzRioChanceCountHit") var czRioChanceCountHit: Int = 0
    @AppStorage("aobutaCzRioChanceCountSum") var czRioChanceCountSum: Int = 0
    @AppStorage("aobutaCzMaiReplayCountMiss") var czMaiReplayCountMiss: Int = 0
    @AppStorage("aobutaCzMaiReplayCountHit") var czMaiReplayCountHit: Int = 0
    @AppStorage("aobutaCzMaiReplayCountSum") var czMaiReplayCountSum: Int = 0
    @AppStorage("aobutaCzMaiBellCountMiss") var czMaiBellCountMiss: Int = 0
    @AppStorage("aobutaCzMaiBellCountHit") var czMaiBellCountHit: Int = 0
    @AppStorage("aobutaCzMaiBellCountSum") var czMaiBellCountSum: Int = 0
    @AppStorage("aobutaCzMaiSuikaCountMiss") var czMaiSuikaCountMiss: Int = 0
    @AppStorage("aobutaCzMaiSuikaCountHit") var czMaiSuikaCountHit: Int = 0
    @AppStorage("aobutaCzMaiSuikaCountSum") var czMaiSuikaCountSum: Int = 0
    @AppStorage("aobutaCzMaiCherryCountMiss") var czMaiCherryCountMiss: Int = 0
    @AppStorage("aobutaCzMaiCherryCountHit") var czMaiCherryCountHit: Int = 0
    @AppStorage("aobutaCzMaiCherryCountSum") var czMaiCherryCountSum: Int = 0
    @AppStorage("aobutaCzKaedeReplayCountMiss") var czKaedeReplayCountMiss: Int = 0
    @AppStorage("aobutaCzKaedeReplayCountHit") var czKaedeReplayCountHit: Int = 0
    @AppStorage("aobutaCzKaedeReplayCountSum") var czKaedeReplayCountSum: Int = 0
    @AppStorage("aobutaCzKaedeBellCountMiss") var czKaedeBellCountMiss: Int = 0
    @AppStorage("aobutaCzKaedeBellCountHit") var czKaedeBellCountHit: Int = 0
    @AppStorage("aobutaCzKaedeBellCountSum") var czKaedeBellCountSum: Int = 0
    @AppStorage("aobutaCzShokoReplayCountMiss") var czShokoReplayCountMiss: Int = 0
    @AppStorage("aobutaCzShokoReplayCountHit") var czShokoReplayCountHit: Int = 0
    @AppStorage("aobutaCzShokoReplayCountSum") var czShokoReplayCountSum: Int = 0
    @AppStorage("aobutaCzShokoBellCountMiss") var czShokoBellCountMiss: Int = 0
    @AppStorage("aobutaCzShokoBellCountHit") var czShokoBellCountHit: Int = 0
    @AppStorage("aobutaCzShokoBellCountSum") var czShokoBellCountSum: Int = 0

    func czSumFunc() {
        czKogaReplayCountSum = czKogaReplayCountHit + czKogaReplayCountMiss
        czKogaBellCountSum = czKogaBellCountHit + czKogaBellCountMiss
        czKogaCherryCountSum = czKogaCherryCountHit + czKogaCherryCountMiss
        czKogaChanceCountSum = czKogaChanceCountHit + czKogaChanceCountMiss
        czNodokaReplayCountSum = czNodokaReplayCountHit + czNodokaReplayCountMiss
        czNodokaBellCountSum = czNodokaBellCountHit + czNodokaBellCountMiss
        czNodokaSuikaCherryCountSum = czNodokaSuikaCherryCountHit + czNodokaSuikaCherryCountMiss
        czNodokaChanceCountSum = czNodokaChanceCountHit + czNodokaChanceCountMiss
        czRioReplayCountSum = czRioReplayCountHit + czRioReplayCountMiss
        czRioBellCountSum = czRioBellCountHit + czRioBellCountMiss
        czRioSuikaCountSum = czRioSuikaCountHit + czRioSuikaCountMiss
        czRioChanceCountSum = czRioChanceCountHit + czRioChanceCountMiss
        czMaiReplayCountSum = czMaiReplayCountHit + czMaiReplayCountMiss
        czMaiBellCountSum = czMaiBellCountHit + czMaiBellCountMiss
        czMaiSuikaCountSum = czMaiSuikaCountHit + czMaiSuikaCountMiss
        czMaiCherryCountSum = czMaiCherryCountHit + czMaiCherryCountMiss
        czKaedeReplayCountSum = czKaedeReplayCountHit + czKaedeReplayCountMiss
        czKaedeBellCountSum = czKaedeBellCountHit + czKaedeBellCountMiss
        czShokoReplayCountSum = czShokoReplayCountHit + czShokoReplayCountMiss
        czShokoBellCountSum = czShokoBellCountHit + czShokoBellCountMiss
    }

    func resetCz() {
        czKogaReplayCountMiss = 0
        czKogaReplayCountHit = 0
        czKogaReplayCountSum = 0
        czKogaBellCountMiss = 0
        czKogaBellCountHit = 0
        czKogaBellCountSum = 0
        czKogaCherryCountMiss = 0
        czKogaCherryCountHit = 0
        czKogaCherryCountSum = 0
        czKogaChanceCountMiss = 0
        czKogaChanceCountHit = 0
        czKogaChanceCountSum = 0
        czNodokaReplayCountMiss = 0
        czNodokaReplayCountHit = 0
        czNodokaReplayCountSum = 0
        czNodokaBellCountMiss = 0
        czNodokaBellCountHit = 0
        czNodokaBellCountSum = 0
        czNodokaSuikaCherryCountMiss = 0
        czNodokaSuikaCherryCountHit = 0
        czNodokaSuikaCherryCountSum = 0
        czNodokaChanceCountMiss = 0
        czNodokaChanceCountHit = 0
        czNodokaChanceCountSum = 0
        czRioReplayCountMiss = 0
        czRioReplayCountHit = 0
        czRioReplayCountSum = 0
        czRioBellCountMiss = 0
        czRioBellCountHit = 0
        czRioBellCountSum = 0
        czRioSuikaCountMiss = 0
        czRioSuikaCountHit = 0
        czRioSuikaCountSum = 0
        czRioChanceCountMiss = 0
        czRioChanceCountHit = 0
        czRioChanceCountSum = 0
        czMaiReplayCountMiss = 0
        czMaiReplayCountHit = 0
        czMaiReplayCountSum = 0
        czMaiBellCountMiss = 0
        czMaiBellCountHit = 0
        czMaiBellCountSum = 0
        czMaiSuikaCountMiss = 0
        czMaiSuikaCountHit = 0
        czMaiSuikaCountSum = 0
        czMaiCherryCountMiss = 0
        czMaiCherryCountHit = 0
        czMaiCherryCountSum = 0
        czKaedeReplayCountMiss = 0
        czKaedeReplayCountHit = 0
        czKaedeReplayCountSum = 0
        czKaedeBellCountMiss = 0
        czKaedeBellCountHit = 0
        czKaedeBellCountSum = 0
        czShokoReplayCountMiss = 0
        czShokoReplayCountHit = 0
        czShokoReplayCountSum = 0
        czShokoBellCountMiss = 0
        czShokoBellCountHit = 0
        czShokoBellCountSum = 0
        minusCheck = false
    }
    // -------
    // ST終了画面
    // -------
    // 確定系の振分け（実際の振分け率が非公開のため埋め値 0.1）
    // 設定1が無い機種なので「設定2 以上濃厚」は存在しない
    let ratioScreenOver3: [Double] = [0,0.1,0.1,0.1,0.1,]
    let ratioScreenOver4: [Double] = [0,0,0.1,0.1,0.1,]
    let ratioScreenOver5: [Double] = [0,0,0,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0.1,]
    @AppStorage("aobutaScreenCount1") var screenCount1: Int = 0
    @AppStorage("aobutaScreenCount2") var screenCount2: Int = 0
    @AppStorage("aobutaScreenCount3") var screenCount3: Int = 0
    @AppStorage("aobutaScreenCount4") var screenCount4: Int = 0
    @AppStorage("aobutaScreenCount5") var screenCount5: Int = 0
    @AppStorage("aobutaScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
        )
    }

    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCount3 = 0
        screenCount4 = 0
        screenCount5 = 0
        screenCountSum = 0
        minusCheck = false
    }

    // -------
    // ST中
    // -------
    let ratioSyndrome: [Double] = [20.4,-1,-1,-1,-1]
    @AppStorage("aobutaSyndromeCountMiss") var syndromeCountMiss: Int = 0
    @AppStorage("aobutaSyndromeCountHit") var syndromeCountHit: Int = 0
    @AppStorage("aobutaSyndromeCountSum") var syndromeCountSum: Int = 0

    func syndromeSumFunc() {
        syndromeCountSum = syndromeCountHit + syndromeCountMiss
    }

    func resetDuringSt() {
        syndromeCountMiss = 0
        syndromeCountHit = 0
        syndromeCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "青春ブタ野郎はバニーガール先輩の夢を見ない"
    @AppStorage("aobutaMinusCheck") var minusCheck: Bool = false
    @AppStorage("aobutaSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetCz()
        resetScreen()
        resetDuringSt()
    }
}


class AobutaMemory1: ObservableObject {
    @AppStorage("aobutaAoharuCountMemory1") var aoharuCount: Int = 0
    @AppStorage("aobutaAoharuGameMemory1") var aoharuGame: Int = 0
    @AppStorage("aobutaAoharuCherryCountMemory1") var aoharuCherryCount: Int = 0
    @AppStorage("aobutaAoharuCherryCountHitMemory1") var aoharuCherryCountHit: Int = 0
    @AppStorage("aobutaAoharuChanceCountMemory1") var aoharuChanceCount: Int = 0
    @AppStorage("aobutaAoharuChanceCountHitMemory1") var aoharuChanceCountHit: Int = 0
    @AppStorage("aobutaNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("aobutaFirstHitCountStMemory1") var firstHitCountSt: Int = 0
    @AppStorage("aobutaCzKogaReplayCountMissMemory1") var czKogaReplayCountMiss: Int = 0
    @AppStorage("aobutaCzKogaReplayCountHitMemory1") var czKogaReplayCountHit: Int = 0
    @AppStorage("aobutaCzKogaReplayCountSumMemory1") var czKogaReplayCountSum: Int = 0
    @AppStorage("aobutaCzKogaBellCountMissMemory1") var czKogaBellCountMiss: Int = 0
    @AppStorage("aobutaCzKogaBellCountHitMemory1") var czKogaBellCountHit: Int = 0
    @AppStorage("aobutaCzKogaBellCountSumMemory1") var czKogaBellCountSum: Int = 0
    @AppStorage("aobutaCzKogaCherryCountMissMemory1") var czKogaCherryCountMiss: Int = 0
    @AppStorage("aobutaCzKogaCherryCountHitMemory1") var czKogaCherryCountHit: Int = 0
    @AppStorage("aobutaCzKogaCherryCountSumMemory1") var czKogaCherryCountSum: Int = 0
    @AppStorage("aobutaCzKogaChanceCountMissMemory1") var czKogaChanceCountMiss: Int = 0
    @AppStorage("aobutaCzKogaChanceCountHitMemory1") var czKogaChanceCountHit: Int = 0
    @AppStorage("aobutaCzKogaChanceCountSumMemory1") var czKogaChanceCountSum: Int = 0
    @AppStorage("aobutaCzNodokaReplayCountMissMemory1") var czNodokaReplayCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaReplayCountHitMemory1") var czNodokaReplayCountHit: Int = 0
    @AppStorage("aobutaCzNodokaReplayCountSumMemory1") var czNodokaReplayCountSum: Int = 0
    @AppStorage("aobutaCzNodokaBellCountMissMemory1") var czNodokaBellCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaBellCountHitMemory1") var czNodokaBellCountHit: Int = 0
    @AppStorage("aobutaCzNodokaBellCountSumMemory1") var czNodokaBellCountSum: Int = 0
    @AppStorage("aobutaCzNodokaSuikaCherryCountMissMemory1") var czNodokaSuikaCherryCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaSuikaCherryCountHitMemory1") var czNodokaSuikaCherryCountHit: Int = 0
    @AppStorage("aobutaCzNodokaSuikaCherryCountSumMemory1") var czNodokaSuikaCherryCountSum: Int = 0
    @AppStorage("aobutaCzNodokaChanceCountMissMemory1") var czNodokaChanceCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaChanceCountHitMemory1") var czNodokaChanceCountHit: Int = 0
    @AppStorage("aobutaCzNodokaChanceCountSumMemory1") var czNodokaChanceCountSum: Int = 0
    @AppStorage("aobutaCzRioReplayCountMissMemory1") var czRioReplayCountMiss: Int = 0
    @AppStorage("aobutaCzRioReplayCountHitMemory1") var czRioReplayCountHit: Int = 0
    @AppStorage("aobutaCzRioReplayCountSumMemory1") var czRioReplayCountSum: Int = 0
    @AppStorage("aobutaCzRioBellCountMissMemory1") var czRioBellCountMiss: Int = 0
    @AppStorage("aobutaCzRioBellCountHitMemory1") var czRioBellCountHit: Int = 0
    @AppStorage("aobutaCzRioBellCountSumMemory1") var czRioBellCountSum: Int = 0
    @AppStorage("aobutaCzRioSuikaCountMissMemory1") var czRioSuikaCountMiss: Int = 0
    @AppStorage("aobutaCzRioSuikaCountHitMemory1") var czRioSuikaCountHit: Int = 0
    @AppStorage("aobutaCzRioSuikaCountSumMemory1") var czRioSuikaCountSum: Int = 0
    @AppStorage("aobutaCzRioChanceCountMissMemory1") var czRioChanceCountMiss: Int = 0
    @AppStorage("aobutaCzRioChanceCountHitMemory1") var czRioChanceCountHit: Int = 0
    @AppStorage("aobutaCzRioChanceCountSumMemory1") var czRioChanceCountSum: Int = 0
    @AppStorage("aobutaCzMaiReplayCountMissMemory1") var czMaiReplayCountMiss: Int = 0
    @AppStorage("aobutaCzMaiReplayCountHitMemory1") var czMaiReplayCountHit: Int = 0
    @AppStorage("aobutaCzMaiReplayCountSumMemory1") var czMaiReplayCountSum: Int = 0
    @AppStorage("aobutaCzMaiBellCountMissMemory1") var czMaiBellCountMiss: Int = 0
    @AppStorage("aobutaCzMaiBellCountHitMemory1") var czMaiBellCountHit: Int = 0
    @AppStorage("aobutaCzMaiBellCountSumMemory1") var czMaiBellCountSum: Int = 0
    @AppStorage("aobutaCzMaiSuikaCountMissMemory1") var czMaiSuikaCountMiss: Int = 0
    @AppStorage("aobutaCzMaiSuikaCountHitMemory1") var czMaiSuikaCountHit: Int = 0
    @AppStorage("aobutaCzMaiSuikaCountSumMemory1") var czMaiSuikaCountSum: Int = 0
    @AppStorage("aobutaCzMaiCherryCountMissMemory1") var czMaiCherryCountMiss: Int = 0
    @AppStorage("aobutaCzMaiCherryCountHitMemory1") var czMaiCherryCountHit: Int = 0
    @AppStorage("aobutaCzMaiCherryCountSumMemory1") var czMaiCherryCountSum: Int = 0
    @AppStorage("aobutaCzKaedeReplayCountMissMemory1") var czKaedeReplayCountMiss: Int = 0
    @AppStorage("aobutaCzKaedeReplayCountHitMemory1") var czKaedeReplayCountHit: Int = 0
    @AppStorage("aobutaCzKaedeReplayCountSumMemory1") var czKaedeReplayCountSum: Int = 0
    @AppStorage("aobutaCzKaedeBellCountMissMemory1") var czKaedeBellCountMiss: Int = 0
    @AppStorage("aobutaCzKaedeBellCountHitMemory1") var czKaedeBellCountHit: Int = 0
    @AppStorage("aobutaCzKaedeBellCountSumMemory1") var czKaedeBellCountSum: Int = 0
    @AppStorage("aobutaCzShokoReplayCountMissMemory1") var czShokoReplayCountMiss: Int = 0
    @AppStorage("aobutaCzShokoReplayCountHitMemory1") var czShokoReplayCountHit: Int = 0
    @AppStorage("aobutaCzShokoReplayCountSumMemory1") var czShokoReplayCountSum: Int = 0
    @AppStorage("aobutaCzShokoBellCountMissMemory1") var czShokoBellCountMiss: Int = 0
    @AppStorage("aobutaCzShokoBellCountHitMemory1") var czShokoBellCountHit: Int = 0
    @AppStorage("aobutaCzShokoBellCountSumMemory1") var czShokoBellCountSum: Int = 0
    @AppStorage("aobutaScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("aobutaScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("aobutaScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("aobutaScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("aobutaScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("aobutaScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("aobutaSyndromeCountMissMemory1") var syndromeCountMiss: Int = 0
    @AppStorage("aobutaSyndromeCountHitMemory1") var syndromeCountHit: Int = 0
    @AppStorage("aobutaSyndromeCountSumMemory1") var syndromeCountSum: Int = 0
    @AppStorage("aobutaMemoMemory1") var memo = ""
    @AppStorage("aobutaDateMemory1") var dateDouble = 0.0
}


class AobutaMemory2: ObservableObject {
    @AppStorage("aobutaAoharuCountMemory2") var aoharuCount: Int = 0
    @AppStorage("aobutaAoharuGameMemory2") var aoharuGame: Int = 0
    @AppStorage("aobutaAoharuCherryCountMemory2") var aoharuCherryCount: Int = 0
    @AppStorage("aobutaAoharuCherryCountHitMemory2") var aoharuCherryCountHit: Int = 0
    @AppStorage("aobutaAoharuChanceCountMemory2") var aoharuChanceCount: Int = 0
    @AppStorage("aobutaAoharuChanceCountHitMemory2") var aoharuChanceCountHit: Int = 0
    @AppStorage("aobutaNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("aobutaFirstHitCountStMemory2") var firstHitCountSt: Int = 0
    @AppStorage("aobutaCzKogaReplayCountMissMemory2") var czKogaReplayCountMiss: Int = 0
    @AppStorage("aobutaCzKogaReplayCountHitMemory2") var czKogaReplayCountHit: Int = 0
    @AppStorage("aobutaCzKogaReplayCountSumMemory2") var czKogaReplayCountSum: Int = 0
    @AppStorage("aobutaCzKogaBellCountMissMemory2") var czKogaBellCountMiss: Int = 0
    @AppStorage("aobutaCzKogaBellCountHitMemory2") var czKogaBellCountHit: Int = 0
    @AppStorage("aobutaCzKogaBellCountSumMemory2") var czKogaBellCountSum: Int = 0
    @AppStorage("aobutaCzKogaCherryCountMissMemory2") var czKogaCherryCountMiss: Int = 0
    @AppStorage("aobutaCzKogaCherryCountHitMemory2") var czKogaCherryCountHit: Int = 0
    @AppStorage("aobutaCzKogaCherryCountSumMemory2") var czKogaCherryCountSum: Int = 0
    @AppStorage("aobutaCzKogaChanceCountMissMemory2") var czKogaChanceCountMiss: Int = 0
    @AppStorage("aobutaCzKogaChanceCountHitMemory2") var czKogaChanceCountHit: Int = 0
    @AppStorage("aobutaCzKogaChanceCountSumMemory2") var czKogaChanceCountSum: Int = 0
    @AppStorage("aobutaCzNodokaReplayCountMissMemory2") var czNodokaReplayCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaReplayCountHitMemory2") var czNodokaReplayCountHit: Int = 0
    @AppStorage("aobutaCzNodokaReplayCountSumMemory2") var czNodokaReplayCountSum: Int = 0
    @AppStorage("aobutaCzNodokaBellCountMissMemory2") var czNodokaBellCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaBellCountHitMemory2") var czNodokaBellCountHit: Int = 0
    @AppStorage("aobutaCzNodokaBellCountSumMemory2") var czNodokaBellCountSum: Int = 0
    @AppStorage("aobutaCzNodokaSuikaCherryCountMissMemory2") var czNodokaSuikaCherryCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaSuikaCherryCountHitMemory2") var czNodokaSuikaCherryCountHit: Int = 0
    @AppStorage("aobutaCzNodokaSuikaCherryCountSumMemory2") var czNodokaSuikaCherryCountSum: Int = 0
    @AppStorage("aobutaCzNodokaChanceCountMissMemory2") var czNodokaChanceCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaChanceCountHitMemory2") var czNodokaChanceCountHit: Int = 0
    @AppStorage("aobutaCzNodokaChanceCountSumMemory2") var czNodokaChanceCountSum: Int = 0
    @AppStorage("aobutaCzRioReplayCountMissMemory2") var czRioReplayCountMiss: Int = 0
    @AppStorage("aobutaCzRioReplayCountHitMemory2") var czRioReplayCountHit: Int = 0
    @AppStorage("aobutaCzRioReplayCountSumMemory2") var czRioReplayCountSum: Int = 0
    @AppStorage("aobutaCzRioBellCountMissMemory2") var czRioBellCountMiss: Int = 0
    @AppStorage("aobutaCzRioBellCountHitMemory2") var czRioBellCountHit: Int = 0
    @AppStorage("aobutaCzRioBellCountSumMemory2") var czRioBellCountSum: Int = 0
    @AppStorage("aobutaCzRioSuikaCountMissMemory2") var czRioSuikaCountMiss: Int = 0
    @AppStorage("aobutaCzRioSuikaCountHitMemory2") var czRioSuikaCountHit: Int = 0
    @AppStorage("aobutaCzRioSuikaCountSumMemory2") var czRioSuikaCountSum: Int = 0
    @AppStorage("aobutaCzRioChanceCountMissMemory2") var czRioChanceCountMiss: Int = 0
    @AppStorage("aobutaCzRioChanceCountHitMemory2") var czRioChanceCountHit: Int = 0
    @AppStorage("aobutaCzRioChanceCountSumMemory2") var czRioChanceCountSum: Int = 0
    @AppStorage("aobutaCzMaiReplayCountMissMemory2") var czMaiReplayCountMiss: Int = 0
    @AppStorage("aobutaCzMaiReplayCountHitMemory2") var czMaiReplayCountHit: Int = 0
    @AppStorage("aobutaCzMaiReplayCountSumMemory2") var czMaiReplayCountSum: Int = 0
    @AppStorage("aobutaCzMaiBellCountMissMemory2") var czMaiBellCountMiss: Int = 0
    @AppStorage("aobutaCzMaiBellCountHitMemory2") var czMaiBellCountHit: Int = 0
    @AppStorage("aobutaCzMaiBellCountSumMemory2") var czMaiBellCountSum: Int = 0
    @AppStorage("aobutaCzMaiSuikaCountMissMemory2") var czMaiSuikaCountMiss: Int = 0
    @AppStorage("aobutaCzMaiSuikaCountHitMemory2") var czMaiSuikaCountHit: Int = 0
    @AppStorage("aobutaCzMaiSuikaCountSumMemory2") var czMaiSuikaCountSum: Int = 0
    @AppStorage("aobutaCzMaiCherryCountMissMemory2") var czMaiCherryCountMiss: Int = 0
    @AppStorage("aobutaCzMaiCherryCountHitMemory2") var czMaiCherryCountHit: Int = 0
    @AppStorage("aobutaCzMaiCherryCountSumMemory2") var czMaiCherryCountSum: Int = 0
    @AppStorage("aobutaCzKaedeReplayCountMissMemory2") var czKaedeReplayCountMiss: Int = 0
    @AppStorage("aobutaCzKaedeReplayCountHitMemory2") var czKaedeReplayCountHit: Int = 0
    @AppStorage("aobutaCzKaedeReplayCountSumMemory2") var czKaedeReplayCountSum: Int = 0
    @AppStorage("aobutaCzKaedeBellCountMissMemory2") var czKaedeBellCountMiss: Int = 0
    @AppStorage("aobutaCzKaedeBellCountHitMemory2") var czKaedeBellCountHit: Int = 0
    @AppStorage("aobutaCzKaedeBellCountSumMemory2") var czKaedeBellCountSum: Int = 0
    @AppStorage("aobutaCzShokoReplayCountMissMemory2") var czShokoReplayCountMiss: Int = 0
    @AppStorage("aobutaCzShokoReplayCountHitMemory2") var czShokoReplayCountHit: Int = 0
    @AppStorage("aobutaCzShokoReplayCountSumMemory2") var czShokoReplayCountSum: Int = 0
    @AppStorage("aobutaCzShokoBellCountMissMemory2") var czShokoBellCountMiss: Int = 0
    @AppStorage("aobutaCzShokoBellCountHitMemory2") var czShokoBellCountHit: Int = 0
    @AppStorage("aobutaCzShokoBellCountSumMemory2") var czShokoBellCountSum: Int = 0
    @AppStorage("aobutaScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("aobutaScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("aobutaScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("aobutaScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("aobutaScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("aobutaScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("aobutaSyndromeCountMissMemory2") var syndromeCountMiss: Int = 0
    @AppStorage("aobutaSyndromeCountHitMemory2") var syndromeCountHit: Int = 0
    @AppStorage("aobutaSyndromeCountSumMemory2") var syndromeCountSum: Int = 0
    @AppStorage("aobutaMemoMemory2") var memo = ""
    @AppStorage("aobutaDateMemory2") var dateDouble = 0.0
}


class AobutaMemory3: ObservableObject {
    @AppStorage("aobutaAoharuCountMemory3") var aoharuCount: Int = 0
    @AppStorage("aobutaAoharuGameMemory3") var aoharuGame: Int = 0
    @AppStorage("aobutaAoharuCherryCountMemory3") var aoharuCherryCount: Int = 0
    @AppStorage("aobutaAoharuCherryCountHitMemory3") var aoharuCherryCountHit: Int = 0
    @AppStorage("aobutaAoharuChanceCountMemory3") var aoharuChanceCount: Int = 0
    @AppStorage("aobutaAoharuChanceCountHitMemory3") var aoharuChanceCountHit: Int = 0
    @AppStorage("aobutaNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("aobutaFirstHitCountStMemory3") var firstHitCountSt: Int = 0
    @AppStorage("aobutaCzKogaReplayCountMissMemory3") var czKogaReplayCountMiss: Int = 0
    @AppStorage("aobutaCzKogaReplayCountHitMemory3") var czKogaReplayCountHit: Int = 0
    @AppStorage("aobutaCzKogaReplayCountSumMemory3") var czKogaReplayCountSum: Int = 0
    @AppStorage("aobutaCzKogaBellCountMissMemory3") var czKogaBellCountMiss: Int = 0
    @AppStorage("aobutaCzKogaBellCountHitMemory3") var czKogaBellCountHit: Int = 0
    @AppStorage("aobutaCzKogaBellCountSumMemory3") var czKogaBellCountSum: Int = 0
    @AppStorage("aobutaCzKogaCherryCountMissMemory3") var czKogaCherryCountMiss: Int = 0
    @AppStorage("aobutaCzKogaCherryCountHitMemory3") var czKogaCherryCountHit: Int = 0
    @AppStorage("aobutaCzKogaCherryCountSumMemory3") var czKogaCherryCountSum: Int = 0
    @AppStorage("aobutaCzKogaChanceCountMissMemory3") var czKogaChanceCountMiss: Int = 0
    @AppStorage("aobutaCzKogaChanceCountHitMemory3") var czKogaChanceCountHit: Int = 0
    @AppStorage("aobutaCzKogaChanceCountSumMemory3") var czKogaChanceCountSum: Int = 0
    @AppStorage("aobutaCzNodokaReplayCountMissMemory3") var czNodokaReplayCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaReplayCountHitMemory3") var czNodokaReplayCountHit: Int = 0
    @AppStorage("aobutaCzNodokaReplayCountSumMemory3") var czNodokaReplayCountSum: Int = 0
    @AppStorage("aobutaCzNodokaBellCountMissMemory3") var czNodokaBellCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaBellCountHitMemory3") var czNodokaBellCountHit: Int = 0
    @AppStorage("aobutaCzNodokaBellCountSumMemory3") var czNodokaBellCountSum: Int = 0
    @AppStorage("aobutaCzNodokaSuikaCherryCountMissMemory3") var czNodokaSuikaCherryCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaSuikaCherryCountHitMemory3") var czNodokaSuikaCherryCountHit: Int = 0
    @AppStorage("aobutaCzNodokaSuikaCherryCountSumMemory3") var czNodokaSuikaCherryCountSum: Int = 0
    @AppStorage("aobutaCzNodokaChanceCountMissMemory3") var czNodokaChanceCountMiss: Int = 0
    @AppStorage("aobutaCzNodokaChanceCountHitMemory3") var czNodokaChanceCountHit: Int = 0
    @AppStorage("aobutaCzNodokaChanceCountSumMemory3") var czNodokaChanceCountSum: Int = 0
    @AppStorage("aobutaCzRioReplayCountMissMemory3") var czRioReplayCountMiss: Int = 0
    @AppStorage("aobutaCzRioReplayCountHitMemory3") var czRioReplayCountHit: Int = 0
    @AppStorage("aobutaCzRioReplayCountSumMemory3") var czRioReplayCountSum: Int = 0
    @AppStorage("aobutaCzRioBellCountMissMemory3") var czRioBellCountMiss: Int = 0
    @AppStorage("aobutaCzRioBellCountHitMemory3") var czRioBellCountHit: Int = 0
    @AppStorage("aobutaCzRioBellCountSumMemory3") var czRioBellCountSum: Int = 0
    @AppStorage("aobutaCzRioSuikaCountMissMemory3") var czRioSuikaCountMiss: Int = 0
    @AppStorage("aobutaCzRioSuikaCountHitMemory3") var czRioSuikaCountHit: Int = 0
    @AppStorage("aobutaCzRioSuikaCountSumMemory3") var czRioSuikaCountSum: Int = 0
    @AppStorage("aobutaCzRioChanceCountMissMemory3") var czRioChanceCountMiss: Int = 0
    @AppStorage("aobutaCzRioChanceCountHitMemory3") var czRioChanceCountHit: Int = 0
    @AppStorage("aobutaCzRioChanceCountSumMemory3") var czRioChanceCountSum: Int = 0
    @AppStorage("aobutaCzMaiReplayCountMissMemory3") var czMaiReplayCountMiss: Int = 0
    @AppStorage("aobutaCzMaiReplayCountHitMemory3") var czMaiReplayCountHit: Int = 0
    @AppStorage("aobutaCzMaiReplayCountSumMemory3") var czMaiReplayCountSum: Int = 0
    @AppStorage("aobutaCzMaiBellCountMissMemory3") var czMaiBellCountMiss: Int = 0
    @AppStorage("aobutaCzMaiBellCountHitMemory3") var czMaiBellCountHit: Int = 0
    @AppStorage("aobutaCzMaiBellCountSumMemory3") var czMaiBellCountSum: Int = 0
    @AppStorage("aobutaCzMaiSuikaCountMissMemory3") var czMaiSuikaCountMiss: Int = 0
    @AppStorage("aobutaCzMaiSuikaCountHitMemory3") var czMaiSuikaCountHit: Int = 0
    @AppStorage("aobutaCzMaiSuikaCountSumMemory3") var czMaiSuikaCountSum: Int = 0
    @AppStorage("aobutaCzMaiCherryCountMissMemory3") var czMaiCherryCountMiss: Int = 0
    @AppStorage("aobutaCzMaiCherryCountHitMemory3") var czMaiCherryCountHit: Int = 0
    @AppStorage("aobutaCzMaiCherryCountSumMemory3") var czMaiCherryCountSum: Int = 0
    @AppStorage("aobutaCzKaedeReplayCountMissMemory3") var czKaedeReplayCountMiss: Int = 0
    @AppStorage("aobutaCzKaedeReplayCountHitMemory3") var czKaedeReplayCountHit: Int = 0
    @AppStorage("aobutaCzKaedeReplayCountSumMemory3") var czKaedeReplayCountSum: Int = 0
    @AppStorage("aobutaCzKaedeBellCountMissMemory3") var czKaedeBellCountMiss: Int = 0
    @AppStorage("aobutaCzKaedeBellCountHitMemory3") var czKaedeBellCountHit: Int = 0
    @AppStorage("aobutaCzKaedeBellCountSumMemory3") var czKaedeBellCountSum: Int = 0
    @AppStorage("aobutaCzShokoReplayCountMissMemory3") var czShokoReplayCountMiss: Int = 0
    @AppStorage("aobutaCzShokoReplayCountHitMemory3") var czShokoReplayCountHit: Int = 0
    @AppStorage("aobutaCzShokoReplayCountSumMemory3") var czShokoReplayCountSum: Int = 0
    @AppStorage("aobutaCzShokoBellCountMissMemory3") var czShokoBellCountMiss: Int = 0
    @AppStorage("aobutaCzShokoBellCountHitMemory3") var czShokoBellCountHit: Int = 0
    @AppStorage("aobutaCzShokoBellCountSumMemory3") var czShokoBellCountSum: Int = 0
    @AppStorage("aobutaScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("aobutaScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("aobutaScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("aobutaScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("aobutaScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("aobutaScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("aobutaSyndromeCountMissMemory3") var syndromeCountMiss: Int = 0
    @AppStorage("aobutaSyndromeCountHitMemory3") var syndromeCountHit: Int = 0
    @AppStorage("aobutaSyndromeCountSumMemory3") var syndromeCountSum: Int = 0
    @AppStorage("aobutaMemoMemory3") var memo = ""
    @AppStorage("aobutaDateMemory3") var dateDouble = 0.0
}

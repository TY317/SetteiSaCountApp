//
//  index2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Index2: ObservableObject {
    // -------
    // 通常時
    // -------
    let ratioSuikaKokaku: [Double] = [47.7,48,49.2,50.4,54.7,55.5]
    let ratioSuikaMikotoKokaku: [Double] = [14.3,14.5,14.8,15.2,16.4,16.7]
    @AppStorage("index2SuikaCountKoyaku") var suikaCountKoyaku: Int = 0
    @AppStorage("index2SuikaCountKokaku") var suikaCountKokaku: Int = 0
    @AppStorage("index2SuikaCountMikoto") var suikaCountMikoto: Int = 0

    func resetNormal() {
        suikaCountKoyaku = 0
        suikaCountKokaku = 0
        suikaCountMikoto = 0
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [235.6,233.4,230.8,222.3,215.8,207.2]
    let ratioFirstHitAt: [Double] = [398.8,394.5,389.6,369.5,358,338.4]
    let ratioDirectAt: [Double] = [8000,-1,-1,-1,-1,4000]
    @AppStorage("index2NormalGame") var normalGame: Int = 0
    @AppStorage("index2FirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("index2FirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }

    // --------
    // 終了画面
    // --------
    @AppStorage("index2ScreenCount1") var screenCount1: Int = 0
    @AppStorage("index2ScreenCount2") var screenCount2: Int = 0
    @AppStorage("index2ScreenCount3") var screenCount3: Int = 0
    @AppStorage("index2ScreenCount4") var screenCount4: Int = 0
    @AppStorage("index2ScreenCount5") var screenCount5: Int = 0
    @AppStorage("index2ScreenCount6") var screenCount6: Int = 0
    @AppStorage("index2ScreenCount7") var screenCount7: Int = 0
    @AppStorage("index2ScreenCount8") var screenCount8: Int = 0
    @AppStorage("index2ScreenCount9") var screenCount9: Int = 0
    @AppStorage("index2ScreenCount10") var screenCount10: Int = 0
    @AppStorage("index2ScreenCount11") var screenCount11: Int = 0
    @AppStorage("index2ScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
            screenCount6,
            screenCount7,
            screenCount8,
            screenCount9,
            screenCount10,
            screenCount11,
        )
    }

    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCount3 = 0
        screenCount4 = 0
        screenCount5 = 0
        screenCount6 = 0
        screenCount7 = 0
        screenCount8 = 0
        screenCount9 = 0
        screenCount10 = 0
        screenCount11 = 0
        screenCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "とある魔術の禁書目録2"
    @AppStorage("index2MinusCheck") var minusCheck: Bool = false
    @AppStorage("index2SelectedMemory") var selectedMemory = "メモリー1"

    // -------
    // セリフ選択
    // -------
    @AppStorage("index2CommentCount1") var commentCount1: Int = 0
    @AppStorage("index2CommentCount2") var commentCount2: Int = 0
    @AppStorage("index2CommentCount3") var commentCount3: Int = 0
    @AppStorage("index2CommentCount4") var commentCount4: Int = 0
    @AppStorage("index2CommentCount5") var commentCount5: Int = 0
    @AppStorage("index2CommentCount6") var commentCount6: Int = 0
    @AppStorage("index2CommentCount7") var commentCount7: Int = 0
    @AppStorage("index2CommentCount8") var commentCount8: Int = 0
    @AppStorage("index2CommentCount9") var commentCount9: Int = 0
    @AppStorage("index2CommentCountSum") var commentCountSum: Int = 0

    func commentSumFunc() {
        commentCountSum = countSum(
            commentCount1,
            commentCount2,
            commentCount3,
            commentCount4,
            commentCount5,
            commentCount6,
            commentCount7,
            commentCount8,
            commentCount9,
        )
    }

    func resetComment() {
        commentCount1 = 0
        commentCount2 = 0
        commentCount3 = 0
        commentCount4 = 0
        commentCount5 = 0
        commentCount6 = 0
        commentCount7 = 0
        commentCount8 = 0
        commentCount9 = 0
        commentCountSum = 0
        minusCheck = false
    }

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetComment()
    }
}


class Index2Memory1: ObservableObject {
    @AppStorage("index2SuikaCountKoyakuMemory1") var suikaCountKoyaku: Int = 0
    @AppStorage("index2SuikaCountKokakuMemory1") var suikaCountKokaku: Int = 0
    @AppStorage("index2SuikaCountMikotoMemory1") var suikaCountMikoto: Int = 0
    @AppStorage("index2NormalGameMemory1") var normalGame: Int = 0
    @AppStorage("index2FirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("index2FirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("index2ScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("index2ScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("index2ScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("index2ScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("index2ScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("index2ScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("index2ScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("index2ScreenCount8Memory1") var screenCount8: Int = 0
    @AppStorage("index2ScreenCount9Memory1") var screenCount9: Int = 0
    @AppStorage("index2ScreenCount10Memory1") var screenCount10: Int = 0
    @AppStorage("index2ScreenCount11Memory1") var screenCount11: Int = 0
    @AppStorage("index2ScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("index2CommentCount1Memory1") var commentCount1: Int = 0
    @AppStorage("index2CommentCount2Memory1") var commentCount2: Int = 0
    @AppStorage("index2CommentCount3Memory1") var commentCount3: Int = 0
    @AppStorage("index2CommentCount4Memory1") var commentCount4: Int = 0
    @AppStorage("index2CommentCount5Memory1") var commentCount5: Int = 0
    @AppStorage("index2CommentCount6Memory1") var commentCount6: Int = 0
    @AppStorage("index2CommentCount7Memory1") var commentCount7: Int = 0
    @AppStorage("index2CommentCount8Memory1") var commentCount8: Int = 0
    @AppStorage("index2CommentCount9Memory1") var commentCount9: Int = 0
    @AppStorage("index2CommentCountSumMemory1") var commentCountSum: Int = 0
    @AppStorage("index2MemoMemory1") var memo = ""
    @AppStorage("index2DateMemory1") var dateDouble = 0.0
}


class Index2Memory2: ObservableObject {
    @AppStorage("index2SuikaCountKoyakuMemory2") var suikaCountKoyaku: Int = 0
    @AppStorage("index2SuikaCountKokakuMemory2") var suikaCountKokaku: Int = 0
    @AppStorage("index2SuikaCountMikotoMemory2") var suikaCountMikoto: Int = 0
    @AppStorage("index2NormalGameMemory2") var normalGame: Int = 0
    @AppStorage("index2FirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("index2FirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("index2ScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("index2ScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("index2ScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("index2ScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("index2ScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("index2ScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("index2ScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("index2ScreenCount8Memory2") var screenCount8: Int = 0
    @AppStorage("index2ScreenCount9Memory2") var screenCount9: Int = 0
    @AppStorage("index2ScreenCount10Memory2") var screenCount10: Int = 0
    @AppStorage("index2ScreenCount11Memory2") var screenCount11: Int = 0
    @AppStorage("index2ScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("index2CommentCount1Memory2") var commentCount1: Int = 0
    @AppStorage("index2CommentCount2Memory2") var commentCount2: Int = 0
    @AppStorage("index2CommentCount3Memory2") var commentCount3: Int = 0
    @AppStorage("index2CommentCount4Memory2") var commentCount4: Int = 0
    @AppStorage("index2CommentCount5Memory2") var commentCount5: Int = 0
    @AppStorage("index2CommentCount6Memory2") var commentCount6: Int = 0
    @AppStorage("index2CommentCount7Memory2") var commentCount7: Int = 0
    @AppStorage("index2CommentCount8Memory2") var commentCount8: Int = 0
    @AppStorage("index2CommentCount9Memory2") var commentCount9: Int = 0
    @AppStorage("index2CommentCountSumMemory2") var commentCountSum: Int = 0
    @AppStorage("index2MemoMemory2") var memo = ""
    @AppStorage("index2DateMemory2") var dateDouble = 0.0
}


class Index2Memory3: ObservableObject {
    @AppStorage("index2SuikaCountKoyakuMemory3") var suikaCountKoyaku: Int = 0
    @AppStorage("index2SuikaCountKokakuMemory3") var suikaCountKokaku: Int = 0
    @AppStorage("index2SuikaCountMikotoMemory3") var suikaCountMikoto: Int = 0
    @AppStorage("index2NormalGameMemory3") var normalGame: Int = 0
    @AppStorage("index2FirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("index2FirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("index2ScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("index2ScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("index2ScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("index2ScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("index2ScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("index2ScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("index2ScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("index2ScreenCount8Memory3") var screenCount8: Int = 0
    @AppStorage("index2ScreenCount9Memory3") var screenCount9: Int = 0
    @AppStorage("index2ScreenCount10Memory3") var screenCount10: Int = 0
    @AppStorage("index2ScreenCount11Memory3") var screenCount11: Int = 0
    @AppStorage("index2ScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("index2CommentCount1Memory3") var commentCount1: Int = 0
    @AppStorage("index2CommentCount2Memory3") var commentCount2: Int = 0
    @AppStorage("index2CommentCount3Memory3") var commentCount3: Int = 0
    @AppStorage("index2CommentCount4Memory3") var commentCount4: Int = 0
    @AppStorage("index2CommentCount5Memory3") var commentCount5: Int = 0
    @AppStorage("index2CommentCount6Memory3") var commentCount6: Int = 0
    @AppStorage("index2CommentCount7Memory3") var commentCount7: Int = 0
    @AppStorage("index2CommentCount8Memory3") var commentCount8: Int = 0
    @AppStorage("index2CommentCount9Memory3") var commentCount9: Int = 0
    @AppStorage("index2CommentCountSumMemory3") var commentCountSum: Int = 0
    @AppStorage("index2MemoMemory3") var memo = ""
    @AppStorage("index2DateMemory3") var dateDouble = 0.0
}

//
//  arraySumGameNotResetWordOne.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/29.
//

import Foundation
import SwiftUI

// //////////////////
// 関数；ゲーム数配列から通常ゲーム数を算出する
// 　　　特定のワードの場合のみゲーム数をリセットしない
// //////////////////

func arraySumGameNotResetWordOne(
    gameArrayData: Data?,
    bonusArrayData: Data?,
    notResetWord: String) -> Int {
    let gameArray = decodeIntArray(from: gameArrayData)
    let bonusArray = decodeStringArray(from: bonusArrayData)
    var lastGame = 0
    var currentGame = 0
    var hitGame = 0
    var playGame = 0
    
    // 配列の数を確認し0なら0を返す
    if gameArray.count == 0 {
        return 0
    }
    // 配列にデータがあれば1個ずつ確認しながらゲーム数を足していく
    else {
        for (index, bonus) in bonusArray.enumerated() {
            if bonus != notResetWord {
                hitGame = gameArray[index]
                playGame = playGame + hitGame - currentGame
                currentGame = 0
                lastGame = 0
            } else {
                currentGame = gameArray[index]
                playGame = playGame + currentGame - lastGame
                lastGame = currentGame
            }
        }
        return playGame
    }
}

//
//  BayesClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/10.
//

import Foundation
import SwiftUI

class Bayes: ObservableObject {
    // /////////////
    // 事前確率
    // /////////////
    // //// 配分パターンの選択
    let guessPatternList: [String] = [
        "デフォルト",
        "ｼﾞｬｸﾞﾗｰﾃﾞﾌｫﾙﾄ",
        "均等",
        "ニブイチ",
        "ヨブイチ",
        "カスタム1",
        "カスタム2",
        "カスタム3",
    ]
    @AppStorage("bayesSelectedBeforeGuessPattern") var selectedBeforeGuessPattern: String = "デフォルト"
    
    // //// 事前確率_設定6段階
    let guess6Default: [Int] = [72,21,2,3,1,1]
    let guess6JugDefault: [Int] = [30,40,20,7,2,1]
    let guess6Evenly: [Int] = [1,1,1,1,1,1]
    let guess6Half: [Int] = [30,15,5,30,15,5]
    let guess6Quater: [Int] = [50,20,5,15,7,3]
    let guess6Custom1Key = "bayesGuess6Custom1Key"
    let guess6Custom2Key = "bayesGuess6Custom2Key"
    let guess6Custom3Key = "bayesGuess6Custom3Key"
    @AppStorage("bayesGuess6Custom1Key") var guess6Custom1JSON: String = "[1,1,1,1,1,1]"
    @AppStorage("bayesGuess6Custom2Key") var guess6Custom2JSON: String = "[1,1,1,1,1,1]"
    @AppStorage("bayesGuess6Custom3Key") var guess6Custom3JSON: String = "[1,1,1,1,1,1]"
    
}

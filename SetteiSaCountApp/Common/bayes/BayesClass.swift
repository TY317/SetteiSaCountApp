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
    
    // //// 事前確率_設定5段階
    let guess5Default: [Int] = [73,22,3,1,1]
    let guess5JugDefault: [Int] = [40,50,7,2,1]
    let guess5Evenly: [Int] = [1,1,1,1,1]
    let guess5Half: [Int] = [33,17,30,15,5]
    let guess5Quater: [Int] = [53,22,15,7,3]
    let guess5Custom1Key = "bayesGuess5Custom1Key"
    let guess5Custom2Key = "bayesGuess5Custom2Key"
    let guess5Custom3Key = "bayesGuess5Custom3Key"
    @AppStorage("bayesGuess5Custom1Key") var guess5Custom1JSON: String = "[1,1,1,1,1]"
    @AppStorage("bayesGuess5Custom2Key") var guess5Custom2JSON: String = "[1,1,1,1,1]"
    @AppStorage("bayesGuess5Custom3Key") var guess5Custom3JSON: String = "[1,1,1,1,1]"
    
    // //// 事前確率_設定4段階
    let guess4Default: [Int] = [75,23,1,1]
    let guess4JugDefault: [Int] = [45,52,2,1]
    let guess4Evenly: [Int] = [1,1,1,1]
    let guess4Half: [Int] = [35,15,35,15]
    let guess4Quater: [Int] = [50,25,15,10]
    let guess4Custom1Key = "bayesGuess4Custom1Key"
    let guess4Custom2Key = "bayesGuess4Custom2Key"
    let guess4Custom3Key = "bayesGuess4Custom3Key"
    @AppStorage("bayesGuess4Custom1Key") var guess4Custom1JSON: String = "[1,1,1,1]"
    @AppStorage("bayesGuess4Custom2Key") var guess4Custom2JSON: String = "[1,1,1,1]"
    @AppStorage("bayesGuess4Custom3Key") var guess4Custom3JSON: String = "[1,1,1,1]"
    
}

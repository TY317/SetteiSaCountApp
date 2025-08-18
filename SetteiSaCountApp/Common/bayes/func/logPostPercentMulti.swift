//
//  logPostPercentMulti.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/13.
//

import Foundation
import SwiftUI

func logPostPercentMulti(
    countList: [Int],
    ratioList: [[Double]],
    bigNumber: Int,
    epsilon: Double = 1e-12
) -> [Double] {
    // 設定の段階数を取得しておく
    guard let settingNumber = ratioList.first?.count else {
        return []
    }
    
    // 整数値をDoubleにしておく
    let countListDouble = countList.map(Double.init)
    let bigNumberDouble = Double(bigNumber)
    
    // 対数尤度
    var logPost = [Double](repeating: 0, count: settingNumber)
    
    // //// 対数尤度の加算
    // 設定ごとの計算ループ
    for i in 0..<settingNumber {
        // 残り(other)の確率を計算
        let totalRatio = ratioList.reduce(0.0) { $0 + ($1[i]/100.0) }   // 引数で与えられた確率の合算
        let pOther = max(1.0 - totalRatio, 0.0)   // 上記合算以外の確率
        let otherCount = bigNumberDouble - countListDouble.reduce(0, +)   // カウント値以外の数を算出
        
        // log値の合算用の変数を準備
        var sumLog: Double = 0.0
        
        // 要素ごとのlog値合算　計算ループ
        for (count, ratio) in zip(countListDouble, ratioList) {
            sumLog += count * log((ratio[i]/100)+epsilon)
        }
        
        // 残り(other)のlog値
        sumLog += otherCount * log(pOther+epsilon)
        
        // 対数尤度の値更新
        logPost[i] = sumLog
    }
    
    return logPost
}

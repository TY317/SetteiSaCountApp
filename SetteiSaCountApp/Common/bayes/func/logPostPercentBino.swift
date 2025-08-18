//
//  logPostPercentBino.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/13.
//

import Foundation
import SwiftUI

func logPostPercentBino(
    ratio: [Double],
    Count: Int,
    bigNumber: Int,
    epsilon: Double = 1e-12,
) -> [Double] {
    // 中身が全部0のリストを準備しておく
    var logPostList = [Double](repeating: 0, count: ratio.count)
    
    // 引数をDoubleにしておく
    let Count: Double = Double(Count)
    let bigNumber: Double = Double(bigNumber)
    
    // 各設定の尤度を計算
    for (i, percent) in ratio.enumerated() {
        let p: Double = percent / 100.0
        logPostList[i] = Count * log(p+epsilon) + (bigNumber - Count) * log(1.0 - p + epsilon)
    }
    
    return logPostList
}


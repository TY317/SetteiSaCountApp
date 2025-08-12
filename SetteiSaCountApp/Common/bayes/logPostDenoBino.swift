//
//  logPostDenoBino.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/11.
//

import Foundation
import SwiftUI

func logPostDenoBino(
    ratio: [Double],
    Count: Int,
    bigNumber: Int,
) -> [Double] {
    // 中身が全部0のリストを準備しておく
    var logPostList = [Double](repeating: 0, count: ratio.count)
    
    // 引数をDoubleにしておく
    let Count: Double = Double(Count)
    let bigNumber: Double = Double(bigNumber)
    
    // 各設定の尤度を計算
    for (i, deno) in ratio.enumerated() {
        let p: Double = 1.0 / deno
        logPostList[i] = Count * log(p) + (bigNumber - Count) * log(1.0 - p)
    }
    
    return logPostList
}

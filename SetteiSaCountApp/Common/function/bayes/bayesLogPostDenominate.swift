//
//  bayesLogPostDenominate.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/06.
//

import Foundation
import SwiftUI

func bayesLogPostDenominate(denoList: [Double], countNumber: Int,bigNumber: Int, enable: Bool) -> [Double] {
    // 設定の数をリストから取得
    let settingNumber = denoList.count
    
    // 対数尤度を格納するリストを準備しておく
    var logPostList = [Double](repeating: 0, count: settingNumber)
    
    if enable {
        // カウント値をDouble型にしておく
        let countNumberDouble = Double(countNumber)
        let bigNumberDouble = Double(bigNumber)
        
        // 各設定の対数尤度をリストに格納していく
        for (i, deno) in denoList.enumerated() {
            let p = 1.0 / deno
            logPostList[i] = countNumberDouble * log(p) + (bigNumberDouble-countNumberDouble) * log(1.0 - p)
        }
    }
    
    return logPostList
}

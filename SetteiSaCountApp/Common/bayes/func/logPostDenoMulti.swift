//
//  logPostDenoMulti.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/06.
//

import Foundation
import SwiftUI

func logPostDenoMulti(
    countList: [Int],
    denoList: [[Double]],
    bigNumber: Int,
    epsilon: Double = 1e-12
) -> [Double] {
    // 設定の段階数を取得しておく
    guard let settingNumber = denoList.first?.count else {
        return []
    }
    
    // 整数値をDoubleにしておく
    let countListDouble = countList.map(Double.init)
    let bigNumberDouble = Double(bigNumber)
    
    // 対数尤度
    var logPost = [Double](repeating: 0, count: settingNumber)
    
    // 確率分母のリストを確率のリストに変換する
    let ratioList = denoList.map { row in
        row.map { 1.0 / Double($0) }
    }
    
    // //// 対数尤度の加算
    // 設定ごとの計算ループ
    for i in 0..<settingNumber {
        // 残り(other)の確率を計算
//        let totalRatio = ratioList.reduce(0.0) { $0 + ($1[i]/100.0) }   // 引数で与えられた確率の合算
        let totalRatio = ratioList.reduce(0.0) { $0 + $1[i] }   // 引数で与えられた確率の合算
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

//
//  logPostBefore.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/11.
//

import Foundation
import SwiftUI

func logPostBeforeFunc(
    guess: [Int],
    epsilon: Double = 1e-12,
) -> [Double] {
    var logPost: [Double] = [Double](repeating: 0, count: guess.count)
    let upSum: Double = Double(guess.reduce(0, +))
    for (i, n) in guess.enumerated() {
        let p: Double = Double(n) / upSum
        logPost[i] = log(p + epsilon)
    }
    
    return logPost
}

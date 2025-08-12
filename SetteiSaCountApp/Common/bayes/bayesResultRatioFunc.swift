//
//  bayesResultRatioFunc.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/11.
//

import Foundation
import SwiftUI

func bayesResultRatioFunc(logPost: [Double]) -> [Double] {
    let maxLP = logPost.max() ?? 0
    let unnormalizedProbability: [Double] = logPost.map { exp($0 - maxLP) }
    let upSum = unnormalizedProbability.reduce(0, +)
    let normalizedProbability: [Double] = unnormalizedProbability.map { $0 / upSum * 100 }
    
    return normalizedProbability
}

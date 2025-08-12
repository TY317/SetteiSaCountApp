//
//  arraySumDouble.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/11.
//

import Foundation
import SwiftUI

func arraySumDouble(_ arrays: [[Double]]) -> [Double] {
    guard let maxCount = arrays.map(\.count).max() else { return [] }
    
    return (0..<maxCount).map { index in
        arrays.reduce(0) { sum, array in
            sum + (index < array.count ? array[index] : 0)
        }
    }
}

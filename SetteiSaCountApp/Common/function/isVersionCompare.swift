//
//  isVersionCompare.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/21.
//

import Foundation
import SwiftUI

func isVersionCompare(_ version: String, lessThan target: String) -> Bool {
    let v1 = versionStringToNumbers(version)
    let v2 = versionStringToNumbers(target)

    for i in 0..<max(v1.count, v2.count) {
        let num1 = i < v1.count ? v1[i] : 0
        let num2 = i < v2.count ? v2[i] : 0
        if num1 < num2 { return true }
        if num1 > num2 { return false }
    }
    return false // 同じなら false
}

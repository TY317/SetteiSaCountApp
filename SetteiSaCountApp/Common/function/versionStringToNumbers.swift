//
//  versionStringToNumbers.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/21.
//

import Foundation
import SwiftUI

func versionStringToNumbers(_ version: String) -> [Int] {
    return version.split(separator: ".").compactMap { Int($0) }
}

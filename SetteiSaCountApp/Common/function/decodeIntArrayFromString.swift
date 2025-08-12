//
//  decodeIntArrayFromString.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/10.
//

import Foundation
import SwiftUI

func decodeIntArrayFromString(stringData: String) -> [Int] {
    guard let data = stringData.data(using: .utf8) else { return [] }
    return (try? JSONDecoder().decode([Int].self, from: data)) ?? []
}

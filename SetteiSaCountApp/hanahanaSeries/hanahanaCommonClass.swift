//
//  hanahanaCommonClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import Foundation
import SwiftUI

class HanahanaCommon: ObservableObject {
    let ratioBigSuika: [Double] = [48,44,42,40,35,32]
    let ratioBigLampBlue: [Double] = [3.6,4.1,4.3,4.9,5.4,5.8]
    let ratioBigLampYellow: [Double] = [2.9,3.0,3.5,3.9,4.1,4.6]
    let ratioBigLampGreen: [Double] = [1.9,2.1,2.3,2.5,2.7,3.1]
    let ratioBigLampRed: [Double] = [1.3,1.4,1.5,1.6,1.8,1.9]
    let ratioBigLampRainbow: [Double] = [0.01,0.04,0.07,0.07,0.2,0.4]
    let ratioBigLampSum: [Double] = [9.7,10.6,11.7,13.0,14.2,15.8]
    let ratioRegSideLampBlue: [Double] = [36,23,33,22,31,25]
    let ratioRegSideLampYellow: [Double] = [24,35,22,32,21,25]
    let ratioRegSideLampGreen: [Double] = [24,17,27,18,29,25]
    let ratioRegSideLampRed: [Double] = [16,25,18,28,19,25]
    let ratioRegSideLampRainbow: [Double] = [0.05,0.06,0.08,0.2,0.4,0.8]
    let ratioRegTopLampBlue: [Double] = [0,0.2,0.2,0.4,0.4,0.4]
    let ratioRegTopLampYellow: [Double] = [0,0,0.2,0.2,0.4,0.4]
    let ratioRegTopLampGreen: [Double] = [0,0,0,0.2,0.2,0.4]
    let ratioRegTopLampRed: [Double] = [0,0,0,0,0.2,0.2]
    let ratioRegTopLampRainbow: [Double] = [0,0,0,0,0,0.2]
}

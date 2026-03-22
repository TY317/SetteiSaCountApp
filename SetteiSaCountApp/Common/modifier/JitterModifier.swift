//
//  JitterModifier.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/21.
//

import Foundation
import SwiftUI


struct JitterModifier: ViewModifier {
    var isEditing: Bool

    func body(content: Content) -> some View {
        if isEditing {
            // .animationではなく、画面の更新タイミング（1/60秒ごとなど）に同期させる
            TimelineView(.animation) { timeline in
                content
                    .rotationEffect(.degrees(calculateAngle(at: timeline.date)))
            }
        } else {
            content
                .rotationEffect(.degrees(0))
        }
    }

    // 時刻に基づいて滑らかなサイン波を生成する
    private func calculateAngle(at date: Date) -> Double {
        let frequency: Double = 8.0  // 揺れる速さ（Hz）。お好みで調整してください
        let amplitude: Double = 2.5  // 揺れる幅（度）。
        
        // 時間の経過をラジアンに変換してサイン波を作る
        let time = date.timeIntervalSinceReferenceDate
        let angle = sin(time * .pi * frequency) * amplitude
        
        return angle
    }
}

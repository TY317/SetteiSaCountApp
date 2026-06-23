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
    /// アイコンごとの位相オフセット(0..1想定)。iPhoneホーム画面のように
    /// 各アイコンの揺れをバラけさせる（同期させない）ために使う。
    var seed: Double = 0

    func body(content: Content) -> some View {
        if isEditing {
            // .animationではなく、画面の更新タイミング（1/60秒ごとなど）に同期させる
            TimelineView(.animation) { timeline in
                content
                    .rotationEffect(.degrees(calculateAngle(at: timeline.date)))
                    .offset(y: calculateBounce(at: timeline.date))
            }
        } else {
            content
                .rotationEffect(.degrees(0))
        }
    }

    // 時刻に基づくサイン波。seedで位相・速さ・幅をアイコンごとにずらす
    private func calculateAngle(at date: Date) -> Double {
        let frequency: Double = 8.0 + seed * 1.5   // 8.0〜9.5：速さを少しばらつかせる
        let amplitude: Double = 2.3 + seed * 0.6   // 2.3〜2.9度：幅を少しばらつかせる
        let phase: Double = seed * 2 * .pi         // 開始位相をずらす（同期を崩す）

        let time = date.timeIntervalSinceReferenceDate
        return sin(time * .pi * frequency + phase) * amplitude
    }

    // 回転と位相をずらした微小な上下バウンド（iOSらしさ）
    private func calculateBounce(at date: Date) -> Double {
        let frequency: Double = 8.0 + seed * 1.5
        let phase: Double = seed * 2 * .pi + .pi / 2
        let amplitude: Double = 0.8                 // ±0.8pt程度の控えめなバウンド

        let time = date.timeIntervalSinceReferenceDate
        return sin(time * .pi * frequency + phase) * amplitude
    }
}

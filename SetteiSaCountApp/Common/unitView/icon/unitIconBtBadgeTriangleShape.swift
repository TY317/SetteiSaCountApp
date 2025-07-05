//
//  unitIconBtBadgeTriangleShape.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/14.
//

import Foundation
import SwiftUI

struct unitIconBtTriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY)) // 左上
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // 右上
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // 左下
        path.closeSubpath()

        return path
    }
}

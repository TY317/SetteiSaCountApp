//
//  unitResultDenoNotBinding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/18.
//

import SwiftUI

struct unitResultDenoNotBinding: View {
    var title: String
    var color: Color = .grayBack
    var count: Int
    var bigNumber: Int
    var numberofDicimal: Int
    var spacerBool: Bool = true
    var fontTitle: Font = .body
    var fontResult: Font = .title
    var fontBunshi: Font = .body
    var denomination: Double {
        let deno = Double(bigNumber) / Double(count)
        return count > 0 ? deno : 0.0
    }
    var maxWidth: CGFloat = 200
    
    var body: some View {
        ZStack {
            // 背景用
            HStack {
                if self.spacerBool {
                    Spacer()
                }
                Rectangle()
                    .foregroundStyle(self.color)
                    .cornerRadius(15)
                    .frame(maxWidth: self.maxWidth)
                if self.spacerBool {
                    Spacer()
                }
            }
            VStack {
                Text(self.title)
                    .font(self.fontTitle)
                HStack(spacing: 0) {
                    Text("\(self.count > 0 ? 1 : 0)/")
                        .font(self.fontBunshi)
                        .lineLimit(1)
                    Text("\(String(format: "%.\(numberofDicimal)f", self.denomination))")
                        .font(self.fontResult)
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
            }
        }
    }
}

#Preview {
    List {
        unitResultDenoNotBinding(
            title: "test",
            count: 10,
            bigNumber: 17,
            numberofDicimal: 1,
        )
    }
}

//
//  unitResultListPercentBoolFlush.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/26.
//

import SwiftUI

struct unitResultListPercentBoolFlush: View {
    var title: String
    @Binding var count: Int
    @Binding var bigNumber: Int
    @Binding var flushTrigger: Bool
    var numberOfDicimal: Int = 0
    var flushColor: Color
    var body: some View {
        ZStack {
            Rectangle()
                .modifierBackGroundFlashBool(
                    trigger: self.flushTrigger,
                    color: self.flushColor,
                )
            HStack {
                Text(self.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("\(self.count)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(Color.secondary)
                    Text("(\(String(format: "%.\(self.numberOfDicimal)f", calcuRatio()))%)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color.secondary)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    private func calcuRatio() -> Double {
        let ratio = Double(self.count) / Double(self.bigNumber) * 100
        return bigNumber > 0 ? ratio : 0
    }
}

#Preview {
    @Previewable @State var minusCheck: Bool = true
    @Previewable @State var countInt: Int = 0
    @Previewable @State var bigInt: Int = 10
    List {
        unitResultListPercentBoolFlush(
            title: "test",
            count: $countInt,
            bigNumber: $bigInt,
            flushTrigger: $minusCheck,
            flushColor: .blue,
        )
    }
    Button {
        minusCheck.toggle()
        countInt += 1
    } label: {
        Text("test")
    }
}

//
//  unitCountSubmitWithResult.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/26.
//

import SwiftUI

struct unitCountSubmitWithResult: View {
    var title: String
    @Binding var count: Int
    @Binding var bigNumber: Int
//    @Binding var flushTrigger: Bool
    @State var flushTrigger: Bool = false
    var numberOfDicimal: Int = 0
    var flushColor: Color
    @Binding var minusCheck: Bool
    let action: () -> Void
    var body: some View {
        unitResultListPercentBoolFlush(
            title: self.title,
            count: self.$count,
            bigNumber: self.$bigNumber,
            flushTrigger: self.$flushTrigger,
            flushColor: self.flushColor
        )
        unitCountSubmitButton(
            count: self.$count,
            minusCheck: self.$minusCheck,
            action: actionFunc
        )
    }
    private func actionFunc() {
        action()
        if count > 0 {
            self.flushTrigger.toggle()
        }
    }
}

#Preview {
    @Previewable @State var flushTrigger: Bool = false
    @Previewable @State var countInt: Int = 0
    @Previewable @State var bigInt: Int = 10
    @Previewable @State var minusCheck: Bool = false
    List {
        unitCountSubmitWithResult(
            title: "test",
            count: $countInt,
            bigNumber: $bigInt,
//            flushTrigger: $flushTrigger,
            flushColor: .blue,
            minusCheck: $minusCheck,
        ) {
            countInt += 1
            flushTrigger.toggle()
        }
    }
}

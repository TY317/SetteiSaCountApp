//
//  unitCountSubmitButton.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/26.
//

import SwiftUI

struct unitCountSubmitButton: View {
    @Binding var count: Int
    @Binding var minusCheck: Bool
//    @State var flushBool: Bool = false
    let action: () -> Void
    var body: some View {
        Button {
            self.count = countUpDown(
                minusCheck: self.minusCheck,
                count: self.count
            )
            action()
        } label: {
            HStack {
                Spacer()
                if self.minusCheck == false {
                    Text("登録")
                        .fontWeight(.bold)
                        .foregroundStyle(Color.blue)
                } else {
                    Text("マイナス")
                        .fontWeight(.bold)
                        .foregroundStyle(Color.red)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    @Previewable @State var minusCheck: Bool = true
    @Previewable @State var countInt: Int = 10
    unitCountSubmitButton(
        count: $countInt,
        minusCheck: $minusCheck,
        action: testFunc
    )
    Text("\(countInt)")
}

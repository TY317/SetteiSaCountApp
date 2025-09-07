//
//  unitPickerMenuIntToString.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/03.
//

import SwiftUI

struct unitPickerMenuIntToString: View {
    var title: String
    @Binding var selectedInt: Int
    var selectList: [Int]
    var unitText: String
    
    var body: some View {
        Picker(self.title, selection: self.$selectedInt) {
            ForEach(self.selectList, id: \.self) { select in
                Text("\(select)\(self.unitText)")
            }
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    @Previewable @State var selectedInt: Int = 1
    List {
        unitPickerMenuIntToString(
            title: "test",
            selectedInt: $selectedInt,
            selectList: [1,2,3,4,5,6],
            unitText: "周期",
        )
    }
}

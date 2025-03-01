//
//  unitPickerMenuString.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/22.
//

import SwiftUI

struct unitPickerMenuString: View {
    var title: String
    @Binding var selected: String
    var selectlist: [String]
    
    var body: some View {
        Picker(self.title, selection: self.$selected) {
            ForEach(self.selectlist, id: \.self) { select in
                Text(select)
            }
        }
        .pickerStyle(.menu)
    }
}

//#Preview {
//    unitPickerMenuString()
//}

//
//  unitSectionCopyright.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/30.
//

import SwiftUI

struct unitSectionCopyright<copyText: View>: View {
    @ViewBuilder var copyText: () -> copyText
    
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                self.copyText()
            }
            .foregroundStyle(Color.secondary)
            .font(.caption)
//            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .listRowBackground(Color.clear)
    }
}

#Preview {
    List {
        unitSectionCopyright() {
            Text("test1")
            Text("test2")
        }
    }
}

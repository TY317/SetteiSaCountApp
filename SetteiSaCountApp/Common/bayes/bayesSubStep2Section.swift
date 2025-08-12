//
//  bayesSubStep2Section.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/11.
//

import SwiftUI

struct bayesSubStep2Section<destination: View>: View {
    @ViewBuilder var destination: () -> destination
    
    var body: some View {
        Section {
            self.destination()
        } header: {
            Text("STEP2) 計算要素の設定")
        }
    }
}

#Preview {
    List {
        bayesSubStep2Section() {
            Text("test")
        }
    }
}

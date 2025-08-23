//
//  unitNaviLinkBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/22.
//

import SwiftUI

struct unitNaviLinkBayes<destination: View>: View {
    @ViewBuilder var destination: () -> destination
    var body: some View {
        NavigationStack {
            NavigationLink {
                self.destination()
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "gauge.open.with.lines.needle.33percent")
                        .font(.title2)
                        .foregroundStyle(Color.blue)
                }
            }

        }
    }
}

#Preview {
    unitNaviLinkBayes() {
        Text("test")
    }
}

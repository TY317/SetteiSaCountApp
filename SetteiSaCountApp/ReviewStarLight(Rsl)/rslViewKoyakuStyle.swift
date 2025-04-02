//
//  rslViewKoyakuStyle.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/30.
//

import SwiftUI

struct rslViewKoyakuStyle: View {
    var body: some View {
        List {
            Image("rslKoyaku")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 400)
        }
        .navigationTitle("小役停止形")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    rslViewKoyakuStyle()
}

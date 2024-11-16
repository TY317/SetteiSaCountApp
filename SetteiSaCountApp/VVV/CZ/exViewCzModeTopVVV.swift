//
//  exViewCzModeTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/12.
//

import SwiftUI

struct exViewCzModeTopVVV: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                // モード詳細
                NavigationLink(destination: exViewModeDetailVVV()) {
                    Image(systemName: "square.3.layers.3d.down.right")
//                        .foregroundColor(Color.gray)
                        .foregroundStyle(Color.gray)
                        .font(.title2)
                    Text("モード詳細")
                }
                // CZ,モードに関する噂
                NavigationLink(destination: exViewCzModeVVV()) {
                    Image(systemName: "ear.badge.waveform")
//                        .foregroundColor(Color.gray)
                        .foregroundStyle(Color.gray)
                        .font(.title2)
                    Text(" CZ,モードに関する噂")
                }
                // ミミズに関する噂
                NavigationLink(destination: exViewMimizuVVV()) {
                    Image(systemName: "scribble.variable")
//                        .foregroundColor(Color.orange)
                        .foregroundStyle(Color.orange)
                        .font(.title2)
                    Text("ミミズに関する噂")
                }
            }
            .navigationTitle("CZ,モード メニュー")
            .navigationBarTitleDisplayMode(.inline)
            // //// ツールバー閉じるボタン
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("閉じる")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}

#Preview {
    exViewCzModeTopVVV()
}

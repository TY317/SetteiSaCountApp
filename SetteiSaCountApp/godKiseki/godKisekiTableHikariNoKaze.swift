//
//  godKisekiTableHikariNoKaze.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/18.
//

import SwiftUI

struct godKisekiTableHikariNoKaze: View {
    @Binding var isPresented: Bool
    var body: some View {
        ScrollView {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "左→右",
                        "右→左",
                    ],
                    maxWidth: 80,
                    lineList: [2,2]
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "モードアップに期待\nリプレイ成立でモードアップ濃厚",
                        "モードアップ以上濃厚\nリプレイ成立でGG前兆以上濃厚",
                    ],
                    maxWidth: 300,
                    lineList: [2,2]
                )
            }
        }
        .padding(.top)
        .navigationTitle("光の風")
        .navigationBarTitleDisplayMode(.inline)
        // //// ツールバー閉じるボタン
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    self.isPresented = false
                }, label: {
                    Text("閉じる")
                        .fontWeight(.bold)
                })
            }
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    godKisekiTableHikariNoKaze(
        isPresented: $isPresented
    )
        .padding(.horizontal)
}

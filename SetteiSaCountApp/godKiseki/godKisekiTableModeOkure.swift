//
//  godKisekiTableModeOkure.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/18.
//

import SwiftUI

struct godKisekiTableModeOkure: View {
    @Binding var isPresented: Bool
    var body: some View {
        ScrollView {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "液晶出目",
                    stringList: [
                        "All赤色(バラケ目)",
                        "奇数ケツテンパイ",
                        "7ハサミ＋中に偶数",
                        "7V0",
                        "70V",
                        "700",
                        "707",
                        "7VV",
                    ],
                    maxWidth: 150,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "天国準備以上の期待大",
                        "天国以上の期待大",
                        "天国以上の期待大",
                        "天国以上の期待大",
                        "天国以上の期待大",
                        "超天国の期待大",
                        "超天国の期待大",
                        "超天国の期待大",
                    ],
                    maxWidth: 250,
                )
            }
        }
        .padding(.top)
        .navigationTitle("陽炎")
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
    godKisekiTableModeOkure(
        isPresented: $isPresented
    )
    .padding(.horizontal)
}

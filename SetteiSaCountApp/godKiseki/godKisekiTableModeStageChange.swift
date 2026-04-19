//
//  godKisekiTableModeStageChange.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/18.
//

import SwiftUI

struct godKisekiTableModeStageChange: View {
    @Binding var isPresented: Bool
    let lineList: [Int] = [3,1,1,3,1,1,1,1,1,1,3,3,1]
    var body: some View {
        ScrollView {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "右回転",
                        "左回転",
                        "奥進行",
                        "チャンスボタン",
                        "ワイプ",
                    ],
                    maxWidth: 80,
                    lineList: [5,5,2,5,4],
                )
                unitTableString(
                    columTitle: "移行先",
                    stringList: [
                        "アフロディーテ\nアルテミス\nアポロン",
                        "アクロポリス",
                        "アテナ",
                        "アフロディーテ\nアルテミス\nアポロン",
                        "アクロポリス",
                        "アテナ",
                        "アテナ",
                        "アクロポリス",
                        "アクロポリス",
                        "アテナ",
                        "アフロディーテ\nアルテミス\nアポロン",
                        "アフロディーテ\nアルテミス\nアポロン",
                        "アテナ",
                    ],
                    maxWidth: 150,
                    lineList: self.lineList,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "天国準備以上の期待大",
                        "天国以上の期待大",
                        "天国準備以上の期待大",
                        "天国以上の期待大",
                        "超天国の期待大",
                        "天国以上の期待大",
                        "GG濃厚",
                        "天国以上の期待大",
                        "超天国の期待大",
                        "GG濃厚",
                        "デフォルト(ステージ転落)",
                        "GG濃厚",
                    ],
                    maxWidth: 200,
                    lineList: self.lineList,
                )
            }
        }
        .padding(.vertical)
        .padding(.horizontal)
        .navigationTitle("ステージチェンジ")
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
    godKisekiTableModeStageChange(
        isPresented: $isPresented
    )
        .padding(.horizontal)
}

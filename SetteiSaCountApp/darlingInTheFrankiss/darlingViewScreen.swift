//
//  darlingViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/03.
//

import SwiftUI

struct darlingViewScreen: View {
    @ObservedObject var darling: Darling
    let rebornList: [String] = ["復活なし", "復活あり"]
    @State var selectedReborn: String = "復活なし"
    let imageNameListReborn: [String] = [
        "darlingScreen1",
        "darlingScreen4",
        "darlingScreen5",
    ]
    let upperBeltListReborn: [String] = [
        "ゼロツー(翼)",
        "ゼロツー(幼少期)",
        "ヒロ&ゼロツー",
    ]
    let lowerBeltListReborn: [String] = [
        "デフォルト",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
    ]
    let imageNameList: [String] = [
        "darlingScreen1",
        "darlingScreen2",
        "darlingScreen3",
        "darlingScreen4",
        "darlingScreen5",
    ]
    let upperBeltList: [String] = [
        "ゼロツー(翼)",
        "まものと王子様",
        "鳥",
        "ゼロツー(幼少期)",
        "ヒロ&ゼロツー",
    ]
    let lowerBeltList: [String] = [
        "デフォルト",
        "設定2,4,6 濃厚",
        "設定3,5,6 濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    
    var body: some View {
        List {
            // //// 終了画面
            Section {
                // 注意書き
                Text("復活のありなしで示唆内容が変わるため注意")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // 復活有無選択
                Picker("", selection: self.$selectedReborn) {
                    ForEach(self.rebornList, id: \.self) { reborn in
                        Text(reborn)
                    }
                }
                .pickerStyle(.segmented)
                
                // 終了画面　表示のみ
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // 復活なし
                        if self.selectedReborn == self.rebornList[0] {
                            ForEach(self.imageNameList.indices, id: \.self) { index in
                                if self.imageNameList.indices.contains(index) &&
                                    self.upperBeltList.indices.contains(index) &&
                                    self.lowerBeltList.indices.contains(index) {
                                    unitScreenOnlyDisplay(
                                        image: Image(self.imageNameList[index]),
                                        upperBeltText: self.upperBeltList[index],
                                        lowerBeltText: self.lowerBeltList[index]
                                    )
                                }
                            }
                        }
                        
                        // 復活あり
                        else {
                            ForEach(self.imageNameListReborn.indices, id: \.self) { index in
                                if self.imageNameListReborn.indices.contains(index) &&
                                    self.upperBeltListReborn.indices.contains(index) &&
                                    self.lowerBeltListReborn.indices.contains(index) {
                                    unitScreenOnlyDisplay(
                                        image: Image(self.imageNameListReborn[index]),
                                        upperBeltText: self.upperBeltListReborn[index],
                                        lowerBeltText: self.lowerBeltListReborn[index]
                                    )
                                }
                            }
                        }
                    }
                }
                .frame(height: 120)
            } header: {
                Text("終了画面")
            }
            
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: darling.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス高確率終了画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    darlingViewScreen(
        darling: Darling(),
    )
}

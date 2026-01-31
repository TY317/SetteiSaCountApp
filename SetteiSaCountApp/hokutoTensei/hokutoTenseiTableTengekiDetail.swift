//
//  hokutoTenseiTableTengekiDetail.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/31.
//

import SwiftUI

struct hokutoTenseiTableTengekiDetail: View {
    @State var selectedItem: String = "突入G"
    let itemList: [String] = ["突入G","バトル中G","最終G"]
    
    var body: some View {
        VStack {
            // セグメントピッカー
            Picker("", selection: self.$selectedItem) {
                ForEach(self.itemList, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(.segmented)
//            .padding(.bottom)
            
            // ゲームの説明
            Text(exText(item: self.selectedItem))
                .frame(height: 70)
//                .padding(.bottom)
            
            HStack(spacing: 0) {
                unitTableSettingIndex(titleLine: 2)
                unitTablePercent(
                    columTitle: "ハズレ",
                    percentList: ratioList(item: self.selectedItem),
                    numberofDicimal: 1,
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "リプレイ\n右下がり🔔",
                    percentList: ratioListRep(item: self.selectedItem),
                    numberofDicimal: 0,
                    titleLine: 2,
                    lineList: [6],
                    colorList: [.white]
                )
                unitTablePercent(
                    columTitle: "レア役",
                    percentList: [100],
                    numberofDicimal: 0,
                    titleLine: 2,
                    lineList: [6],
                    colorList: [.white]
                )
            }
        }
    }
    
    func exText(item: String) -> String {
        switch item {
        case self.itemList[0]: return "第3停止後にケンシロウとラオウの顔アップ映像が流れるゲーム"
        case self.itemList[1]: return "バトル中のゲーム"
        case self.itemList[2]: return "どちらが攻撃するかの当落ゲーム"
        default: return "-"
        }
    }
    
    func ratioList(item: String) -> [Double] {
        switch item {
        case self.itemList[0]: return [4.7,4.7,5.1,5.5,9.4,16.4]
        case self.itemList[1]: return [0,0,0,0,0,0]
        case self.itemList[2]: return [4.7,4.7,5.1,5.5,9.4,16.4]
        default: return [4.7,4.7,5.1,5.5,9.4,16.4]
        }
    }
    
    func ratioListRep(item: String) -> [Double] {
        switch item {
        case self.itemList[0]: return [18]
        case self.itemList[1]: return [18]
        case self.itemList[2]: return [100]
        default: return [18]
        }
    }
}

#Preview {
    hokutoTenseiTableTengekiDetail()
        .padding(.horizontal)
}

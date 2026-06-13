//
//  bioRe3TableKoyakuHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/13.
//

import SwiftUI

struct bioRe3TableKoyakuHit: View {
    @ObservedObject var bioRe3: BioRe3
    let items: [String] = ["通常A","通常B", "高確", "超高確"]
    @State var selectedItem: String = "通常A"
    var body: some View {
        VStack(spacing: 15) {
            // セグメントピッカー
            Picker("", selection: self.$selectedItem) {
                ForEach(self.items, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(.segmented)
            
            VStack(alignment: .leading) {
                Text("弱レア役：弱🍒、🍉")
                Text("強レア役：チャンス目、強🍒")
            }
            
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "弱レア→CZ",
                    percentList: ratioJakuCz(str: self.selectedItem),
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "強レア→CZ",
                    percentList: ratioKyoCz(str: self.selectedItem),
                    numberofDicimal: 0,
                )
                unitTablePercent(
                    columTitle: "強レア→AT",
                    percentList: ratioKyoAt(str: self.selectedItem),
                    numberofDicimal: 1,
                )
            }
        }
    }
    
    private func ratioJakuCz(str: String) -> [Double] {
        switch str {
        case self.items[1]: return bioRe3.ratioJakuRareNormalBCz
        case self.items[2]: return bioRe3.ratioJakuRareHighCz
        case self.items[3]: return bioRe3.ratioJakuRareSuperHighCz
        default: return bioRe3.ratioJakuRareNormalACz
        }
    }
    private func ratioKyoCz(str: String) -> [Double] {
        switch str {
        case self.items[1]: return bioRe3.ratioKyoRareNormalBCz
        case self.items[2]: return bioRe3.ratioKyoRareHighCz
        case self.items[3]: return bioRe3.ratioKyoRareSuperHighCz
        default: return bioRe3.ratioKyoRareNormalACz
        }
    }
    private func ratioKyoAt(str: String) -> [Double] {
        switch str {
        case self.items[1]: return bioRe3.ratioKyoRareNormalBAt
        case self.items[2]: return bioRe3.ratioKyoRareHighAt
        case self.items[3]: return bioRe3.ratioKyoRareSuperHighAt
        default: return bioRe3.ratioKyoRareNormalAAt
        }
    }
}

#Preview {
    bioRe3TableKoyakuHit(
        bioRe3: BioRe3(),
    )
        .padding(.horizontal)
}

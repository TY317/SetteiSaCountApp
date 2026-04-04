//
//  kabaneriUnatoTableChara.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import SwiftUI

struct kabaneriUnatoTableChara: View {
    @ObservedObject var kabaneriUnato: KabaneriUnato
    let items: [String] = ["0〜4000G", "5000〜7000G", "7000〜8000G"]
    @State var selectedItem: String = "0〜4000G"
    var body: some View {
        Picker("", selection: self.$selectedItem) {
            ForEach(self.items, id: \.self) { item in
                Text(item)
            }
        }
        .pickerStyle(.segmented)
        .padding(.bottom)
        
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "奇数示唆",
                percentList: menRatio(item: self.selectedItem)
            )
            unitTablePercent(
                columTitle: "偶数示唆",
                percentList: womenRatio(item: self.selectedItem)
            )
            unitTablePercent(
                columTitle: "美馬",
                percentList: bibaRatio(item: self.selectedItem),
                numberofDicimal: 1,
            )
        }
    }
    
    func menRatio(item: String) -> [Double] {
        switch item {
        case self.items[0]: return kabaneriUnato.ratioCharaMen
        case self.items[1]: return kabaneriUnato.ratioCharaMen5000
        case self.items[2]: return kabaneriUnato.ratioCharaMen7000
        default: return kabaneriUnato.ratioCharaMen
        }
    }
    
    func womenRatio(item: String) -> [Double] {
        switch item {
        case self.items[0]: return kabaneriUnato.ratioCharaWomen
        case self.items[1]: return kabaneriUnato.ratioCharaWomen5000
        case self.items[2]: return kabaneriUnato.ratioCharaWomen7000
        default: return kabaneriUnato.ratioCharaWomen
        }
    }
    
    func bibaRatio(item: String) -> [Double] {
        switch item {
        case self.items[0]: return kabaneriUnato.ratioCharaBiba
        case self.items[1]: return kabaneriUnato.ratioCharaBiba5000
        case self.items[2]: return kabaneriUnato.ratioCharaBiba7000
        default: return kabaneriUnato.ratioCharaBiba
        }
    }
}

#Preview {
    kabaneriUnatoTableChara(
        kabaneriUnato: KabaneriUnato(),
    )
        .padding(.horizontal)
}

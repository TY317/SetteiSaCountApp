//
//  izaBanchoTableCommonBellA.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoTableCommonBellA: View {
    @ObservedObject var izaBancho: IzaBancho
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "共通ベルA",
                denominateList: izaBancho.ratioCommonBellA,
                numberofDicimal: 1,
            )
            unitTableDenominate(
                columTitle: "弱🍒",
                denominateList: izaBancho.ratioJakuCherry,
                numberofDicimal: 1,
            )
        }
    }
}

#Preview {
    izaBanchoTableCommonBellA(
        izaBancho: IzaBancho()
    )
}

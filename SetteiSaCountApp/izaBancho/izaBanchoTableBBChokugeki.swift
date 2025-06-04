//
//  izaBanchoTableBBChokugeki.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoTableBBChokugeki: View {
    @ObservedObject var izaBancho: IzaBancho
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "番長ボーナス直撃",
                denominateList: izaBancho.ratioBBChokugeki,
                maxWidth: 200
            )
        }
    }
}

#Preview {
    izaBanchoTableBBChokugeki(
        izaBancho: IzaBancho()
    )
}

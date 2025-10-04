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
                columTitle: "赤7",
                denominateList: izaBancho.ratioBBChokugekiRed,
            )
            unitTableDenominate(
                columTitle: "青7",
                denominateList: izaBancho.ratioBBChokugekiBlue,
            )
            unitTableDenominate(
                columTitle: "合算",
                denominateList: izaBancho.ratioBBChokugeki,
//                maxWidth: 200
            )
        }
    }
}

#Preview {
    izaBanchoTableBBChokugeki(
        izaBancho: IzaBancho()
    )
}

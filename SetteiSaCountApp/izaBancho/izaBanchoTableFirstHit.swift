//
//  izaBanchoTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoTableFirstHit: View {
    @ObservedObject var izaBancho: IzaBancho
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "初当り",
                denominateList: izaBancho.ratioFirstHit
            )
        }
    }
}

#Preview {
    izaBanchoTableFirstHit(
        izaBancho: IzaBancho()
    )
}

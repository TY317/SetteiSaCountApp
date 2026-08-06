//
//  sbjTableBbTenjo.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/06.
//

import SwiftUI

struct sbjTableBbTenjo: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・BBスルー天井があり、天井到達時は初当りがBBになる")
                Text("・基本的に初当り時のBR振分け抽選には設定差無いが、高設定ほどBBスルー天井に到達しやすくなり結果的にBBが多くなる")
            }
            
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "1スルー",
                    percentList: [0.4,0.8,1.2,2.3,2.7,3.1],
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "2スルー",
                    percentList: [0.8,1.6,3.1,5.5,9,10.2],
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "3スルー",
                    percentList: [2.3,3.9,7.8,14.1,18.0,19.5],
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "4スルー",
                    percentList: [96.5,93.7,87.9,78.1,70.3,67.2],
                    numberofDicimal: 0,
                )
            }
        }
    }
}

#Preview {
    sbjTableBbTenjo()
        .padding(.horizontal)
}

//
//  arifureSubViewTableBta.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/22.
//

import SwiftUI

struct arifureSubViewTableBta: View {
    @ObservedObject var arifure = Arifure()
    var body: some View {
        VStack{
            Text("[実質継続G数 100万回シミュレーション結果]")
                .fontWeight(.bold)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(columTitle: "2G", percentList: arifure.ratioBigTriggerContinuous2G)
                unitTablePercent(columTitle: "3G", percentList: arifure.ratioBigTriggerContinuous3G)
                unitTablePercent(columTitle: "4G以上", percentList: arifure.ratioBigTriggerContinuous4GOver)
            }
            Text("※ 独自シミュレーション値です。ご理解の上ご参考ください")
                .foregroundStyle(Color.secondary)
                .font(.caption)
            Text("[継続ループ確率の振り分け]")
                .fontWeight(.bold)
                .padding(.top)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(columTitle: "10%", percentList: arifure.ratioBigTrigger10Percent)
                unitTablePercent(columTitle: "56%", percentList: arifure.ratioBigTrigger56Percent)
                unitTablePercent(columTitle: "73%", percentList: arifure.ratioBigTrigger73Percent)
            }
        }
    }
}

#Preview {
    arifureSubViewTableBta()
}

//
//  myJug5ViewBeyesTest.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/06.
//

import SwiftUI

struct myJug5ViewBeyesTest: View {
    @ObservedObject var myJug5: MyJug5
    @State var selectedGuess: String = "デフォルト"
    let selectListGuess: [String] = ["デフォルト"]
    
    var body: some View {
        List {
            // //// step1)設定配分予想
            Section {
                unitPickerMenuString(
                    title: "設定配分",
                    selected: self.$selectedGuess,
                    selectlist: self.selectListGuess
                )
                unitTableSettingGuess(guessRatio: [10,20,30,40,50,60])
            } header: {
                Text("STEP1: 設定配分予想")
            }
            
            // //// step2)判別要素
            Section {
                
            } header: {
                Text("STEP2: 判別要素")
            }
//            Section {
//                Text("ゲーム数: \(myJug5.kenGameIput)")
//                Text("ぶどう: \(myJug5.kenBellBackCalculationCount)")
//                Text("REG: \(myJug5.kenRegCountInput)")
//            }
//            Section {
//                Text("設定配分: \(myJug5.settingRatio)")
//            }
//            Section {
////                let test = myJug5.logPostBell[0]
//                Text("対数尤度: \(myJug5.logPostBell)")
//                Toggle("ぶどう回数", isOn: $myJug5.bellEnable)
//                Text("対数尤度関数化: \(myJug5.logPostBellFunc)")
//                Text("対数尤度＋事前確率対数: \(myJug5.logPostSum)")
//                ForEach(myJug5.settingGuess.indices, id: \.self) { index in
//                    Text("設定\(index+1): \(myJug5.settingGuess[index]*100)%")
//                }
////                Text("事後確率: \(myJug5.settingGuess)")
//            } header: {
//                Text("ぶどう")
//            }
//            
//            Section {
//                Text("対数尤度: \(myJug5.logPostReg)")
//                Text("対数尤度＋事前確率対数: \(myJug5.logPostSumReg)")
//                ForEach(myJug5.settingGuessReg.indices, id: \.self) { index in
//                    Text("設定\(index+1): \(myJug5.settingGuessReg[index]*100)%")
//                }
//            }
        }
    }
}

#Preview {
    myJug5ViewBeyesTest(
        myJug5: MyJug5(),
    )
}

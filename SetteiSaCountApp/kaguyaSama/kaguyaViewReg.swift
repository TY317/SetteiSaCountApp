//
//  kaguyaViewReg.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/13.
//

import SwiftUI

struct kaguyaViewReg: View {
    @ObservedObject var kaguya = KaguyaSama()
    
    var body: some View {
        List {
            Section {
                // //// サークルピッカー横並び
                HStack {
                    // 1人目
                    unitPickerCircleString(title: "1人目", selected: $kaguya.regCharaSelectedFirst, selectList: kaguya.regCharaSelectListFirst)
                    // 2人目
                    // 1人目白銀の時の2人目
                    if kaguya.regCharaSelectedFirst == "白銀" {
                        unitPickerCircleString(title: "2人目", selected: $kaguya.regCharaSelectedSecondAfterShirogane, selectList: kaguya.regCharaSelectListSecondAfterShirogane)
                    }
                    // 1人目虹背景時の2人目
                    else if kaguya.regCharaSelectedFirst == "かぐや(虹背景)" {
                        unitPickerCircleString(title: "2人目", selected: $kaguya.regCharaSelectedSecondAfterRainbow, selectList: kaguya.regCharaSelectListSecondAfterRainbow)
                    }
                    // 1人目かぐやの時の2人目
                    else {
                        unitPickerCircleString(title: "2人目", selected: $kaguya.regCharaSelectedSecondAfterKaguya, selectList: kaguya.regCharaSelectListSecondAfterKaguya)
                    }
                }
                // //// 選択されているシナリオのカウント表示
                // 1人目が白銀
                if kaguya.regCharaSelectedFirst == "白銀" {
                    // 2人目がかぐや
                    if kaguya.regCharaSelectedSecondAfterShirogane == "かぐや" {
                        
                    }
                }
            } header: {
                Text("紹介キャラ選択")
            }
        }
        .navigationTitle("REG中のキャラ紹介")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    kaguyaViewReg()
}

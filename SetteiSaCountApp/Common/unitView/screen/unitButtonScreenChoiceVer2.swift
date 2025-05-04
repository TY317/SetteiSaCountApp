//
//  unitButtonScreenChoiceVer2.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct unitButtonScreenChoiceVer2<Screen: View>: View {
    @State var screen: Screen
    @State var screenName: String
    @Binding var selectedScreen: String
    @Binding var count: Int
    @Binding var minusCheck: Bool
    var body: some View {
        Button {
            // //// 画面選択中の処理
            if self.selectedScreen == self.screenName {
                self.count = countUpDown(minusCheck: self.minusCheck, count: self.count)
                self.selectedScreen = ""
            }
            
            // //// 非選択中の処理
            else {
                self.selectedScreen = self.screenName
            }
        } label: {
            self.screen
                .overlay {
                    // //// 選択中の場合
                    if self.selectedScreen == self.screenName {
                        // マイナスチェックONの場合
                        if self.minusCheck {
                            Rectangle()
                                .foregroundStyle(Color.white)
                                .opacity(0.6)
                                .border(Color.red, width: 10)
                                .cornerRadius(10)
                            Image(systemName: "minus.circle")
                                .foregroundStyle(Color.red)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .background(Color.white)
                                .cornerRadius(30)
                        }
                        
                        // マイナスチェックOFFの場合
                        else {
                            Rectangle()
                                .foregroundStyle(Color.white)
                                .opacity(0.6)
                                .border(Color.green, width: 10)
                                .cornerRadius(10)
                            Image(systemName: "plus.circle")
                                .foregroundStyle(Color.green)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .background(Color.white)
                                .cornerRadius(30)
                        }
                    }
                    
                    // 非選択中
                    else {
                        
                    }
                }
        }
    }
}

#Preview {
    @Previewable @State var selectedScreen: String = ""
    @Previewable @State var countTest: Int = 0
    @Previewable @State var minusCheck: Bool = false
    
    ScrollView(.horizontal) {
        unitButtonScreenChoiceVer2(
            screen: unitScreenOnlyDisplay(
                image: Image("midoriDonBonusScreen1"),
                upperBeltText: "画面1",
                lowerBeltText: "デフォルト"
            ),
            screenName: "midoriDonBonusScreen1",
            selectedScreen: $selectedScreen,
            count: $countTest,
            minusCheck: $minusCheck
        )
    }
    .frame(height: 120)
    .padding(.horizontal)
    
    Text("\(countTest)")
    
    Button {
        minusCheck.toggle()
    } label: {
        Text("マイナスチェック")
    }
}

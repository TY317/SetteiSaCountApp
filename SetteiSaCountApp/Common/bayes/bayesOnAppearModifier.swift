//
//  bayesOnAppearModifier.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/13.
//

import Foundation
import SwiftUI

struct bayesOnAppearModifier: ViewModifier {
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    var settingList: [Int] = [1,2,3,4,5,6]
    @Binding var guessCustom1: [Int]
    @Binding var guessCustom2: [Int]
    @Binding var guessCustom3: [Int]
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                // 広告をロード
                Task {
                    await viewModel.loadAd()
                }
                
                // カスタム配分を配列に変換
                // 5段階設定
                if settingList.count == 5 {
                    self.guessCustom1 = decodeIntArrayFromString(stringData: bayes.guess5Custom1JSON)
                    if self.guessCustom1.count != self.settingList.count {
                        self.guessCustom1 = Array(repeating: 1, count: self.settingList.count)
                    }
                    self.guessCustom2 = decodeIntArrayFromString(stringData: bayes.guess5Custom2JSON)
                    if self.guessCustom2.count != self.settingList.count {
                        self.guessCustom2 = Array(repeating: 1, count: self.settingList.count)
                    }
                    self.guessCustom3 = decodeIntArrayFromString(stringData: bayes.guess5Custom3JSON)
                    if self.guessCustom3.count != self.settingList.count {
                        self.guessCustom3 = Array(repeating: 1, count: self.settingList.count)
                    }
                }
                // 4段階設定
                else if settingList.count == 4 {
                    self.guessCustom1 = decodeIntArrayFromString(stringData: bayes.guess4Custom1JSON)
                    if self.guessCustom1.count != self.settingList.count {
                        self.guessCustom1 = Array(repeating: 1, count: self.settingList.count)
                    }
                    self.guessCustom2 = decodeIntArrayFromString(stringData: bayes.guess4Custom2JSON)
                    if self.guessCustom2.count != self.settingList.count {
                        self.guessCustom2 = Array(repeating: 1, count: self.settingList.count)
                    }
                    self.guessCustom3 = decodeIntArrayFromString(stringData: bayes.guess4Custom3JSON)
                    if self.guessCustom3.count != self.settingList.count {
                        self.guessCustom3 = Array(repeating: 1, count: self.settingList.count)
                    }
                }
                // 6段階設定
                else {
                    self.guessCustom1 = decodeIntArrayFromString(stringData: bayes.guess6Custom1JSON)
                    if self.guessCustom1.count != self.settingList.count {
                        self.guessCustom1 = Array(repeating: 1, count: self.settingList.count)
                    }
                    self.guessCustom2 = decodeIntArrayFromString(stringData: bayes.guess6Custom2JSON)
                    if self.guessCustom2.count != self.settingList.count {
                        self.guessCustom2 = Array(repeating: 1, count: self.settingList.count)
                    }
                    self.guessCustom3 = decodeIntArrayFromString(stringData: bayes.guess6Custom3JSON)
                    if self.guessCustom3.count != self.settingList.count {
                        self.guessCustom3 = Array(repeating: 1, count: self.settingList.count)
                    }
                }
            }
    }
}

extension View {
    func bayesOnAppear(
        bayes: Bayes,
        viewModel: InterstitialViewModel,
        settingList: [Int],
        guessCustom1: Binding<[Int]>,
        guessCustom2: Binding<[Int]>,
        guessCustom3: Binding<[Int]>
    ) -> some View {
        self.modifier(
            bayesOnAppearModifier(
                bayes: bayes,
                viewModel: viewModel,
                settingList: settingList,
                guessCustom1: guessCustom1,
                guessCustom2: guessCustom2,
                guessCustom3: guessCustom3
            )
        )
    }
}

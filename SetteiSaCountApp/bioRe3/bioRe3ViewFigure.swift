//
//  bioRe3ViewFigure.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/09.
//

import SwiftUI

struct bioRe3ViewFigure: View {
    @ObservedObject var bioRe3: BioRe3
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    
    @State var selectedItem: String = "01 Male Zombie"
    let selectList: [String] = [
        "01 Male Zombie",
        "02 Female Zombie",
        "03 Hunter β",
        "04 Hunter γ",
        "05 Jill Valentine",
        "06 Carlos Oliveira",
        "07 Mikhail Victor",
        "08 Tyrell Patrick",
        "09 Nemesis",
        "10 Brad Vickers",
        "11 Nemesis",
        "12 Nicholai Ginovaef",
        "13 Nemesis",
        "14 Charlie Doll",
        "15 Jill (Infected)",
        "16 Carlos (Infected)",
        
    ]
    let sisaList: [String] = [
        "奇数示唆 弱",
        "奇数示唆 強",
        "偶数示唆 弱",
        "偶数示唆 強",
        "高設定示唆 弱",
        "高設定示唆 中",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "No16とセットで設定4 以上濃厚",
        "No15とセットで設定4 以上濃厚",
    ]
    
    var body: some View {
        List {
            // フィギュア選択
            Section {
                // サークルピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.selectList, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
                
                // //// 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(item: self.selectedItem),
                    count: bindingVoice(item: self.selectedItem),
                    bigNumber: $bioRe3.figureCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $bioRe3.minusCheck) {
                        bioRe3.figureSumFunc()
                    }
            } header: {
                Text("フィギュア選択")
            }
            
            // カウント結果
            Section {
                ForEach(self.sisaList, id: \.self) { sisa in
                    unitResultCountListPercent(
                        title: sisa,
                        count: bindingResult(text: sisa),
                        flashColor: flushColorResult(text: sisa),
                        bigNumber: $bioRe3.figureCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bioRe3MenuFigureBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bioRe3.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("フィギュア")
        .navigationBarTitleDisplayMode(.inline)
        // //// 画面の向き情報の取得部分
        .applyOrientationHandling(
            orientation: self.$orientation,
            lastOrientation: self.$lastOrientation,
            scrollViewHeight: self.$scrollViewHeight,
            spaceHeight: self.$spaceHeight,
            lazyVGridCount: self.$lazyVGridCount,
            scrollViewHeightPortrait: self.scrollViewHeightPortrait,
            scrollViewHeightLandscape: self.scrollViewHeightLandscape,
            spaceHeightPortrait: self.spaceHeightPortrait,
            spaceHeightLandscape: self.spaceHeightLandscape,
            lazyVGridCountPortrait: self.lazyVGridCountPortrait,
            lazyVGridCountLandscape: self.lazyVGridCountLandscape
        )
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $bioRe3.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: bioRe3.resetFigure)
            }
        }
    }
    
    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return self.sisaList[0]
        case self.selectList[1]: return self.sisaList[0]
        case self.selectList[2]: return self.sisaList[1]
        case self.selectList[3]: return self.sisaList[1]
        case self.selectList[4]: return self.sisaList[2]
        case self.selectList[5]: return self.sisaList[2]
        case self.selectList[6]: return self.sisaList[3]
        case self.selectList[7]: return self.sisaList[3]
        case self.selectList[8]: return self.sisaList[4]
        case self.selectList[9]: return self.sisaList[4]
        case self.selectList[10]: return self.sisaList[5]
        case self.selectList[11]: return self.sisaList[5]
        case self.selectList[12]: return self.sisaList[6]
        case self.selectList[13]: return self.sisaList[7]
        case self.selectList[14]: return self.sisaList[8]
        case self.selectList[15]: return self.sisaList[9]
        default: return "???"
        }
    }
    
    private func bindingVoice(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $bioRe3.figureCountKisuJaku
        case self.selectList[1]: return $bioRe3.figureCountKisuJaku
        case self.selectList[2]: return $bioRe3.figureCountKisuKyo
        case self.selectList[3]: return $bioRe3.figureCountKisuKyo
        case self.selectList[4]: return $bioRe3.figureCountGusuJaku
        case self.selectList[5]: return $bioRe3.figureCountGusuJaku
        case self.selectList[6]: return $bioRe3.figureCountGusuKyo
        case self.selectList[7]: return $bioRe3.figureCountGusuKyo
        case self.selectList[8]: return $bioRe3.figureCountHighJaku
        case self.selectList[9]: return $bioRe3.figureCountHighJaku
        case self.selectList[10]: return $bioRe3.figureCountHighChu
        case self.selectList[11]: return $bioRe3.figureCountHighChu
        case self.selectList[12]: return $bioRe3.figureCountHighKyo
        case self.selectList[13]: return $bioRe3.figureCountOver2
        case self.selectList[14]: return $bioRe3.figureCountOver4With16
        case self.selectList[15]: return $bioRe3.figureCountOver4With15
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .gray
        case self.selectList[1]: return .gray
        case self.selectList[2]: return .gray
        case self.selectList[3]: return .gray
        case self.selectList[4]: return .blue
        case self.selectList[5]: return .blue
        case self.selectList[6]: return .blue
        case self.selectList[7]: return .blue
        case self.selectList[8]: return .red
        case self.selectList[9]: return .red
        case self.selectList[10]: return .red
        case self.selectList[11]: return .red
        case self.selectList[12]: return .purple
        case self.selectList[13]: return .purple
        case self.selectList[14]: return .purple
        case self.selectList[15]: return .purple
        default: return .gray
        }
    }
    
    private func bindingResult(text: String) -> Binding<Int> {
        switch text {
        case self.sisaList[0]: return $bioRe3.figureCountKisuJaku
        case self.sisaList[1]: return $bioRe3.figureCountKisuKyo
        case self.sisaList[2]: return $bioRe3.figureCountGusuJaku
        case self.sisaList[3]: return $bioRe3.figureCountGusuKyo
        case self.sisaList[4]: return $bioRe3.figureCountHighJaku
        case self.sisaList[5]: return $bioRe3.figureCountHighChu
        case self.sisaList[6]: return $bioRe3.figureCountHighKyo
        case self.sisaList[7]: return $bioRe3.figureCountOver2
        case self.sisaList[8]: return $bioRe3.figureCountOver4With16
        case self.sisaList[9]: return $bioRe3.figureCountOver4With15
        default: return .constant(0)
        }
    }
    
    private func flushColorResult(text: String) -> Color {
        switch text {
        case self.sisaList[0]: return .gray
        case self.sisaList[1]: return .gray
        case self.sisaList[2]: return .blue
        case self.sisaList[3]: return .blue
        case self.sisaList[4]: return .red
        case self.sisaList[5]: return .red
        case self.sisaList[6]: return .purple
        case self.sisaList[7]: return .purple
        case self.sisaList[8]: return .purple
        case self.sisaList[9]: return .purple
        default: return .gray
        }
    }
}

#Preview {
    bioRe3ViewFigure(
        bioRe3: BioRe3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}

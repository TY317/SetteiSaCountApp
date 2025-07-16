//
//  myJug5ViewBayseTest.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/13.
//

import SwiftUI
import GoogleMobileAds

struct myJug5ViewBayseTest: View {
//    private let viewModel = InterstitialViewModel()
    @StateObject var viewModel = InterstitialViewModel()
    let selectListGuess: [String] = [
        "デフォルト",
        "ｼﾞｬｸﾞﾗｰﾃﾞﾌｫﾙﾄ",
    ]
    @State var selectedGuess: String = "デフォルト"
    let guessDefault: [Double] = [72,21,2,3,1,1]
    let guessJugDefault: [Double] = [30,40,20,7,2,1]
    @State var budouEnable: Bool = true
    @State var regDetailEnable: Bool = true
    @State var calculateStart: Bool = false
    @State var isShowAlert: Bool = false
    var body: some View {
        List {
            // //// step1)設定配分
            Section {
                // パターン選択
                unitPickerMenuString(
                    title: "設定配分パターン",
                    selected: self.$selectedGuess,
                    selectlist: self.selectListGuess
                )
                // 配分表
                HStack(spacing: 0) {
                    let guessArray = choiceGuessArray(pattern: self.selectedGuess)
                    ForEach(guessArray.indices, id: \.self) { index in
                        unitTablePercent(
                            columTitle: "設定\(index+1)",
                            percentList: [guessArray[index]],
                            titleFont: .body,
                            colorList: [.white],
                        )
                    }
                }
            } header: {
                Text("STEP1) 設定配分予想")
            }
            
            // //// 判別要素の設定
            Section {
                DisclosureGroup("判別要素") {
                    Text("BIG確率")
                    Text("REG確率")
                    Toggle(isOn: self.$budouEnable) {
                        Text("ぶどう確率")
                            .foregroundStyle(self.budouEnable ? Color.primary : Color.secondary)
                    }
                    Toggle(isOn: self.$budouEnable) {
                        Text("REG当選契機も考慮")
                            .foregroundStyle(self.regDetailEnable ? Color.primary : Color.secondary)
                    }
                }
            } header: {
                Text("STEP2) 判別要素の設定")
            }
            
            // //// 計算
            Section {
//                Text("\(viewModel.isAdDismissed)")
                Button {
                    self.isShowAlert.toggle()
                } label: {
                    Text("計算START")
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .frame(maxWidth: .infinity, alignment: .center)
                .alert("計算START",
                       isPresented: self.$isShowAlert) {
                    Button("キャンセル", role: .cancel) {
                        
                    }
                    Button("OK", role: .destructive) {
                        viewModel.isAdDismissed = false
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        if viewModel.interstitialAd == nil {
                            
                        } else {
                            viewModel.showAd()
                        }
                    }
                } message: {
                    Text("計算を開始します\n計算中動画が流れます")
                }
                
            } header: {
                Text("STEP3) 判別計算")
            }
            .listRowBackground(Color.clear)
            
            // //// 計算結果
            if viewModel.isAdDismissed {
                Section {
                    Text("判別結果の表示")
                } header: {
                    Text("STEP4) 判別結果確認")
                }
            }
        }
        .onAppear {
            loadAdOnAppear()
        }
    }
    // //// 選択された配分パターンに合わせて配分値を選択する
    func choiceGuessArray(pattern: String) -> [Double] {
        switch pattern {
        case self.selectListGuess[0]: return self.guessDefault
        case self.selectListGuess[1]: return self.guessJugDefault
        default: return self.guessDefault
        }
    }
    
    func loadAdOnAppear() {
        Task {
            await viewModel.loadAd()
        }
    }
}


final class InterstitialViewModel: NSObject,ObservableObject,GADFullScreenContentDelegate {
    //    private var interstitialAd: GADInterstitialAd?
    var interstitialAd: GADInterstitialAd?
    
    @Published var isAdDismissed: Bool = false
    
    func loadAd() async {
        do {
            interstitialAd = try await GADInterstitialAd.load(
                withAdUnitID: "ca-app-pub-3940256099942544/4411468910",
                request: GADRequest()
            )
            // [START set_the_delegate]
            interstitialAd?.fullScreenContentDelegate = self
            // [END set_the_delegate]
        } catch {
            print("Failed to load interstitial ad with error: \(error.localizedDescription)")
        }
    }
    // [END load_ad]
    
    // [START show_ad]
    func showAd() {
        //        isAdDismissed = false
        guard let interstitialAd = interstitialAd else {
            return print("Ad wasn't ready.")
        }
        
        interstitialAd.present(fromRootViewController: nil)
    }
    // [END show_ad]
    
    // MARK: - GADFullScreenContentDelegate methods
    
    // [START ad_events]
    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func ad(
        _ ad: GADFullScreenPresentingAd,
        didFailToPresentFullScreenContentWithError error: Error
    ) {
        print("\(#function) called")
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
        // Clear the interstitial ad.
        interstitialAd = nil
        isAdDismissed = true
        Task {
            await loadAd() // 次回の広告表示の準備
        }
    }
    // [END ad_events]
    
    // 最後に追加
    deinit {
        print("❌ InterstitialViewModel deinitialized")
    }
}

#Preview {
    myJug5ViewBayseTest()
}

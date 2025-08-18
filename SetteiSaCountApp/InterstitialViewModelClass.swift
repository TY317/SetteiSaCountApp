//
//  InterstitialViewModelClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/10.
//

import Foundation
import SwiftUI
import GoogleMobileAds


final class InterstitialViewModel: NSObject,ObservableObject,GADFullScreenContentDelegate {
    //    private var interstitialAd: GADInterstitialAd?
    var interstitialAd: GADInterstitialAd?
    @Published var isAdDismissed: Bool = false   // 結果シート表示の発火用
    private var didHandleDismiss = false   // handleの二重呼び出し防止用
    
    func loadAd() async {
        do {
            interstitialAd = try await GADInterstitialAd.load(
//                withAdUnitID: "ca-app-pub-3940256099942544/4411468910",     // テスト用
                withAdUnitID: "ca-app-pub-2339669527176370/6732998451",     // 本番用
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
    
    // //// willDismissで発火の変更前
//    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//    
//    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("\(#function) called")
//        // Clear the interstitial ad.
//        interstitialAd = nil
//        isAdDismissed = true
//        Task {
//            await loadAd() // 次回の広告表示の準備
//        }
//    }
    // //// willDismissで発火の変更前
    
    // //// willDismissで発火の変更後
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
        handleAdDismiss()
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
        handleAdDismiss()
    }
    
    private func handleAdDismiss() {
        guard !didHandleDismiss else { return } // 二重実行防止
        didHandleDismiss = true
        
        interstitialAd = nil
        DispatchQueue.main.async {
            self.isAdDismissed = true
        }
        Task {
            await loadAd() // 次回の広告準備
            didHandleDismiss = false // 次回に備えてリセット
        }
    }
    // [END ad_events]
}

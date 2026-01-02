//
//  rewardViewModelClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/02.
//

import Foundation
import SwiftUI
import GoogleMobileAds

class RewardedViewModel: NSObject, ObservableObject, FullScreenContentDelegate {
    private var rewardedAd: RewardedAd?
    
    func loadAd() async {
        do {
            rewardedAd = try await RewardedAd.load(
                with: "ca-app-pub-3940256099942544/1712485313",   // テスト用
//                with: "ca-app-pub-2339669527176370/8540059247",  // 本番用
                request: Request()
            )
            // [START set_the_delegate]
            rewardedAd?.fullScreenContentDelegate = self
            // [END set_the_delegate]
        } catch {
            print("Failed to load rewarded ad with error: \(error.localizedDescription)")
        }
    }
    // [END load_ad]
    
    // [START show_ad]
    func showAd(onReward: @escaping () -> Void) {
        guard let rewardedAd = rewardedAd else {
            return print("Ad wasn't ready.")
        }
        
        rewardedAd.present(from: nil) {
            let reward = rewardedAd.adReward
            print("Reward amount: \(reward.amount)")
            onReward()
        }
    }
    // [END show_ad]
    
    // MARK: - GADFullScreenContentDelegate methods
    
    // [START ad_events]
    func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidRecordClick(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func ad(
        _ ad: FullScreenPresentingAd,
        didFailToPresentFullScreenContentWithError error: Error
    ) {
        print("\(#function) called")
    }
    
    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
        // Clear the rewarded ad.
        rewardedAd = nil
    }
    // [END ad_events]
}

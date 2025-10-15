//
//  bayesSubStep3Section.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/11.
//

import SwiftUI

struct bayesSubStep3Section: View {
    @ObservedObject var viewModel: InterstitialViewModel
    @State var isShowAlert: Bool = false
    @State private var isShowAdNotReadyAlert: Bool = false
    @State private var isFallbackCancelled: Bool = false
    @Environment(\.dismiss) private var dismiss
    let action: () -> Void
    var body: some View {
        Section {
            Button {
                self.isShowAlert.toggle()
            } label: {
                Text("計算START")
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .frame(maxWidth: .infinity, alignment: .center)
            .alert("計算START",isPresented: self.$isShowAlert) {
                Button("キャンセル", role: .cancel) {
                    
                }
                Button("OK", role: .destructive) {
                    viewModel.isAdDismissed = false
                    isFallbackCancelled = false
//                    UINotificationFeedbackGenerator().notificationOccurred(.success)
//                    viewModel.interstitialAd = nil
                    if viewModel.interstitialAd == nil {
                        isShowAdNotReadyAlert = true
                        // フォールバック: 広告が未準備でも3秒待機後に結果を表示
                        Task { @MainActor in
                            // キャンセルされていない場合のみ実行
                            guard !isFallbackCancelled else { return }
                            // 計算を先に実行
                            action()
                            // 3秒待機（待機中にキャンセルされた場合は中断）
                            try? await Task.sleep(nanoseconds: 3_000_000_000)
                            guard !isFallbackCancelled else { return }
                            // 結果表示を発火（広告なしなので自前でトリガー）
                            viewModel.isAdDismissed = true
                        }
                    } else {
                        viewModel.showAd()
                        action()
                    }
                }
            } message: {
                Text("計算中広告が流れることがあります")
            }
        } header: {
            Text("STEP3) 期待値計算")
        }
        .listRowBackground(Color.clear)
        .alert("計算中です・・", isPresented: self.$isShowAdNotReadyAlert) {
            Button("キャンセル", role: .cancel) {
                // フォールバックをキャンセルし、結果表示を行わない
                isFallbackCancelled = true
                isShowAdNotReadyAlert = false
            }
        } message: {
            Text("計算完了後に結果を表示します")
        }
    }
}

#Preview {
    List {
        bayesSubStep3Section(
            viewModel: InterstitialViewModel()
        ) {
            testFunc()
        }
    }
}


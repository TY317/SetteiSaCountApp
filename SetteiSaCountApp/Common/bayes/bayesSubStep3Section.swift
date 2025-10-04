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
//                    UINotificationFeedbackGenerator().notificationOccurred(.success)
//                    viewModel.interstitialAd = nil
                    if viewModel.interstitialAd == nil {
                        isShowAdNotReadyAlert = true
                    } else {
                        viewModel.showAd()
                        action()
                    }
                }
            } message: {
                Text("計算中広告が流れます")
            }
        } header: {
            Text("STEP3) 期待値計算")
        }
        .listRowBackground(Color.clear)
        .alert("広告の準備ができていません", isPresented: self.$isShowAdNotReadyAlert) {
            Button("前のページへ戻る") {
                dismiss()
            }
            Button("OK", role: .cancel) { }
        } message: {
            Text("前のページに戻ってから、再度このページを開いてください。")
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


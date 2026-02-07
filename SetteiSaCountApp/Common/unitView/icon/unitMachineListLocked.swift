//
//  unitMachineListLocked.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/02.
//

import SwiftUI

struct unitMachineListLocked: View {
    @State var iconImage: Image
    @State var machineName: String
    var machineNameFont: Font = .body
    @State var makerName: String
    @State var releaseYear: Int
    @State var releaseMonth: Int
    @Binding var isUnLocked: Bool
    var badgeStatus: String = "none"
    var btBadgeBool: Bool = false
    @State var isShowAlert: Bool = false
    @Binding var tempUnlockDateDouble: Double
    @EnvironmentObject var rewardViewModel: RewardedViewModel
    @State private var isShowAdNotReadyAlert: Bool = false
    
    var body: some View {
        Button {
            self.isShowAlert.toggle()
        } label: {
            HStack {
                unitLabelMachineListLink(
                    iconImage: self.iconImage,
                    machineName: self.machineName,
                    makerName: self.makerName,
                    releaseYear: self.releaseYear,
                    releaseMonth: self.releaseMonth,
                    badgeStatus: self.badgeStatus,
                    btBadgeBool: self.btBadgeBool,
                )
                Spacer()
                ZStack {
                    Image(systemName: "film")
                        .foregroundStyle(Color.primary)
                        .font(.largeTitle)
                    Circle()
                        .foregroundStyle(Color(UIColor.systemBackground))
                        .frame(width: 22, height: 22)
                    Image(systemName: "play.circle.fill")
                        .foregroundStyle(Color.red)
                        .font(.headline)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .alert("機種ページ解放", isPresented: self.$isShowAlert) {
            Button("キャンセル", role: .cancel) {
                
            }
            Button("広告で開放", role: .destructive) {
                rewardViewModel.showAd {
                    self.isShowAdNotReadyAlert = true
                } onReward: {
                    self.isUnLocked = true
                }
                
//                rewardViewModel.showAd(onReward: {
//                    self.isUnLocked = true
//                })
//                self.isUnLocked = true
            }
        } message: {
            Text("動画広告を1回視聴すると、機種ページが解放されます")
        }
        
//        .alert("広告を読み込めませんでした", isPresented: self.$isShowAdNotReadyAlert) {
//            Button("OK", role: .cancel) {
//                Task { await rewardViewModel.loadAd() }
//            }
//        } message: {
//            Text("電波の良い場所で再度お試しいただくか、しばらく待ってから再度お試しください")
//        }
        .alert("広告を読み込めませんでした", isPresented: self.$isShowAdNotReadyAlert) {
            Button("OK", role: .cancel) {
                // 1. 念のため次回の読み込みをトライ
                Task { await rewardViewModel.loadAd() }
            }
            Button("24時間解放", role: .destructive) {
                // 2. 24時間解放を開始
                self.tempUnlockDateDouble = Date().timeIntervalSince1970
                // 3. UIを更新するために必要ならフラグを立てる（または自動でisTempUnlockedにより表示が変わる）
            }
        } message: {
            Text("再度お試し頂くか、24時間だけ機能を解放しますので、その間にご利用ください。")
        }
    }
}

#Preview {
    @Previewable @State var isUnLocked = false
    @Previewable @State var tempUnlockDateDouble: Double = 0.0
    List {
        unitMachineListLocked(
            iconImage: Image("tekken6MachineIcon"),
            machineName: "ヱヴァンゲリオン〜約束の扉〜",
            makerName: "山佐",
            releaseYear: 2025,
            releaseMonth: 7,
            isUnLocked: $isUnLocked,
            badgeStatus: "new",
            btBadgeBool: true,
            tempUnlockDateDouble: $tempUnlockDateDouble,
        )
        .environmentObject(RewardedViewModel())
        if isUnLocked {
            Text("unLocked")
        } else {
            Text("locked")
        }
    }
}

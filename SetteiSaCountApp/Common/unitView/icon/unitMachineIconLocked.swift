//
//  unitMachineIconLocked.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/02.
//

import SwiftUI

struct unitMachineIconLocked: View {
    @State var iconImage: Image
    @State var machineName: String
    var badgeStatus: String = "none"
    var btBadgeBool: Bool = false
    @State var isShowAlert: Bool = false
    let lockImageFontSize: CGFloat = 30
    @Binding var isUnLocked: Bool
    @EnvironmentObject var rewardViewModel: RewardedViewModel
    @State private var isShowAdNotReadyAlert: Bool = false
    
    var body: some View {
        Button {
            self.isShowAlert.toggle()
        } label: {
            unitLabelMachineIconLink(
                iconImage: self.iconImage,
                machineName: self.machineName,
                badgeStatus: self.badgeStatus,
                btBadgeBool: self.btBadgeBool,
            )
            .overlay {
                ZStack {
                    Rectangle()
                        .frame(width: 38, height: 30)
                        .foregroundStyle(Color(UIColor.systemGroupedBackground))
                        .cornerRadius(4)
//                    Image(systemName: "play.rectangle.fill")
////                        .foregroundStyle(Color.red)
//                        .foregroundStyle(
//                                LinearGradient(
//                                    colors: [.red, .orange, .yellow, .green, .blue, .purple],
//                                    startPoint: .topLeading,
//                                    endPoint: .bottomTrailing
//                                )
//                            )
//                        .font(.system(size: self.lockImageFontSize))
//                        .fontWeight(.light)
                    Image(systemName: "film")
                        .foregroundStyle(Color.primary)
                        .font(.title)
                    Circle()
                        .foregroundStyle(Color(UIColor.systemGroupedBackground))
                        .frame(width: 18, height: 18)
                    Image(systemName: "play.circle.fill")
                        .foregroundStyle(Color.red)
                        .font(.callout)
                }
                .offset(x: -13, y: 11)
            }
        }
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
            }
        } message: {
            Text("動画広告を1回視聴すると、機種ページが解放されます")
        }
        
        .alert("広告を読み込めませんでした", isPresented: self.$isShowAdNotReadyAlert) {
            Button("OK", role: .cancel) {
                Task { await rewardViewModel.loadAd() }
            }
        } message: {
            Text("電波の良い場所で再度お試しいただくか、しばらく待ってから再度お試しください")
        }
    }
}

#Preview {
    @Previewable @State var isUnLocked = false
    unitMachineIconLocked(
        iconImage: Image("tekken6MachineIcon"),
        machineName: "鉄拳6",
        isUnLocked: $isUnLocked,
    )
    .frame(width: 70, height: 90)
    .environmentObject(RewardedViewModel())
    if isUnLocked {
        Text("unLocked")
    } else {
        Text("locked")
    }
}

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
    @EnvironmentObject var rewardViewModel: RewardedViewModel
    
    var body: some View {
        Button {
            self.isShowAlert.toggle()
        } label: {
            HStack {
                unitLabelMachineListLink(
                    iconImage: self.iconImage,
                    machineName: self.makerName,
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
                rewardViewModel.showAd(onReward: {
                    self.isUnLocked = true
                })
//                self.isUnLocked = true
            }
        } message: {
            Text("動画広告を1回視聴すると、機種ページが解放されます")
        }
    }
}

#Preview {
    @Previewable @State var isUnLocked = false
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
        )
        .environmentObject(RewardedViewModel())
        if isUnLocked {
            Text("unLocked")
        } else {
            Text("locked")
        }
    }
}

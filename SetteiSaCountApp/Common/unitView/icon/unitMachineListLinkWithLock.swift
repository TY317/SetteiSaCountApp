//
//  unitMachineListLinkWithLock.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/02.
//

import SwiftUI

struct unitMachineListLinkWithLock: View {
    @State var linkView: AnyView
    @State var iconImage: Image
    @State var machineName: String
    var machineNameFont: Font = .body
    @State var makerName: String
    @State var releaseYear: Int
    @State var releaseMonth: Int
    @Binding var isUnLocked: Bool
    @Binding var tempUnlockDateDouble: Double
    var badgeStatus: String = "none"
    var btBadgeBool: Bool = false
    @EnvironmentObject var rewardViewModel: RewardedViewModel
    
    var body: some View {
        let now = Date().timeIntervalSince1970
        if self.isUnLocked ||
            (now - tempUnlockDateDouble) < 86400 {
//            (now - tempUnlockDateDouble) < 60 {
            unitMachinListLink(
                linkView: self.linkView,
                iconImage: self.iconImage,
                machineName: self.machineName,
                makerName: self.makerName,
                releaseYear: self.releaseYear,
                releaseMonth: self.releaseMonth,
                badgeStatus: self.badgeStatus,
                btBadgeBool: self.btBadgeBool,
            )
        } else {
            unitMachineListLocked(
                iconImage: self.iconImage,
                machineName: self.machineName,
                makerName: self.makerName,
                releaseYear: self.releaseYear,
                releaseMonth: self.releaseMonth,
                isUnLocked: self.$isUnLocked,
                badgeStatus: self.badgeStatus,
                btBadgeBool: self.btBadgeBool,
                tempUnlockDateDouble: self.$tempUnlockDateDouble,
            )
        }
    }
}

#Preview {
    @Previewable @State var isUnLocked = false
    @Previewable @State var tempUnlockDateDouble: Double = 0.0
    unitMachineListLinkWithLock(
        linkView: AnyView(unitReelDefault()),
        iconImage: Image("tekken6MachineIcon"),
        machineName: "ヱヴァンゲリオン〜約束の扉〜",
        makerName: "ビスティ",
        releaseYear: 2025,
        releaseMonth: 7,
        isUnLocked: $isUnLocked,
        tempUnlockDateDouble: $tempUnlockDateDouble,
        badgeStatus: "new",
        btBadgeBool: true,
    )
    .environmentObject(RewardedViewModel())
}

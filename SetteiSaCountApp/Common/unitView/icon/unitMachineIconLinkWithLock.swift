//
//  unitMachineIconLinkWithLock.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/02.
//

import SwiftUI

struct unitMachineIconLinkWithLock: View {
    @State var linkView: AnyView
    @State var iconImage: Image
    @State var machineName: String
    @Binding var isUnLocked: Bool
    @Binding var tempUnlockDateDouble: Double
    var badgeStatus: String = "none"
    var btBadgeBool: Bool = false
    
    var body: some View {
        let now = Date().timeIntervalSince1970
        if self.isUnLocked ||
            (now - tempUnlockDateDouble) < 86400 {
//            (now - tempUnlockDateDouble) < 60 {
            unitMachineIconLink(
                linkView: self.linkView,
                iconImage: self.iconImage,
                machineName: self.machineName,
                badgeStatus: self.badgeStatus,
                btBadgeBool: self.btBadgeBool,
            )
        } else {
            unitMachineIconLocked(
                iconImage: self.iconImage,
                machineName: self.machineName,
                badgeStatus: self.badgeStatus,
                btBadgeBool: self.btBadgeBool,
                isUnLocked: self.$isUnLocked,
                tempUnlockDateDouble: self.$tempUnlockDateDouble,
            )
        }
    }
}

#Preview {
    @Previewable @State var isUnLocked = false
    @Previewable @State var tempUnlockDateDouble: Double = 0.0
    unitMachineIconLinkWithLock(
        linkView: AnyView(unitReelDefault()),
        iconImage: Image("tekken6MachineIcon"),
        machineName: "鉄拳6",
        isUnLocked: $isUnLocked,
        tempUnlockDateDouble: $tempUnlockDateDouble,
    )
    .frame(width: 70, height: 90)
}

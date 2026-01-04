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
    var badgeStatus: String = "none"
    var btBadgeBool: Bool = false
    
    var body: some View {
        if self.isUnLocked {
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
            )
        }
    }
}

#Preview {
    @Previewable @State var isUnLocked = false
    unitMachineIconLinkWithLock(
        linkView: AnyView(unitReelDefault()),
        iconImage: Image("tekken6MachineIcon"),
        machineName: "鉄拳6",
        isUnLocked: $isUnLocked,
    )
    .frame(width: 70, height: 90)
}

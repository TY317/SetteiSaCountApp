//
//  unitMachinListLink.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/14.
//

import SwiftUI

struct unitMachinListLink: View {
    @State var linkView: AnyView
    @State var iconImage: Image
    @State var machineName: String
    var machineNameFont: Font = .body
    @State var makerName: String
    @State var releaseYear: Int
    @State var releaseMonth: Int
    var badgeStatus: String = "none"
    var btBadgeBool: Bool = false
//    let newBadgeBgColor: Color = .yellow
//    let updateBadgeColor: Color = .red
    
    var body: some View {
        NavigationLink(destination: self.linkView) {
            unitLabelMachineListLink(
                iconImage: self.iconImage,
                machineName: self.machineName,
                makerName: self.makerName,
                releaseYear: self.releaseYear,
                releaseMonth: self.releaseMonth,
                badgeStatus: self.badgeStatus,
                btBadgeBool: self.btBadgeBool,
            )
            // //// ver3.10.0以降
//            HStack(spacing: 10.0) {
//                ZStack {
//                    // アイコン部分
//                    self.iconImage
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .overlay(alignment: .topLeading) {
//                            if self.btBadgeBool {
//                                unitIconBtTriangleShape()
//                                    .fill(Color.orange)
//                                    .frame(width: 25, height: 25)
//                                Text("BT")
//                                    .font(.caption)
//                                    .foregroundStyle(Color.white)
//                                    .fontWeight(.bold)
//                                    .rotationEffect(.degrees(-45))
//                                    .offset(x: -4, y: -4)
//                            }
//                        }
//                        .cornerRadius(10)   // ver3.5.0 iOS26に合わせて修正
//                        .padding(.trailing, 5.0)
//                        .overlay {
//                            // newバッジ部分
//                            if self.badgeStatus == "new" {
//                                ZStack {
//                                    Rectangle()
//                                        .foregroundStyle(Color(UIColor.secondarySystemGroupedBackground))
//                                        .cornerRadius(11.0)
//                                        .frame(width: 44.0, height: 24.0)
//                                    Rectangle()
//                                        .foregroundStyle(self.newBadgeBgColor)
//                                        .cornerRadius(10.0)
//                                        .frame(width: 40.0, height: 20.0)
//                                    Text("NEW")
//                                        .foregroundStyle(Color.blue)
//                                        .font(.caption)
//                                        .fontWeight(.bold)
//                                }
//                                .offset(x: 1.0, y: -12.0)
//                            }
//                            // updateバッジ部分
//                            else if self.badgeStatus == "update" {
//                                ZStack {
//                                    Circle()
//                                        .foregroundStyle(Color(UIColor.secondarySystemGroupedBackground))
//                                        .frame(width: 25.0, height: 25.0)
//                                    Circle()
//                                        .foregroundStyle(self.updateBadgeColor)
//                                        .frame(width: 20.0, height: 20.0)
//                                }
//                                .offset(x: 10.0, y: -12.0)
//                            }
//                        }
//                }
//                .frame(width: 45.0)
//                VStack(alignment: .leading) {
//                    Text(self.machineName)
//                        .font(self.machineNameFont)
//                    Text("\(self.makerName) , \(String(self.releaseYear))年 \(self.releaseMonth)月")
//                        .font(.caption)
//                        .foregroundStyle(Color.gray)
//                        .padding(.leading)
//                }
//            }
//            .padding(.vertical, -1.5)
        }
    }
}

#Preview {
    List {
        unitMachinListLink(
            linkView: AnyView(unitReelDefault()),
            iconImage: Image("tekken6MachineIcon"),
            machineName: "ヱヴァンゲリオン〜約束の扉〜",
            makerName: "ビスティ",
            releaseYear: 2025,
            releaseMonth: 7,
            badgeStatus: "new",
            btBadgeBool: true,
        )
    }
}

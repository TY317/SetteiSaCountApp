//
//  unitLabelMachineIconLink.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/02.
//

import SwiftUI

struct unitLabelMachineIconLink: View {
    var iconImage: Image
    var machineName: String
    var badgeStatus: String = "none"
    var btBadgeBool: Bool = false
    let newBadgeBgColor: Color = .yellow
    let updateBadgeColor: Color = .red
    
    var body: some View {
        ZStack {
            // アイコン本体部分
            VStack {
                self.iconImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(alignment: .topLeading) {
                        if self.btBadgeBool {
                            unitIconBtTriangleShape()
                                .fill(Color.orange)
                                .frame(width: 35, height: 35)
                            Text("BT")
                                .font(.subheadline)
                                .foregroundStyle(Color.white)
                                .fontWeight(.bold)
                                .rotationEffect(.degrees(-45))
                                .offset(x: -6, y: -6)
                        }
                    }
//                        .cornerRadius(13.0)
                    .cornerRadius(16.0)     // ver3.5.0 iOS26に合わせて修正
                    .padding(.horizontal, 4.0)
                    .padding(.top, 4.0)
                Text(self.machineName)
                    .font(.caption)
                    .lineLimit(1)
                    .foregroundStyle(Color.primary)
            }
            // newバッジ部分
            if self.badgeStatus == "new" {
                VStack {
                    HStack {
                        Spacer()
                        ZStack {
                            Rectangle()
                                .foregroundStyle(Color(UIColor.systemGroupedBackground))
                                .cornerRadius(11.25)
                                .frame(width: 45.0, height: 25.0)
                            Rectangle()
                                .foregroundStyle(self.newBadgeBgColor)
                                .cornerRadius(10.0)
                                .frame(width: 40.0, height: 20.0)
                            Text("NEW")
                                .font(.caption)
                                .fontWeight(.bold)
                        }
                    }
                    Spacer()
                }
            }
            // updateバッジ部分
            else if self.badgeStatus == "update" {
                VStack {
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .foregroundStyle(Color(UIColor.systemGroupedBackground))
                                .frame(width: 25.0, height: 25.0)
                            Circle()
                                .foregroundStyle(self.updateBadgeColor)
                                .frame(width: 20.0, height: 20.0)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    unitLabelMachineIconLink(
        iconImage: Image("tekken6MachineIcon"),
        machineName: "鉄拳6",
    )
    .frame(width: 70, height: 90)
}

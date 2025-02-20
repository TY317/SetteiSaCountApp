//
//  unitMachineIconLinkWithSfsymbol.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/15.
//

import SwiftUI

struct unitMachineIconLinkWithSfsymbol: View {
    @State var linkView: AnyView
    @State var iconImage: Image
    @State var machineName: String
    var badgeStatus: String = "none"
    var newBadgeBgColor: Color = .yellow
    var updateBadgeColor: Color = .red
    var sfSymbolName: String = ""
    var sfSymbolColor: Color = .gray
    var sfSymbolfont: Font = .largeTitle
    
    var body: some View {
        NavigationLink(destination: self.linkView) {
            ZStack {
                // アイコン本体部分
                VStack {
                    ZStack {
                        self.iconImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(13.0)
                            .padding(.horizontal, 4.0)
                            .padding(.top, 4.0)
                        // SFシンボルを上に重ねる
                        Image(systemName: self.sfSymbolName)
                            .foregroundStyle(self.sfSymbolColor)
                            .font(self.sfSymbolfont)
                    }
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
                            Circle()
                                .foregroundStyle(self.updateBadgeColor)
                                .frame(width: 20.0, height: 20.0)
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

//#Preview {
//    unitMachineIconLinkWithSfsymbol()
//}

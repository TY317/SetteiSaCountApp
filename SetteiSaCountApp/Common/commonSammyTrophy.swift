//
//  commonSammyTrophy.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/31.
//

import SwiftUI

struct commonViewSammyTrophy: View {
    @State var textBodyBeforeImage1: String?
    @State var textBodyBeforeImage2: String?
    @State var textBodyAfterImage1: String?
    @State var textBodyAfterImage2: String?
    @State var textColor: Color = .secondary
    
    var body: some View {
        List {
            if let textBodyBeforeImage1 = textBodyBeforeImage1 {
                Text(textBodyBeforeImage1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(self.textColor)
            }
            if let textBodyBeforeImage2 = textBodyBeforeImage2 {
                Text(textBodyBeforeImage2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(self.textColor)
            }
            Image("commonSammyTrophy")
                .resizable()
                .scaledToFit()
            if let textBodyAfterImage1 = textBodyAfterImage1 {
                Text(textBodyAfterImage1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(self.textColor)
            }
            if let textBodyAfterImage2 = textBodyAfterImage2 {
                Text(textBodyAfterImage2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(self.textColor)
            }
        }
        .navigationTitle("サミートロフィー")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    commonViewSammyTrophy()
}
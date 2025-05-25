//
//  unitButtonResetBorderedStyle.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import SwiftUI

struct unitButtonResetBorderedStyle: View {
    @Binding var isShowAlert: Bool
    var buttonText: String = "リセット"
    let action: () -> Void
    @State var message: String = "このデータをリセットします"
    
    var body: some View {
        Button {
            self.isShowAlert.toggle()
        } label: {
            Text(self.buttonText)
        }
        .buttonStyle(BorderedButtonStyle())
        .alert("データリセット", isPresented: self.$isShowAlert) {
            Button("キャンセル", role: .cancel) {
                
            }
            Button("リセット", role: .destructive) {
                action()
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            }
        } message: {
            Text(self.message)
        }
    }
}

#Preview {
    @Previewable @State var isShowAlert: Bool = true
    unitButtonResetBorderedStyle(
        isShowAlert: $isShowAlert,
        action: {
//            print("ボタンが押されました")
        }
    )
    
}

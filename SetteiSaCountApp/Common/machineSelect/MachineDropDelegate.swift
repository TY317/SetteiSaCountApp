//
//  MachineDropDelegate.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/21.
//

import Foundation
import SwiftUI

// 並び替えのロジックを管理するデリゲート
struct MachineDropDelegate: DropDelegate {
    let item: Machine
    @Binding var items: [Machine]
    @Binding var draggedItem: Machine?

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        self.draggedItem = nil
        return true
    }

    func dropEntered(info: DropInfo) {
        guard let draggedItem = draggedItem,
              draggedItem.id != item.id,
              let from = items.firstIndex(where: { $0.id == draggedItem.id }),
              let to = items.firstIndex(where: { $0.id == item.id }) else { return }

        if items[to].id != draggedItem.id {
            withAnimation {
                items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
            }
        }
    }
}

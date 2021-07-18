//
//  ItemsRepository.swift
//  Kadai16-MVVM
//
//  Created by akio0911 on 2021/07/19.
//

import Foundation

final class ItemsRepository {
    enum ItemName {
        static let apple = "りんご"
        static let orange = "みかん"
        static let banana = "バナナ"
        static let pineapple = "パイナップル"
    }

    private var items: [Item] = [
        Item(isChecked: false, name: ItemName.apple),
        Item(isChecked: true, name: ItemName.orange),
        Item(isChecked: false, name: ItemName.banana),
        Item(isChecked: true, name: ItemName.pineapple)
    ]

    func fetch() -> [Item] {
        items
    }

    func append(item: Item) {
        items.append(item)
    }

    func save(items: [Item]) {
        self.items = items
    }
}

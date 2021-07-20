//
//  ItemsRepository.swift
//  Kadai16-MVVM
//
//  Created by 今村京平 on 2021/07/20.
//

import Foundation

// 画面間で項目の状態を共有するため、ItemsRepositoryで項目の状態管理を行う
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

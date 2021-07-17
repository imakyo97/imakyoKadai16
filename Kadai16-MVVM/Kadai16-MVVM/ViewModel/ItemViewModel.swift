//
//  ItemViewModel.swift
//  Kadai16-MVVM
//
//  Created by 今村京平 on 2021/07/16.
//

import Foundation

final class ItemData: NSObject {
    let items: [Item]
    init(items: [Item]) {
        self.items = items
    }
}

final class ItemViewModel: NSObject {
    enum ItemName {
        static let apple = "りんご"
        static let orange = "みかん"
        static let banana = "バナナ"
        static let pineapple = "パイナップル"
    }

    private(set) var items: [Item] = [
        Item(isChecked: false, name: ItemName.apple),
        Item(isChecked: true, name: ItemName.orange),
        Item(isChecked: false, name: ItemName.banana),
        Item(isChecked: true, name: ItemName.pineapple)
    ]

    @objc dynamic private(set) lazy var itemData = ItemData(items: items)

    func addItem(name: String) {
        items.append(Item(isChecked: false, name: name))
        itemData = ItemData(items: items)
    }

    func toggleIsChecked(at index: Int) {
        items[index].isChecked.toggle()
        itemData = ItemData(items: items)
    }

    func editingName(at index: Int, name: String) {
        items[index].name = name
        itemData = ItemData(items: items)
    }
}

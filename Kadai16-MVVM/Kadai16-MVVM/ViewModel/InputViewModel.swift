//
//  InputViewModel.swift
//  Kadai16-MVVM
//
//  Created by akio0911 on 2021/07/19.
//

import Foundation

final class InputViewModel {
    private let repository: ItemsRepository

    // KVOを使用
    @objc dynamic private(set) lazy var itemData = ItemData(items: repository.fetch())

    init(repository: ItemsRepository) {
        self.repository = repository
    }

    // Mode.addの時、Itemを追加するメソッド
    func addItem(name: String) {
        repository.append(item: Item(isChecked: false, name: name))
        itemData = ItemData(items: repository.fetch())
    }

    // Mode.editの時、items.nameを変更するメソッド
    func editingName(at index: Int, name: String) {
        // index ではなく id ベースでなければ安全に更新できなさそうだが
        // ひとまず Repository 導入するだけの暫定的な対処

        var items = repository.fetch()
        items[index].name = name
        repository.save(items: items)
        itemData = ItemData(items: items)
    }
}

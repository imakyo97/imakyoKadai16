//
//  InputViewModel.swift
//  Kadai16-MVVM
//
//  Created by 今村京平 on 2021/07/20.
//

import Foundation

final class InputViewModel {

    private let repository: ItemsRepository
    private(set) lazy var itemData = ItemData(items: repository.fetch())

    init(repository: ItemsRepository) {
        self.repository = repository
    }

    // 項目の状態操作は repository に委譲します
    func addItem(name: String) {
        repository.append(item: Item(isChecked: false, name: name))
    }

    // 項目の状態操作は repository に委譲します
    func editingName(at index: Int, name: String) {
        // index ではなく id ベースでなければ安全に更新できなさそうだが
        // ひとまず Repository 導入するだけの暫定的な対処

        var items = repository.fetch()
        items[index].name = name
        repository.save(items: items)
    }
}

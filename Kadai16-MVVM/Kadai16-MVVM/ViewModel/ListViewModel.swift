//
//  ListViewModel.swift
//  Kadai16-MVVM
//
//  Created by 今村京平 on 2021/07/20.
//

import Foundation

final class ItemData: NSObject {
    let items: [Item]
    init(items: [Item]) {
        self.items = items
    }
}

// 画面間で ViewModel を使いまわさず、画面ごとに ViewModel を用意します
final class ListViewModel: NSObject {

    let repository: ItemsRepository

    @objc dynamic private(set) lazy var itemData = ItemData(items: repository.fetch())

    init(repository: ItemsRepository) {
        self.repository = repository
    }

    func toggleIsChecked(at index: Int) {
        // index ではなく id ベースでなければ安全に更新できなさそうだが
        // ひとまず Repository 導入するだけの暫定的な対処

        var items = repository.fetch()
        items[index].isChecked.toggle()
        repository.save(items: items)
        itemData = ItemData(items: items)
    }

    func reload() {
        itemData = ItemData(items: repository.fetch())
    }
}

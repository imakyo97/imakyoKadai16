//
//  ItemTableViewCell.swift
//  Kadai16
//
//  Created by 今村京平 on 2021/07/07.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {

    @IBOutlet private weak var checkImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    private let checkMarkImageName = "CheckMark"

    func configure(item: Item) {
        nameLabel.text = item.name
        checkImageView.image =
            item.isChecked ? UIImage(named: checkMarkImageName) : nil
    }
}

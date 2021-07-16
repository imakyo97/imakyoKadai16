//
//  ItemTableViewCell.swift
//  Kadai16-MVVM
//
//  Created by 今村京平 on 2021/07/16.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {

    @IBOutlet private weak var checkImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(item: Item) {
        checkImageView.image =
            item.isChecked ? UIImage(named: "CheckImage") : nil
        nameLabel.text = item.name
    }
}

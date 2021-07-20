//
//  ExtensionUITableViewCell.swift
//  Kadai16
//
//  Created by 今村京平 on 2021/07/07.
//

import UIKit

extension UITableViewCell {
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    static var identifier: String { String(describing: self) }
}

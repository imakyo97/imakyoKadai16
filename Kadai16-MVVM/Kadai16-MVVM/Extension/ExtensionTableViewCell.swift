//
//  ExtensionTableViewCell.swift
//  Kadai16-MVVM
//
//  Created by 今村京平 on 2021/07/16.
//

import UIKit

extension UITableViewCell {
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    static var identifire: String { String(describing: self) }
}

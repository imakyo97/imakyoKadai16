//
//  ViewController.swift
//  Kadai16
//
//  Created by 今村京平 on 2021/07/07.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var itemTableView: UITableView!

    private enum FruitsName {
        static let apple = "りんご"
        static let orange = "みかん"
        static let banana = "バナナ"
        static let pineapple = "パイナップル"
    }

    private var items: [Item] = [
        Item(name: FruitsName.apple, isChecked: false),
        Item(name: FruitsName.orange, isChecked: true),
        Item(name: FruitsName.banana, isChecked: false),
        Item(name: FruitsName.pineapple, isChecked: true)
    ]

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView()
    }

    private func settingTableView() {
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.register(ItemTableViewCell.nib,
                               forCellReuseIdentifier: ItemTableViewCell.identifier)
    }

    // MARK: - @IBAction
    @IBAction private func tappedAddBtn(_ sender: Any) {
        present(
            UINavigationController(
                rootViewController: InputViewController
                    .instantiate(mode: .add,
                                 name: "",
                                 saveText: { [weak self] in
                                    self?.items.append(Item(name: $0, isChecked: false))
                                    self?.itemTableView.reloadData()
                                 }
                    )
            ),
            animated: true,
            completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].isChecked.toggle()
        itemTableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        present(
            UINavigationController(
                rootViewController: InputViewController.instantiate(
                    mode: .edit,
                    name: items[indexPath.row].name,
                    saveText: { [weak self] in
                        self?.items[indexPath.row].name = $0
                        self?.itemTableView.reloadData()
                    })
                ),
                animated: true,
                completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemTableViewCell.identifier)
            as! ItemTableViewCell // swiftlint:disable:this force_cast
        cell.configure(item: items[indexPath.row])
        return cell
    }
}

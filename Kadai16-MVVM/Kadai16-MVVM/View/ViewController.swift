//
//  ViewController.swift
//  Kadai16-MVVM
//
//  Created by 今村京平 on 2021/07/16.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var itemTableView: UITableView!
    private let itemViewModel = ItemViewModel()

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView()
    }

    private func settingTableView() {
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.register(ItemTableViewCell.nib,
                               forCellReuseIdentifier: ItemTableViewCell.identifire)
    }

    // MARK: - ViewWillApper
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemTableView.reloadData()
        print(itemViewModel.items)
    }

    // MARK: - @IBAction
    @IBAction private func tappedAddBtn(_ sender: Any) {
        let inputViewController = UINavigationController(
            rootViewController: InputViewController
                .instantiate(itemViewModel: itemViewModel, mode: .add, editingIndex: nil)
        )
        inputViewController.modalPresentationStyle =
            .fullScreen // viewWillAppearを呼び出すためにfullScreenに変更
        present(inputViewController, animated: true, completion: nil)
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemViewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifire)
            as! ItemTableViewCell // swiftlint:disable:this force_cast
        cell.configure(item: itemViewModel.items[indexPath.row])
        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemViewModel.toggleIsChecked(at: indexPath.row)
        itemTableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let inputViewController = UINavigationController(
            rootViewController: InputViewController
                .instantiate(itemViewModel: itemViewModel, mode: .edit, editingIndex: indexPath.row)
        )
        inputViewController.modalPresentationStyle =
            .fullScreen // viewWillAppearを呼び出すためにfullScreenに変更
        present(inputViewController, animated: true, completion: nil)
    }
}


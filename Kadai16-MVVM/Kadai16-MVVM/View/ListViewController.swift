//
//  ListViewController.swift
//  Kadai16-MVVM
//
//  Created by 今村京平 on 2021/07/16.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var itemTableView: UITableView!
    // ItemsRepository のインスタンスを1つだけ生成し、ここに項目の状態管理を集約します
    private let repository = ItemsRepository()
    private var viewModel: ListViewModel!
    private var disposeBag = Set<NSKeyValueObservation>() // KVO使用

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // ListViewModel 生成時に repository を注入します
        viewModel = ListViewModel(repository: repository)
        settingTableView()
        setupBindings()
    }

    private func settingTableView() {
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.register(ItemTableViewCell.nib,
                               forCellReuseIdentifier: ItemTableViewCell.identifire)
    }

    // KVOを使用
    private func setupBindings() {
        disposeBag.insert(
            viewModel.observe(\ListViewModel.itemData,
                                  options: [.initial, .new],
                                  changeHandler: { [weak self] _, _ in
                                    self?.itemTableView.reloadData()
                                  })
        )
    }

    // MARK: - @IBAction
    @IBAction private func tappedAddBtn(_ sender: Any) {
        // navigationControllerで遷移
        // InputViewController 生成時に InputViewModel と repository を注入します
        let inputViewController = InputViewController
            .instantiate(viewModel: InputViewModel(repository: repository),
                         mode: .add,
                         editingIndex: nil)
        inputViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: inputViewController)
        present(navigationController, animated: true, completion: nil)
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemData.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifire)
            as! ItemTableViewCell // swiftlint:disable:this force_cast
        cell.configure(item: viewModel.itemData.items[indexPath.row])
        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.toggleIsChecked(at: indexPath.row)
//        itemTableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // navigationControllerで遷移
        let inputViewController = InputViewController
                .instantiate(viewModel: InputViewModel(repository: repository),
                             mode: .edit,
                             editingIndex: indexPath.row)
        inputViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: inputViewController)
        present(navigationController, animated: true, completion: nil)
    }
}

extension ListViewController: InputViewControllerDelegate {
    func didSave() {
        viewModel.reload()
    }
}

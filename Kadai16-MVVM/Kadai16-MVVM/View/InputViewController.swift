//
//  InputViewController.swift
//  Kadai16-MVVM
//
//  Created by 今村京平 on 2021/07/16.
//

import UIKit

final class InputViewController: UIViewController {

    // モードで追加と編集を分ける
    enum Mode {
        case add
        case edit
    }

    // instantiateInitialViewController(creator:)を使用
    static func instantiate(itemViewModel: ItemViewModel, mode: Mode, editingIndex: Int?)
    -> InputViewController {
        let storyBoard = UIStoryboard(name: "Input", bundle: nil)
        let inputViewController =
            storyBoard.instantiateInitialViewController(creator: { coder in
                InputViewController(coder: coder,
                                    itemViewModel: itemViewModel,
                                    mode: mode,
                                    editingIndex: editingIndex)
            })!
        return inputViewController
    }

    @IBOutlet private weak var nameTextField: UITextField!
    private let itemViewModel: ItemViewModel
    private let mode: Mode // modeをプロパティで保持
    // tableViewのaccessoryで遷移した場合に選択されたIndex.rowを保持
    private let editingIndex: Int?
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // editingIndexがnilでない場合、itemsのnameをtextField.textに代入
        if let index = editingIndex {
            nameTextField.text = itemViewModel.itemData.items[index].name
        }
    }

    init?(coder: NSCoder, itemViewModel: ItemViewModel, mode: Mode, editingIndex: Int?) {
        self.itemViewModel = itemViewModel
        self.mode = mode
        self.editingIndex = editingIndex
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - @IBAction
    @IBAction private func tappedSave(_ sender: Any) {
        guard nameTextField.text != "" else {
            presentNotInputAlert()
            return
        }
        switch mode {
        case .add:
            itemViewModel.addItem(name: nameTextField.text!)
        case .edit:
            itemViewModel.editingName(at: editingIndex!, name: nameTextField.text!)
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func tappedCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    private func presentNotInputAlert() {
        let alert = UIAlertController(
            title: "名前が未入力です",
            message: "名前を入力して下さい",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil)
        )
        present(alert, animated: true, completion: nil)
    }
}

//
//  InputViewController.swift
//  Kadai16-MVVM
//
//  Created by 今村京平 on 2021/07/16.
//

import UIKit

protocol InputViewControllerDelegate: AnyObject {
    func didSave()
    func didCancel()
}

final class InputViewController: UIViewController {

    // モードで追加と編集を分ける
    enum Mode {
        case add
        case edit
    }

    weak var delegate: InputViewControllerDelegate?

    // instantiateInitialViewController(creator:)を使用
    static func instantiate(viewModel: InputViewModel, mode: Mode, editingIndex: Int?)
    -> InputViewController {
        let storyBoard = UIStoryboard(name: "Input", bundle: nil)
        let inputViewController =
            storyBoard.instantiateInitialViewController(creator: { coder in
                InputViewController(coder: coder,
                                    viewModel: viewModel,
                                    mode: mode,
                                    editingIndex: editingIndex)
            })!
        return inputViewController
    }

    @IBOutlet private weak var nameTextField: UITextField!
    private let viewModel: InputViewModel
    private let mode: Mode // modeをプロパティで保持
    // tableViewのaccessoryで遷移した場合に選択されたIndex.rowを保持
    private let editingIndex: Int?

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // editingIndexがnilでない場合、itemsのnameをtextField.textに代入
        if let index = editingIndex {
            nameTextField.text = viewModel.itemData.items[index].name
        }
    }

    init?(coder: NSCoder, viewModel: InputViewModel, mode: Mode, editingIndex: Int?) {
        self.viewModel = viewModel
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
            viewModel.addItem(name: nameTextField.text!)
        case .edit:
            viewModel.editingName(at: editingIndex!, name: nameTextField.text!)
        }
        dismiss(animated: true, completion: nil)
        delegate?.didSave()
    }

    @IBAction private func tappedCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.didCancel()
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

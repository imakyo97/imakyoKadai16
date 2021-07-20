//
//  InputViewController.swift
//  Kadai16
//
//  Created by 今村京平 on 2021/07/07.
//

import UIKit

final class InputViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!

    enum Mode {
        case add
        case edit
    }

    private let mode: Mode
    private let name: String
    private let saveText: (String) -> Void

    static func instantiate(mode: Mode,
                            name: String,
                            saveText: @escaping (String) -> Void)
    -> InputViewController {
        let storyBoard = UIStoryboard(name: "Input",
                                      bundle: nil)
        let inputViewController =
            storyBoard.instantiateInitialViewController { coder in
                InputViewController(coder: coder,
                                    mode: mode,
                                    name: name,
                                    saveText: saveText)
            }!
        return inputViewController
    }

    init?(coder: NSCoder,
          mode: Mode,
          name: String,
          saveText: @escaping (String) -> Void) {
        self.saveText = saveText
        self.mode = mode
        self.name = name
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = name
    }

    // MARK: - @IBAction
    @IBAction private func tappedCancelBtn(_ sender: Any) {
        dismiss(animated: true,
                completion: nil)
    }

    @IBAction private func tappedSaveBtn(_ sender: Any) {
        guard nameTextField.text != "" else {
            presentNotInputAlert()
            return
        }
        saveText(nameTextField.text!)
        dismiss(animated: true,
                completion: nil)
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

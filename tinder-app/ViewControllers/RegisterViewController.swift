//
//  RegisterViewController.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // ユーザー名
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "名前"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 15)
        return textField
    }()
    
    // メールアドレス
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "メールアドレス"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 15)
        return textField
    }()
    
    // パスワード
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "パスワード"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 15)
        return textField
    }()
    
    // 登録ボタン
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("登録", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        let baseHorizontalStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        baseHorizontalStackView.axis = .vertical
        baseHorizontalStackView.distribution = .fillEqually   // 要素の大きさを均等にする
        baseHorizontalStackView.spacing = 20
        
        view.addSubview(baseHorizontalStackView)
        
        nameTextField.anchor(height: 40)   // 1つの高さを指定すると他の大きさも同じ高さになる
        baseHorizontalStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        
    }
}

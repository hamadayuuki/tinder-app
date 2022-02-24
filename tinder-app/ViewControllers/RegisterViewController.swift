//
//  RegisterViewController.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let titleLabel = RegisterTitleLabel()   // タイトル "Tinder"
    let nameTextField = RegisterTextField(placeHolder: "名前")   // ユーザー名
    let emailTextField = RegisterTextField(placeHolder: "メールアドレス")   // メールアドレス
    let passwordTextField = RegisterTextField(placeHolder: "パスワード")   // パスワード
    
    let registerButton = RegisterButton(title: "登録")   // 登録ボタン
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientLayout()   // 他の要素よりも早く描画させる
        setLayout()
    }
    
    // グラデーション の描画
    private func setGradientLayout() {
        let gradientLayer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.locations = [0.0, 1.3]
        gradientLayer.frame = self.view.frame
        view.layer.addSublayer(gradientLayer)
    }
    
    private func setLayout() {
        view.backgroundColor = .yellow
        
        let baseHorizontalStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        baseHorizontalStackView.axis = .vertical
        baseHorizontalStackView.distribution = .fillEqually   // 要素の大きさを均等にする
        baseHorizontalStackView.spacing = 20
        
        view.addSubview(baseHorizontalStackView)
        view.addSubview(titleLabel)
        
        nameTextField.anchor(height: 40)   // 1つの高さを指定すると他の大きさも同じ高さになる
        baseHorizontalStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseHorizontalStackView.topAnchor, centerX: baseHorizontalStackView.centerXAnchor, bottomPadding: 10)
    }
}

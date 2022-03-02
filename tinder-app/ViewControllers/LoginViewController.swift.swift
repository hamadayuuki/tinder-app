//
//  LoginViewController.swift.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/03/02.
//

import UIKit
import RxSwift
import FirebaseAuth
import PKHUD

class LoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    // MARK: UIView
    let titleLabel = RegisterTitleLabel(title: "Login")   // タイトル "Login"
    let emailTextField = RegisterTextField(placeHolder: "メールアドレス")
    let passwordTextField = RegisterTextField(placeHolder: "パスワード")
    
    let loginButton = RegisterLoginButton(text: "ログイン")
    
    let dontHaveAccountButton = RegisterLoginButton(text: "アカウントをお持ちでない方はこちら")
    
    override func viewDidLoad() {
        setGradientLayout()
        setLayout()
        setupBinding()
        
    }
    
    // viewDidLoadの次, 画面描画開始前に呼び出される
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false   // ナビゲーションバーを表示する
    }
    
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
        
        let baseHorizontalStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        baseHorizontalStackView.axis = .vertical
        baseHorizontalStackView.distribution = .fillEqually   // 要素の大きさを均等にする
        baseHorizontalStackView.spacing = 20
        
        view.addSubview(baseHorizontalStackView)
        view.addSubview(titleLabel)
        view.addSubview(dontHaveAccountButton)
        
        emailTextField.anchor(height: 40)   // 1つの高さを指定すると他の大きさも同じ高さになる
        baseHorizontalStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseHorizontalStackView.topAnchor, centerX: baseHorizontalStackView.centerXAnchor, bottomPadding: 10)
        dontHaveAccountButton.anchor(top: baseHorizontalStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 30)
    }
    
    private func setupBinding() {
        
        // Button の Binding
        loginButton.rx.tap
            .asDriver()
            .drive { [weak self] text in
                print("ログインボタンが押されました")
                self?.loginWithFireAuth()
            }
            .disposed(by: disposeBag)
        
        dontHaveAccountButton.rx.tap
            .asDriver()
            .drive { [weak self] text in
                print("アカウント非所持ボタンが押されました")
                self?.navigationController?.popViewController(animated: true)   // 画面遷移元の画面に戻る
            }
            .disposed(by: disposeBag)
        
    }
    
    private func loginWithFireAuth() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        HUD.show(.progress)
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("ログイン認証に失敗しました")
                print("err: ", err)
                print("email: ", email)
                print("password: ", password)
                return
            }
            
            print("ログイン認証に成功しました")
            HUD.hide()
            self.dismiss(animated: true)   // ホーム画面へ遷移
        }
    }
}

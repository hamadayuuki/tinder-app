//
//  RegisterViewController.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/22.
//

import UIKit
import RxSwift
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let registerViewModel = RegisterViewModel()
    
    // MARK: UIView
    let titleLabel = RegisterTitleLabel(title: "Tinder")   // タイトル "Tinder"
    let nameTextField = RegisterTextField(placeHolder: "名前")   // ユーザー名
    let emailTextField = RegisterTextField(placeHolder: "メールアドレス")   // メールアドレス
    let passwordTextField = RegisterTextField(placeHolder: "パスワード")   // パスワード
    
    let registerButton = RegisterButton(title: "登録")   // 登録ボタン
    
    let loginButton = RegisterLoginButton(text: "既にアカウントをお持ちの方はこちら")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientLayout()   // 他の要素よりも早く描画させる
        setLayout()
        setupBindings()
    }
    
    // viewDidLoadの次, 画面描画開始前に呼び出される
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true   // ナビゲーションバーを隠す
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
        view.addSubview(loginButton)
        
        nameTextField.anchor(height: 40)   // 1つの高さを指定すると他の大きさも同じ高さになる
        baseHorizontalStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseHorizontalStackView.topAnchor, centerX: baseHorizontalStackView.centerXAnchor, bottomPadding: 10)
        loginButton.anchor(top: baseHorizontalStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 30)
    }
    
    // 非同期処理, データの変更があると ViewModel に通知する
    private func setupBindings() {
        
        // textField の Binding
        nameTextField.rx.text
            .asDriver()
            // [weak self]: 循環参照を避ける
            .drive { [weak self] text in
                self?.registerViewModel.nameTextInput.onNext(text ?? "")   // 通知する
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.registerViewModel.emailTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.registerViewModel.passwordTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)
        
        // Button の Binding
        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] text in
                self?.createUser()
            }
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .asDriver()
            .drive { [weak self] text in
                print("ログインボタンが押されました")
                // 画面遷移, HomeViewController で UINavigationViewController の設定を行う必要あり
                let loginViewController = LoginViewController()
                self?.navigationController?.pushViewController(loginViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        // viewModel の Binding
        registerViewModel.validRegisterDriver
            .drive { validAll in
                print("validAll: ", validAll)
                self.registerButton.isEnabled = validAll
                self.registerButton.backgroundColor = validAll ? .rgb(red: 227, green: 48, blue: 78) : .init(white: 0.7, alpha: 1)
            }
            .disposed(by: disposeBag)
    }
    
    private func createUser() {
        let email = emailTextField.text
        let name = nameTextField.text
        let password = passwordTextField.text
        
        Auth.createUserToFireAuth(email: email, name: name, password: password) { success in
            if success {
                print("ユーザー情報の登録完了")
                self.dismiss(animated: true)   // 登録完了後、ホーム画面へ遷移
            } else {
                print("ユーザー情報登録時にエラー発生")
            }
        }
    }
}

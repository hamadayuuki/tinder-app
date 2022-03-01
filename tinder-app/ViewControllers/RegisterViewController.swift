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
    
    let titleLabel = RegisterTitleLabel()   // タイトル "Tinder"
    let nameTextField = RegisterTextField(placeHolder: "名前")   // ユーザー名
    let emailTextField = RegisterTextField(placeHolder: "メールアドレス")   // メールアドレス
    let passwordTextField = RegisterTextField(placeHolder: "パスワード")   // パスワード
    
    let registerButton = RegisterButton(title: "登録")   // 登録ボタン
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientLayout()   // 他の要素よりも早く描画させる
        setLayout()
        setupBindings()
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
        
        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] text in
                self?.createUserToFireAuth()
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
    
    // 登録処理
    private func createUserToFireAuth() {
        // nilチェック
        guard let email = emailTextField.text else { return }
        guard let name = nameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        // 登録
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if let err = err {
                print("登録失敗: ", err)
            }
            
            guard let uid = auth?.user.uid else { return }
            print("登録成功: ", uid)
            self.setupUserDataToFireStore(email: email, uid: uid)
        }
    }
    
    private func setupUserDataToFireStore(email: String, uid: String) {
        guard let name = nameTextField.text else { return }
        
        let document = [
            "name": name,
            "email": email,
            "createAt": Timestamp()
        ] as [String : Any]
        
        Firestore.firestore().collection("user").document(uid).setData(document) { err in
            if let err = err {
                print("FireStoreへの登録に失敗: ", err)
                return
            }
            
            print("FireStoreへの登録に成功")
        }
    }
}

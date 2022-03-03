//
//  ViewController.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/18.
//

// 登録画面へ遷移
/*
 【流れ】
 アプリ起動 → (ログイン済みか？) → ○: ホーム画面, ホーム画面を元として画面遷移を実行する
                         → ×: 登録画面
 */

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class HomeViewController: UIViewController {

    private var user: User?   // FireStoreから取得したデータを保持するモデル
    private var otherUsers: [User] = [User]()
    
    // 3画面の描画, 外部クラスからも参照できるよう、ここに設置
    let topView = TopView()   // 上画面
    let centerView = UIView()   // 中央画面
    let bottomView = BottomView()   // 下画面
    
    // アプリ起動後(loadViewの次)実行
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
    }
    
    // MARK: Life Cycle Methods
    // 画面描画前
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // uid を使用して FireStore からデータを取得
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.feathUserFromFirestore(uid: uid) { user in
            if let user = user {
                self.user = user
            }
        }
        
        featchOtherUsers()
    }
    
    // 画面描画後
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ログインしていない時
        if Auth.auth().currentUser?.uid == nil {
            // 登録画面へ遷移
            let registerViewController = RegisterViewController()
            let navigationView = UINavigationController(rootViewController: registerViewController)   // 画面遷移"先"の画面遷移を可能にする
            navigationView.modalPresentationStyle = .fullScreen   // 全画面表示, デフォルトは画面上までのモーダル
            self.present(navigationView, animated: true)   // 画面遷移
        }
    }
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ログアウト", for: .normal)
        return button
    }()
    
    // 全てのユーザー情報を取得
    private func featchOtherUsers() {
        HUD.show(.progress)
        Firestore.featchOtherUsersFromFirestore { otherUsers in
            HUD.hide()
            self.otherUsers = otherUsers ?? [User]()
            print("otherUsers: ", self.otherUsers)
            
            // 全ユーザーのカードを作成
            otherUsers?.forEach({ otherUser in
                let cardView = CenterView(user: otherUser)
                self.centerView.addSubview(cardView)   // 重ねて描画することでカードが待機しているように見せている
                cardView.anchor(top: self.centerView.topAnchor, bottom: self.centerView.bottomAnchor, left: self.centerView.leftAnchor, right: self.centerView.rightAnchor)
            })
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        // 画面を並べる
        let stackView = UIStackView(arrangedSubviews: [topView, centerView, bottomView])
        stackView.translatesAutoresizingMaskIntoConstraints = false   //  Auto Layout以前に使われていた、Autosizingのレイアウトの仕組みをAuto Layoutに変換するかどうかを設定するフラグ
        // 3画面を均等に配置する
        stackView.axis = .vertical
        
        self.view.addSubview(stackView)   // Viewを描画
        self.view.addSubview(logoutButton)
        
        // view の大きさや位置を指定
        [
            // 上下の画面の高さを指定
            topView.heightAnchor.constraint(equalToConstant: 100),
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            
            // 上下左右の余白を無しにする, safeArea の領域を考慮して配置
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ]
            .forEach { $0.isActive = true }
        
        logoutButton.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, bottomPadding: 10, leftPadding: 10)
        logoutButton.addTarget(self, action: #selector(tapLogoutButton), for: .touchUpInside)   // RxSwift を使用しないボタンタップ
    }
    
    // ログアウトボタンを押したとき実行
    @objc private func tapLogoutButton() {
        do {
            try Auth.auth().signOut()
            // 登録画面へ遷移
            let registerViewController = RegisterViewController()
            let navigationView = UINavigationController(rootViewController: registerViewController)   // 画面遷移"先"の画面遷移を可能にする
            navigationView.modalPresentationStyle = .fullScreen   // 全画面表示, デフォルトは画面上までのモーダル
            self.present(navigationView, animated: true)   // 画面遷移
        } catch {
            print("ログアウト失敗: ", error)
        }
    }


}


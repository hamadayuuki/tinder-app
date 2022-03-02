//
//  ViewController.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/18.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        // 登録画面へ遷移, 0.5秒後 → 間隔を空けないと画面遷移がうまくいかないから
        /*
         【流れ】
         アプリ起動 → (登録済みか？) → ○: ホーム画面, ホーム画面を元として画面遷移を実行する
                                 → ×: 登録画面
         */
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let registerViewController = RegisterViewController()
            let navigationView = UINavigationController(rootViewController: registerViewController)   // 画面遷移"先"の画面遷移を可能にする
            navigationView.modalPresentationStyle = .fullScreen   // 全画面表示, デフォルトは画面上までのモーダル
            self.present(navigationView, animated: true)   // 画面遷移
        }
        
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        // 3画面の描画
        // 上画面
        let topView = TopView()
        
        // 中央画面
        let centerView = CenterView()
        
        // 下画面
        let bottomView = BottomView()
        
        // 画面を並べる
        let stackView = UIStackView(arrangedSubviews: [topView, centerView, bottomView])
        stackView.translatesAutoresizingMaskIntoConstraints = false   //  Auto Layout以前に使われていた、Autosizingのレイアウトの仕組みをAuto Layoutに変換するかどうかを設定するフラグ
        // 3画面を均等に配置する
        stackView.axis = .vertical
        
        self.view.addSubview(stackView)   // Viewを描画
        
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
    }


}


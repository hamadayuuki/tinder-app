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
        
        view.backgroundColor = .white
        
        // 3画面の描画
        // 上画面
        let topView = UIView()
        topView.backgroundColor = .yellow
        // 中央画面
        let centerView = UIView()
        centerView.backgroundColor = .blue
        // 下画面
        let bottomView = BottomView()
        
        // 画面を並べる
        let stackView = UIStackView(arrangedSubviews: [topView, centerView, bottomView])
        stackView.translatesAutoresizingMaskIntoConstraints = false   // 配置を自動で調整する
        // 3画面を均等に配置する
        stackView.axis = .vertical
        
        self.view.addSubview(stackView)   // 作成したViewを描画
        
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


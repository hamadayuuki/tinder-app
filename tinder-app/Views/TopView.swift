//
//  TopView.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/20.
//

import UIKit

// ホーム画面上 の画面
class TopView: UIView {
    
    let tinderButton = createToButton(imageName: "tinder-select")
    let goodButton = createToButton(imageName: "good-select")
    let commentButton = createToButton(imageName: "comment-select")
    let profileButton = createToButton(imageName: "profile-select")
    
    static private func createToButton(imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let baseHorizonStackView = UIStackView(arrangedSubviews: [tinderButton, goodButton, commentButton, profileButton])
        baseHorizonStackView.axis = .horizontal
        baseHorizonStackView.distribution = .fillEqually
        baseHorizonStackView.spacing = 43
        baseHorizonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(baseHorizonStackView)
        
        // view の大きさや位置を指定
        [
            // 上下左右の余白を無しにする, safeArea の領域を考慮して配置
            baseHorizonStackView.topAnchor.constraint(equalTo: topAnchor),
            baseHorizonStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            baseHorizonStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),   // 左端から距離10をとる
            baseHorizonStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),   // 右端から距離10をとる
        ]
            .forEach { $0.isActive = true }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


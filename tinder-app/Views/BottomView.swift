//
//  BottomView.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/19.
//

import UIKit

// ホーム画面下 の画面
class BottomView: UIView {
    
    let reloadButton = BottomButtonView(frame: .zero, width: 50, imageName: "reload")
    let cancelButton = BottomButtonView(frame: .zero, width: 60, imageName: "cancel")
    let superLikeButton = BottomButtonView(frame: .zero, width: 50, imageName: "superLike")
    let favoriteButton = BottomButtonView(frame: .zero, width: 60, imageName: "favorite")
    let boostButton = BottomButtonView(frame: .zero, width: 50, imageName: "boost")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let baseHorizonStackView = UIStackView(arrangedSubviews: [reloadButton, cancelButton, superLikeButton, favoriteButton, boostButton])
        baseHorizonStackView.axis = .horizontal
        baseHorizonStackView.distribution = .fillEqually
        baseHorizonStackView.spacing = 10
        baseHorizonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(baseHorizonStackView)
        
        // view の大きさや位置を指定
        [
            // 上下左右の余白を無しにする, safeArea の領域を考慮して配置
            baseHorizonStackView.topAnchor.constraint(equalTo: topAnchor),
            baseHorizonStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            baseHorizonStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),   // 左端から距離10をとる
            baseHorizonStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),   // 右端から距離10をとる
        ]
            .forEach { $0.isActive = true }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

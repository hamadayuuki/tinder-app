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
        
        baseHorizonStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)   // Viewの位置や大きさ
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

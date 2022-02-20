//
//  BottomView.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/19.
//

import UIKit

// ホーム画面下 の画面
class BottomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bottomButton1 = BottomButtonView(frame: .zero, width: 50)
        bottomButton1.backgroundColor = .red
        
        let bottomButton2 = BottomButtonView(frame: .zero, width: 60)
        bottomButton2.backgroundColor = .yellow
        
        let bottomButton3 = BottomButtonView(frame: .zero, width: 50)
        bottomButton3.backgroundColor = .green
        
        let bottomButton4 = BottomButtonView(frame: .zero, width: 60)
        bottomButton4.backgroundColor = .blue
        
        let bottomButton5 = BottomButtonView(frame: .zero, width: 50)
        bottomButton5.backgroundColor = .orange
        
        let baseHorizonStackView = UIStackView(arrangedSubviews: [bottomButton1, bottomButton2, bottomButton3, bottomButton4, bottomButton5])
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

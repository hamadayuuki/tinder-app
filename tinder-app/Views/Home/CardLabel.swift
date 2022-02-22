//
//  CardLabel.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/22.
//

import UIKit

class CardLabel: UILabel {
    
    // GOOD/BADラベル
    init(frame: CGRect, labelText: String, labelColor: UIColor) {
        super.init(frame: frame)
        font = .systemFont(ofSize: 45, weight: .bold)
        text = labelText
        textColor = labelColor
        
        layer.borderWidth = 3
        layer.borderColor = labelColor.cgColor
        layer.cornerRadius = 10
        textAlignment = .center
        
        alpha = 0   // 透明度
    }
    
    // 文字色が白のラベル, 文字の細さは 標準
    init(frame: CGRect, labelText: String, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        super.init(frame: frame)
        font = .systemFont(ofSize: fontSize, weight: fontWeight)
        textColor = .white
        text = labelText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  BottomButtonView.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/20.
//

import UIKit

class BottomButtonView: UIView {
    
    var button: UIButton?   // 外部から参照できるように
    
    init(frame: CGRect, width: CGFloat) {
        super.init(frame: frame)
        
        button = UIButton(type: .system)
        button?.setTitle("tap", for: .normal)
        button?.translatesAutoresizingMaskIntoConstraints = false
        button?.backgroundColor = .white
        button?.layer.cornerRadius = width/2
        
        button?.layer.shadowOffset = .init(width: 1.5, height: 2)
        button?.layer.shadowColor = UIColor.black.cgColor
        button?.layer.shadowOpacity = 0.3
        button?.layer.shadowRadius = (width/2) - 10
        
        addSubview(button!)   // 強制アンラップ(非推奨)
        
        // view の大きさや位置を指定
        [
            button?.centerYAnchor.constraint(equalTo: centerYAnchor),
            button?.centerXAnchor.constraint(equalTo: centerXAnchor),
            button?.widthAnchor.constraint(equalToConstant: width),
            button?.heightAnchor.constraint(equalToConstant: width),
        ]
            .forEach { $0?.isActive = true }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

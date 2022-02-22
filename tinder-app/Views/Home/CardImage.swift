//
//  CardImage.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/22.
//

import UIKit

class CardImage: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
         image = UIImage(named: "userPic1")
         backgroundColor = .green
         layer.cornerRadius = 10
         contentMode = .scaleAspectFill   // 縦横の比率はそのままで短い辺を基準に全体を表示する
         clipsToBounds = true
         layer.borderWidth = 3
         layer.borderColor = UIColor.gray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  CardButton.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/22.
//

import UIKit

class CardButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: "info")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        tintColor = .white
        imageView?.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  RegisterButton.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/23.
//

import UIKit

class RegisterButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .red
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

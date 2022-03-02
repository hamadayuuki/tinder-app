//
//  RegisterLoginButton.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/03/02.
//

import UIKit

class RegisterLoginButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        
        setTitle(text, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

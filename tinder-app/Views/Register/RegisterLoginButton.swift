//
//  RegisterLoginButton.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/03/02.
//

import UIKit

class RegisterLoginButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle("既にアカウントをお持ちの方", for: .normal)
        titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

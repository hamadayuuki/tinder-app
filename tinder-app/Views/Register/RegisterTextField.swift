//
//  RegisterTextField.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/23.
//

import UIKit

class RegisterTextField: UITextField {
    init(placeHolder: String) {
        super.init(frame: .zero)
        
        placeholder = placeHolder
        borderStyle = .roundedRect
        font = .systemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

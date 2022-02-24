//
//  RegisterButton.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/23.
//

import UIKit

class RegisterButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            //                     ↓ この変数が      ↓ true なら                                      ↓ false なら
            self.backgroundColor = isHighlighted ? .rgb(red: 227, green: 48, blue: 78, alpha: 0.2): .rgb(red: 227, green: 48, blue: 78)
        }
    }
    
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

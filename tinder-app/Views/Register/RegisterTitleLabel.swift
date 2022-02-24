//
//  RegisterTitleLabel.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/24.
//

import UIKit
import SwiftUI

class RegisterTitleLabel: UILabel {
    init() {
        super.init(frame: .zero)
        text = "Tinder"
        font = .systemFont(ofSize: 80, weight: .bold)
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

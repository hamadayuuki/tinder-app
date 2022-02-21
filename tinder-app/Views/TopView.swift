//
//  TopView.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/20.
//

import UIKit
import RxCocoa   // ボタンを押した時の処理
import RxSwift

// ホーム画面上 の画面
class TopView: UIView {
    
    let disposeBag = DisposeBag()   // ボタンを押した時の処理で使用
    
    let tinderButton = createToButton(imageName: "tinder")
    let goodButton = createToButton(imageName: "good")
    let commentButton = createToButton(imageName: "comment")
    let profileButton = createToButton(imageName: "profile")
    
    static private func createToButton(imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .selected)   // UIButton.isSelected == true の時
        button.setImage(UIImage(named: "\(imageName)-unselect"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupBinding()
        
    }
    
    private func setupLayout() {
        let baseHorizonStackView = UIStackView(arrangedSubviews: [tinderButton, goodButton, commentButton, profileButton])
        baseHorizonStackView.axis = .horizontal
        baseHorizonStackView.distribution = .fillEqually
        baseHorizonStackView.spacing = 43
        baseHorizonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(baseHorizonStackView)
        
        baseHorizonStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 30, rightPadding: 30)   // Viewの位置や大きさ
        
        tinderButton.isSelected = true   // 初期に表示するボタン
    }
    
    // ボタンを押した時の処理
    private func setupBinding() {
        
        // RxSwift を使用してボタンタップを検知
        tinderButton.rx.tap
            .subscribe { value in
                self.changeButtonIsSelected(selectButton: self.tinderButton)   // アイコンの描画に関する変数 の値を変更
                //print(#function)   // 関数を表示
            }
        goodButton.rx.tap
            .subscribe { value in
                self.changeButtonIsSelected(selectButton: self.goodButton)
            }
        commentButton.rx.tap
            .subscribe { value in
                self.changeButtonIsSelected(selectButton: self.commentButton)
            }
        profileButton.rx.tap
            .subscribe { value in
                self.changeButtonIsSelected(selectButton: self.profileButton)
            }
    }
    
    // アイコンの表示を切り替えるため、.isSelected の変更
    private func changeButtonIsSelected(selectButton: UIButton) {
        let buttons = [self.tinderButton, self.goodButton, self.commentButton, self.profileButton]
        
        buttons.forEach { button in
            if selectButton == button {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


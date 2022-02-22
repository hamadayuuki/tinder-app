//
//  BottomButtonView.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/20.
//

import UIKit

class BottomButtonView: UIView {
    
    var button: BottomButton?   // 外部から参照できるように
    
    init(frame: CGRect, width: CGFloat, imageName: String) {
        super.init(frame: frame)
        
        button = BottomButton(type: .custom)   // .custom: アイコンの色を変更可能
        button?.setImage(UIImage(named: imageName)?.resize(size: CGSize(width: width*0.4, height: width*0.4)), for: .normal)
        button?.translatesAutoresizingMaskIntoConstraints = false
        button?.backgroundColor = .white
        button?.layer.cornerRadius = width/2
        
        // 影
        button?.layer.shadowOffset = .init(width: 1.5, height: 2)
        button?.layer.shadowColor = UIColor.black.cgColor
        button?.layer.shadowOpacity = 0.3
        button?.layer.shadowRadius = (width/2) - 10
        
        addSubview(button!)   // 強制アンラップ(非推奨)
        
        button?.anchor(centerY: centerYAnchor, centerX: centerXAnchor, width: width, height: width)   // Viewの位置や大きさ
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BottomButton: UIButton {
    
    // ボタンのアニメーション
    override var isHighlighted: Bool {
        didSet {
            // ボタンが押された時
            if isHighlighted {
                //             ↓ アニメーション時間  ↓ 待機時間  ↓ バネのような動き 振幅の大きさ(0~1)   ↓ 初速                  ↓ 追加機能
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [],
                               animations: {
                    self.transform = .init(scaleX: 0.8, y: 0.8)   // 大きさを 0.8倍
                    self.layoutIfNeeded()
                    
                })
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [],
                               animations: {
                    self.transform = .identity   // 大きさを もとに戻す
                    self.layoutIfNeeded()
                })
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

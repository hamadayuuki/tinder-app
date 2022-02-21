//
//  CenterView.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/22.
//

import UIKit

class CenterView: UIView {
    
    // ユーザーの写真
    let cardImageView: UIImageView = {
       let iamgeView = UIImageView()
        iamgeView.backgroundColor = .green
        iamgeView.layer.cornerRadius = 10
        iamgeView.contentMode = .scaleToFill   // 短い方を優先して縦横の比を保つ
        return iamgeView
    }()
    
    // ユーザー名
    let nameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .white
        label.text = "Nanashi"
        return label
    }()
    
    // 年齢
    let ageLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .white
        label.text = "20"
        return label
    }()
    
    // 情報ボタン
    let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "info")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    // 住所
    let residenceLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "日本、東京"
        return label
    }()
    
    // 趣味
    let hobbyLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "ランニング"
        return label
    }()
    
    // 一言
    let commentLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "いつも走ってます"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupLayout()
        
        // ドラッグ&ドロップ を検知する                            ↓ 検知した時 呼び出すメソッドを指定
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)   // 検知を有効にする
    }
    
    // ドラッグ&ドロップ に応じて写真を動かす, アクションを検知した時 呼び出されるメソッド
    @objc private func panCardView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)   // ドラッグ&ドロップ で検知した情報(状態や座標)
        
        // ドラッグ&ドロップされている時
        if gesture.state == .changed {
            self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)   // 検知したx,yへ移動
        } else if gesture.state == .ended {
            // 初期値に戻るアニメーション
            UIView.animate(withDuration: 0.3) {
                self.transform = .identity   // 初期値に戻す
                self.layoutIfNeeded()   // アニメーションを認識
            }
        }
    }
    
    // 描画する要素 や 位置, 大きさ を指定
    private func setupLayout() {
        
        // 横並び: 名前と年齢
        let nameAgeHorizontalStackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel])
        nameAgeHorizontalStackView.axis = .horizontal
        
        // 縦並び: ユーザーの情報
        let infoVerticalSatckView = UIStackView(arrangedSubviews: [nameAgeHorizontalStackView, residenceLabel, hobbyLabel, commentLabel])
        infoVerticalSatckView.axis = .vertical
        
        // 横並び: ユーザーの情報 と 情報ボタン
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalSatckView, infoButton])
        baseStackView.axis = .horizontal
        
        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(ageLabel)
        addSubview(baseStackView)
        
        // 位置と大きさ を指定, 描画する全ての要素に制約がつくよう指定を行う
        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        infoButton.anchor(width: 40)
        baseStackView.anchor(bottom: cardImageView.bottomAnchor, left: cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20, leftPadding: 20, rightPadding: 20)
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)
        ageLabel.anchor(bottom: baseStackView.topAnchor, left: nameLabel.rightAnchor, bottomPadding: 10, leftPadding: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
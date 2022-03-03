//
//  CenterView.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/22.
//

import UIKit

class CenterView: UIView {
    
    private let gradientLayer = CAGradientLayer()   // グラデーション
    
    // MARK: UIViews
    private let cardImageView = CardImage(frame: .zero)   // ユーザーの写真
    
    private let infoButton = CardButton(frame: .zero)   // 情報ボタン
    
    private let nameLabel = CardLabel(frame: .zero, labelText: "Nanashi", fontSize: 40, fontWeight: .heavy)   // ユーザー名
    private let ageLabel = CardLabel(frame: .zero, labelText: "20", fontSize: 40, fontWeight: .heavy)   // 年齢
    private let residenceLabel = CardLabel(frame: .zero, labelText: "日本, 東京", fontSize: 20, fontWeight: .regular)    // 住所
    private let hobbyLabel = CardLabel(frame: .zero, labelText: "ランニング", fontSize: 20, fontWeight: .regular)   // 趣味
    private let commentLabel = CardLabel(frame: .zero, labelText: "いつでも走ってます", fontSize: 20, fontWeight: .regular)   // 一言
    
    // GOOD/BADラベル
    let goodLabel = CardLabel(frame: .zero, labelText: "GOOD", labelColor: UIColor.rgb(red: 137, green: 223, blue: 86))
    let badLabel = CardLabel(frame: .zero, labelText: "BAD", labelColor: UIColor.rgb(red: 222, green: 110, blue: 110))
    
    
    // MARK: Layout
    init(user: User) {
        super.init(frame: .zero)
                
        setupLayout(user: user)
        gradientLayout()
        
        // ドラッグ&ドロップ を検知する                            ↓ 検知した時 呼び出すメソッドを指定
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)   // 検知を有効にする
    }
    
    // グラデーションの 色や位置
    private func gradientLayout() {
        print(#function)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        cardImageView.layer.addSublayer(gradientLayer)
    }
    
    // グラデーションの大きさを指定, 画面の描画に関する標準メソッド
    override func layoutSubviews() {
        gradientLayer.frame = self.frame   // = cardImageView.frame とすると描画されない
    }
    
    // ドラッグ&ドロップ に応じて写真を動かす, アクションを検知した時 呼び出されるメソッド
    @objc private func panCardView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)   // ドラッグ&ドロップ で検知した情報(状態や座標)
        guard let view = gesture.view else { return }
        
        // ドラッグ&ドロップされている時
        if gesture.state == .changed {
            handlePanGesture(translation: translation)   // 回転
        } else if gesture.state == .ended {
            handlePanEnded(translation: translation, view: view)
        }
    }
    
    // ドラッグ&ドロップに対する回転
    private func handlePanGesture(translation: CGPoint) {
        let degree: CGFloat = translation.x / 20
        let angle: CGFloat = degree * .pi / 100
        
        let rotateTolanslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTolanslation.translatedBy(x: translation.x, y: translation.y)   // 回転移動
        
        let ratio: CGFloat = 1/100
        let ratioValue = ratio * translation.x
        
        // GOOD/BADラベル の透明度を調整
        if translation.x > 0 {
            goodLabel.alpha = ratioValue
        } else if translation.x < 0 {
            badLabel.alpha = -ratioValue
        }
        
    }
    
    // バウンドしながら初期値に戻るアニメーション
    private func handlePanEnded(translation: CGPoint, view: UIView) {
        
        // スワイプ位置によってアニメーションを変更
        if translation.x <= -120 {
            view.removeCardViewAnimation(x: -600)
        } else if translation.x >= 120 {
            view.removeCardViewAnimation(x: 600)
        } else {
            // 中央へ戻る
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .identity   // 初期値に戻す
                    self.layoutIfNeeded()   // アニメーションを認識
                
                    // GOOD/BADラベル を透明に
                    self.goodLabel.alpha = 0
                    self.badLabel.alpha = 0
            }
        }
    }
    
    // 描画する要素 や 位置, 大きさ を指定
    private func setupLayout(user: User) {
        
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
        addSubview(goodLabel)
        addSubview(badLabel)
        
        // 位置と大きさ を指定, 描画する全ての要素に制約がつくよう指定を行う
        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        infoButton.anchor(width: 40)
        baseStackView.anchor(bottom: cardImageView.bottomAnchor, left: cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20, leftPadding: 20, rightPadding: 20)
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)
        ageLabel.anchor(bottom: baseStackView.topAnchor, left: nameLabel.rightAnchor, bottomPadding: 10, leftPadding: 15)
        goodLabel.anchor(top: cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140, height: 55, topPadding: 20, leftPadding: 20)
        badLabel.anchor(top: cardImageView.topAnchor, right: cardImageView.rightAnchor, width: 140, height: 55, topPadding: 20, rightPadding: 20)
        
        // ユーザー情報を View に反映
        nameLabel.text = user.name
        commentLabel.text = user.email
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  User.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/03/02.
//

import Firebase   // Timestamp

// FireStoreから取得したデータを保持するモデル, FireStoreからデータを取得するときに呼び出される
class User {
    var email: String
    var name: String
    var createAt: Timestamp
    
    // FireStore からデータを取得する時に使用する 辞書
    init(dic: [String: Any]) {
        self.email = dic["email"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.createAt = dic["createAt"] as? Timestamp ?? Timestamp()
    }
}

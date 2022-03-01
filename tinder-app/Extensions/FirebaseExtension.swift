//
//  FirebaseExtension.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/03/01.
//

import Firebase
import FirebaseFirestore

// MARK: FireAuth
extension Auth {
    // 認証情報をFireAuthに登録
    // @escaping をつけていると引数が確定していなくても、関数内のコード処理が先に行われる
    //                                                                                 ↓ 実行状態 を返す
    static func createUserToFireAuth(email: String?, name: String?, password: String?, completion: @escaping (Bool) -> Void) {
        // nilチェック
        guard let email = email else { return }
        guard let name = name else { return }
        guard let password = password else { return }
        
        // 登録
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if let err = err {
                print("登録失敗: ", err)
            }
            
            guard let uid = auth?.user.uid else { return }
            print("登録成功: ", uid)
            Firestore.setupUserDataToFireStore(email: email, uid: uid, name: name, completion: { success in
                completion(success)
            })
        }
    }
}

// MARK: FireStore
extension Firestore {
    // ユーザー情報をFireStoreに登録
    //                                                                              ↓ 実行状態 を返す
    static func setupUserDataToFireStore(email: String, uid: String, name: String?, completion: @escaping (Bool) -> ()) {
        guard let name = name else { return }
        
        let document = [
            "name": name,
            "email": email,
            "createAt": Timestamp()
        ] as [String : Any]
        
        Firestore.firestore().collection("user").document(uid).setData(document) { err in
            if let err = err {
                print("FireStoreへの登録に失敗: ", err)
                return
            }
            completion(true)   // 実行状態 を返す
            print("FireStoreへの登録に成功")
        }
    }
}





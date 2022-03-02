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
    
    static func loginWithFireAuth(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("ログイン認証に失敗しました")
                print("err: ", err)
                print("email: ", email)
                print("password: ", password)
                completion(false)
                return
            }
            
            print("ログイン認証に成功しました")
            completion(true)
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
    
    // uidを使ってFireStoreからデータを取得する
    //                                                                    ↓ 処理中に呼び出し元に情報を渡せる
    static func feathUserFromFirestore(uid: String, completion: @escaping (User?) -> Void) {
        Firestore.firestore().collection("user").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print("ユーザー情報の取得に失敗: ", err)
                completion(nil)
                return
            }
            
            print("ユーザー情報の取得に成功")
            print("uid: ", uid)
            guard let data = snapshot?.data() else { return }
            let user = User.init(dic: data)
            completion(user)
        }
    }
    
    // 全てのユーザー情報をFireStoreから取得する → 今後は、"自分以外の"ユーザーの情報を取得する
    static func featchOtherUsersFromFirestore(completion: @escaping ([User]?) -> Void) {
        Firestore.firestore().collection("user").getDocuments { (snapshots, err) in
            if let err = err {
                print("他のユーザー情報の取得に失敗: ", err)
                completion(nil)
                return
            }
            
            print("他のユーザー情報の取得に成功")
            
            // 他のユーザーのリスト作成 - 1
//            var otherUsers = [User]()
//            snapshots?.documents.forEach { (snapshot) in
//                let dic = snapshot.data()
//                let otherUser = User(dic: dic)
//                otherUsers.append(otherUser)
//            }
            
            // 他のユーザーのリスト作成 - 2
            let otherUsers = snapshots?.documents.map({ (snapshot) -> User in
                let dic = snapshot.data()
                let otherUser = User(dic: dic)
                return otherUser
            })
            
            completion(otherUsers ?? [User]())
        }
    }
}





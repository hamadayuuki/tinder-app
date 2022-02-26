//
//  RegisterViewModel.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/26.
//
/*
 
 登録画面で入力する情報(名前/メールアドレス/パスワード)の確認を行う
 
 */
import Foundation
import RxSwift

class RegisterViewModel {
    
    private let disposeBag = DisposeBag()
    
    // MARK: observable
    // ViewModel から出ていく情報
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    
    // MARK: observer
    // 受け取る情報
    var nameTextInput: AnyObserver<String> {
        nameTextOutput.asObserver()
    }
    var emailTextInput: AnyObserver<String> {
        emailTextOutput.asObserver()
    }
    var passwordTextInput: AnyObserver<String> {
        passwordTextOutput.asObserver()
    }
    
    // 入力を受け取る, 内容を表示する
    init() {
        
        nameTextOutput
            .asObservable()
            .subscribe { text in
                print("name: ", text)
            }
            .disposed(by: disposeBag)
        
        emailTextOutput
            .asObservable()
            .subscribe { text in
                print("email: ", text)
            }
            .disposed(by: disposeBag)
        
        passwordTextOutput
            .asObservable()
            .subscribe { text in
                print("password: ", text)
            }
            .disposed(by: disposeBag)
        
    }
}


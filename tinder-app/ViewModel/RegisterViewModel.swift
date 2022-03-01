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
import RxCocoa

class RegisterViewModel {
    
    private let disposeBag = DisposeBag()
    
    // MARK: observable
    // ViewModel から出ていく情報
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    var validRegisterSubject = BehaviorSubject<Bool>(value: false)   // 全てのデータの状態の結果を返す
    
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
    var validRegisterDriver: Driver<Bool> = Driver.never()   // 全てのデータの状態の結果を返す
    
    // 入力を受け取る, 内容を表示する
    init() {
        
        validRegisterDriver = validRegisterSubject
            .asDriver(onErrorDriveWith: Driver.empty())
        
        let nameValid = nameTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
//            .subscribe { text in
//                print("name: ", text)
//            }
//            .disposed(by: disposeBag)
        
        let emailValid = emailTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
//            .subscribe { text in
//                print("email: ", text)
//            }
//            .disposed(by: disposeBag)
        
        let passwordValid = passwordTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
//            .subscribe { text in
//                print("password: ", text)
//            }
//            .disposed(by: disposeBag)
        
        // nameValid, emailValid, passwordValid が true の時, true を返す
        Observable.combineLatest(nameValid, emailValid, passwordValid) { $0 && $1 && $2 }
        .subscribe { validAll in
            self.validRegisterSubject.onNext(validAll)
        }
        .disposed(by: disposeBag)

        
    }
}


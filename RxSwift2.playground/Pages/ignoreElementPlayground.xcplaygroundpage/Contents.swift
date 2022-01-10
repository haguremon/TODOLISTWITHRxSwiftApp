import UIKit
import RxSwift
import PlaygroundSupport

//let publishSubject = PublishSubject<String>()

let  disposeBag = DisposeBag()

//publishSubject.onNext("サブスク前だと元々呼ばれない")
//
//publishSubject
//    .subscribe { ignoreEvent in
//    print(ignoreEvent)
//    }.disposed(by: disposeBag)
//
//publishSubject.onNext("サブスク後だから呼ばれる")
//publishSubject.onCompleted()

//要素を無視する　フィルターをつけると

let ignoreSubject = PublishSubject<String>()

ignoreSubject.ignoreElements()//全てのイベントを無視して完了やエラーのみ通知
    .subscribe { ignoreEvent in
    print(ignoreEvent)
    print("ignore")//completed ignore
    }.disposed(by: disposeBag)
ignoreSubject.onNext("I")
ignoreSubject.onNext("G")
ignoreSubject.onNext("N")
ignoreSubject.onNext("O")
ignoreSubject.onNext("R")
ignoreSubject.onNext("E")
ignoreSubject.onCompleted()

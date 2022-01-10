import UIKit
import RxSwift
import PlaygroundSupport

let publishSubject = PublishSubject<String>()

let  disposeBag = DisposeBag()


publishSubject.element(at: 3)//onNextの要素があった時にsubscribeされる
    .subscribe { event in
    print(event)
    }.disposed(by: disposeBag)

publishSubject.onNext("element: 0")
publishSubject.onNext("element: 1")
publishSubject.onNext("element: 2")
publishSubject.onNext("element: 3")

publishSubject.onCompleted()


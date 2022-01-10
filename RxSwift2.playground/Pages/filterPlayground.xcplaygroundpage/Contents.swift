
import Foundation
import RxSwift
import PlaygroundSupport

let publishSubject = PublishSubject<String>()

let  disposeBag = DisposeBag()


publishSubject.filter({ $0 == "element: 3" })
    .subscribe { event in
    print(event)
    }.disposed(by: disposeBag)


publishSubject.onNext("element: 3")

publishSubject.onCompleted()

print("aaaaaa")
let publishSubject1 = PublishSubject<Int>()


publishSubject1.filter({ $0 < 50 })//条件で絞ってtrueの要素だけ通知できるError,完了は通知できる
    .subscribe { event in
    print(event)//next(20) next(30) completed
    }.disposed(by: disposeBag)

publishSubject1.onNext(20)
publishSubject1.onNext(30)
publishSubject1.onNext(60)
publishSubject1.onNext(75)

publishSubject1.onCompleted()

let publishSubject2 = PublishSubject<Int>()

publishSubject2.filter({ $0 < 2 })
    .subscribe { event in
    print(event)
    }.disposed(by: disposeBag)

publishSubject2.onNext(0)
publishSubject2.onNext(1)
publishSubject2.onNext(2)
publishSubject2.onNext(3)

publishSubject2.onCompleted()

Observable.of(1,2,3,4,5,6).filter { $0 % 2 == 0 }.subscribe { event in
    print(event) //2で割った時に余りが０のやつ（偶数）
} onCompleted: {
    print("onCompleted")
}.disposed(by: disposeBag)


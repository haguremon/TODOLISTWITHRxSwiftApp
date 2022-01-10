import UIKit
import RxSwift
import PlaygroundSupport

let publishSubject = PublishSubject<String>()

let  disposeBag = DisposeBag()


publishSubject.skip(1)//要素の前から何個スキップするか指定できる
    .subscribe { event in
    print(event)
    }.disposed(by: disposeBag)
publishSubject.onNext("element: 0")
publishSubject.onNext("element: 1")
publishSubject.onNext("element: 2")
publishSubject.onNext("element: 3")
publishSubject.onCompleted()

Observable.of(1,2,3,4,5,6).skip(2).subscribe { event in
    print(event)
}.disposed(by: disposeBag)

Observable.of(["a","b","c"],["a1","b1","c1"],["a2","b2","c2"],["a3","b3","c3"]).skip(2).subscribe { event in
    print(event)
}.disposed(by: disposeBag)

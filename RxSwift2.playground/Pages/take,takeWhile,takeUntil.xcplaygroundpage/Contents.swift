import UIKit
import RxSwift


let  disposeBag = DisposeBag()

//前から３つtakeする
Observable.of(1,2,3,4,5).take(3)
    .subscribe(onNext: {print($0)},
               onCompleted: {
                print("onCompleted") }).disposed(by: disposeBag)


//take(while: 条件)
Observable.of(1, 2, 3, 4, 1, 6, 7, 8)
    .take(while: { $0 < 4 }) //falseになった途端にそれからは切り捨て
    .subscribe(
        onNext: { print($0) },
        onCompleted: {
            print("onCompleted") }).disposed(by: disposeBag)



Observable.of(2, 4, 6, 8, 5, 2, 2, 2)
    .take(while: { $0 % 2 == 0 }) //falseになった途端にそれからは切り捨て
    .subscribe(
        onNext: { print($0) }).disposed(by: disposeBag)


let publishSubject = PublishSubject<String>()

let triggerSubject = PublishSubject<String>()

publishSubject.take(until: triggerSubject)
    .subscribe(onNext: { print($0) },
               onCompleted: { print("publishSubject is finished, triggerSubject started") }).disposed(by: disposeBag)


triggerSubject.subscribe { event in
    print(event)
}.disposed(by: disposeBag)

publishSubject.onNext("triggerSubjectがonNextされるまで1")
publishSubject.onNext("triggerSubjectがonNextされるまで２")
publishSubject.onNext("triggerSubjectがonNextされるまで３")
triggerSubject.onNext("triggerSubject開始、publishSubject終了")
publishSubject.onNext("triggerSubjectがonNextされたから発動しない")
triggerSubject.onNext("triggerSubjectイベント")
triggerSubject.onCompleted()




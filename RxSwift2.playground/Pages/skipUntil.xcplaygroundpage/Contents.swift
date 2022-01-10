import UIKit
import RxSwift
import PlaygroundSupport

let publishSubject = PublishSubject<String>()

let  disposeBag = DisposeBag()

let triggerSubject = PublishSubject<String>()

publishSubject.skip(until: triggerSubject).subscribe { event in
    print(event)
}.disposed(by: disposeBag)

triggerSubject.subscribe(onNext: {
    print($0)
},onCompleted: {
    print("onCompleted")
}).disposed(by: disposeBag)


publishSubject.onNext("トリガー発動するのでイベント通知受けない")
publishSubject.onNext("トリガー発動するのでイベント通知受けない１")
triggerSubject.onNext("トリガー発動、publishSubjectのイベント開始!!!")


publishSubject.onNext("トリガー発動する後でイベント通知０")
publishSubject.onNext("トリガー発動する後でイベント通知１")
publishSubject.onNext("トリガー発動する後でイベント通知２")
publishSubject.onCompleted()
triggerSubject.onCompleted()


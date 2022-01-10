import UIKit
import RxSwift
import PlaygroundSupport
/*
 The SkipWhile subscribes to the source Observable, but ignores its emissions until such time as some condition you specify becomes false, at which point SkipWhile begins to mirror the source Observable.
 */

let  disposeBag = DisposeBag()
//条件がfalseになったらそこから全てのイベントが発生する　5がfalse
Observable.of(1, 2, 3, 4, 5, 1, 2, 3, 4, 5).skip { $0 < 5 }.subscribe { event in
    print(event)
}.disposed(by: disposeBag)

// 5, 1, 2, 3, 4, 5 を通知する

Observable.of(1, 2, 3, 4, 10, 1, 2, 3, 4, 5).skip { $0 < 10 }.subscribe { event in
    print(event)
}.disposed(by: disposeBag)

//２からfalseになる
Observable.of(1, 3, 5, 7, 7, 2, 6, 7, 8).skip { $0 % 2 == 1 }.subscribe { event in
    print(event)
}.disposed(by: disposeBag)

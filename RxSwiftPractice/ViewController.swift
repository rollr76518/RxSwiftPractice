//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by Ryan on 2019/10/18.
//  Copyright © 2019 Hanyu. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

	let disposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		Observable.just(1)
			.map({ (number) -> Int in
				print(Thread.isMainThread)
				return number
			})
			.subscribeOn(MainScheduler.instance)
			.map({ (number) -> Int in
				print(Thread.isMainThread)
				return number
			})
			.subscribeOn(MainScheduler.instance)
			.map({ (number) -> Int in
				print(Thread.isMainThread)
				return number
			})
			.observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
			.map({ (number) -> String in
				print(Thread.isMainThread)
				return "\(number)"
			})
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { (number) in
				print(Thread.isMainThread)
				print(number)
			})
			.disposed(by: disposeBag)
	}
}


//
//  JLXTimeHelper.swift
//  xiaoxianhuo
//
//  Created by Will on 4/12/16.
//  Copyright © 2016 xiaoxianhuo. All rights reserved.
//

import UIKit

func secondsToFormatTimeShort(seconds: Double) -> String {
	let str = String().stringByAppendingFormat("%02.f:%02.f",
		seconds / 60,
		seconds % 60)

	return str
}

func secondsToFormatTimeShortWithOneDecimal(seconds: Double) -> String {
	let str = String().stringByAppendingFormat("%02.f:%02.1f",
		seconds / 60,
		seconds % 60)

	return str
}

func secondsToFormatTimeFull(seconds: Double) -> String {
	let str = String().stringByAppendingFormat("%02.f:%02.f:%02.f",
		seconds / 60 / 60,
		seconds / 60,
		seconds % 60)

	return str
}

func secondsToFormatTimeFullWithOneDecimal(seconds: Double) -> String {
	let str = String().stringByAppendingFormat("%02.f:%02.f:%02.1f",
		seconds / 60 / 60,
		seconds / 60,
		seconds % 60)

	return str
}
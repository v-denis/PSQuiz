//
//  Helper.swift
//  Lesson7_homework
//
//  Created by MacBook Air on 21.03.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import Foundation
import UIKit


class Helper {
	
	static var shared = Helper()
	
	func addSubviews(views: [UIView], to superView: UIView) {
		for view in views {
			superView.addSubview(view)
		}
	}
	
}

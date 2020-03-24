//
//  OpenResultVCProtocol.swift
//  Lesson7_homework
//
//  Created by MacBook Air on 22.03.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import Foundation
import UIKit

protocol OpenResultVCProtocol: class {
	
//	var resultType: QuestionType { get set }
//	var resultCount: Int { get set }
	func presentResultVC(with type: QuestionType, count: Int)
}

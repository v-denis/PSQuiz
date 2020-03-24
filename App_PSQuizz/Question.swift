//
//  Question.swift
//  Lesson7_homework
//
//  Created by MacBook Air on 22.03.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import Foundation
import UIKit

enum QuestionType: String {
	case pizza = "пицца"
	case sushi = "роллы"
}

struct Question {
	
	static let pizzaDict: [String:String] = ["4cheese":"4 сыра",
											 "4seasons":"4 сезона",
											 "assorti":"Ассорти",
											 "hawaii":"Гавайская",
											 "karbonara":"Карбонара",
											 "margarita":"Маргарита",
											 "pepperoni":"Пепперони",
											 "seafood":"Морская"]
	
	static let sushiDict: [String:String] = ["avakado_roll":"Авакадо-ролл",
											 "california":"Калифорния",
											 "chyka_roll":"Чука-ролл",
											 "filadelfia":"Филадельфия",
											 "kappa_maki":"Каппа-маки",
											 "syaki_maki":"Сяке-маки",
											 "tekka_maki":"Текка-маки",
											 "tempura":"Темпура"]
	
	var id: Int
	var image: UIImage?
	var correctAnswer: String
	var answerOptions: [String]
	
	static func generateQuestions(with type: QuestionType, amount: Int) -> [Question] {
		var resultQuestions = [Question]()
		var tempDict = (type == .pizza) ? Question.pizzaDict : Question.sushiDict
		
		for index in 1...amount {
			guard let firstPair = tempDict.popFirst() else { continue }
			var answers = [firstPair.value]
			while answers.count < 4 {
				if type == .pizza {
					if let anotherAnswer = pizzaDict.values.randomElement(), !answers.contains(anotherAnswer) {
						answers.append(anotherAnswer)
					}
				} else if type == .sushi {
					if let anotherAnswer = sushiDict.values.randomElement(), !answers.contains(anotherAnswer) {
						answers.append(anotherAnswer)
					}
				}
			}
			answers.shuffle()
			let question = Question(id: index, image: UIImage(named: String(describing: firstPair.key)), correctAnswer: String(describing: firstPair.value), answerOptions: answers)
			resultQuestions.append(question)
		} 
		return resultQuestions
	}
	
}

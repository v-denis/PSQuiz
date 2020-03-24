//
//  ResultQuizViewController.swift
//  Lesson7_homework
//
//  Created by MacBook Air on 22.03.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class ResultQuizViewController: UIViewController {

	var mainLabel = UILabel()
	var resultLabel = UILabel()
	var commentLabel = UILabel()
	var mainQuizImage = UIImageView()
	var resultType = QuestionType.pizza
	var resultPoints = 0
	let makeOrderButton = UIButton(type: .system)
	let toBeginButton = UIButton(type: .roundedRect)
	
    override func viewDidLoad() {
        super.viewDidLoad()

        configurateVC()
    }
	
}


//MARK: - custom methods
extension ResultQuizViewController {
	
	private func configurateVC() {
		
		view.backgroundColor = (resultType == .pizza) ? #colorLiteral(red: 0.168627451, green: 0.6705882353, blue: 0.9215686275, alpha: 1) : #colorLiteral(red: 1, green: 0.4509803922, blue: 0.3607843137, alpha: 1)
		mainLabel.frame = CGRect(x: 0, y: 40, width: view.frame.width - 40, height: 100)
		mainLabel.center.x = view.center.x
		mainQuizImage.frame = CGRect(x: 0, y: mainLabel.frame.maxY + 5, width: 140, height: 140)
		mainQuizImage.center.x = view.center.x
		mainQuizImage.image = (resultType == .pizza) ? UIImage(named: "mainpizza2") : UIImage(named: "mainroll2")
		mainQuizImage.contentMode = .scaleAspectFit
		
		resultLabel.frame = CGRect(x: 15, y: mainQuizImage.frame.maxY + 25, width: view.frame.width - 30, height: 60)
		commentLabel.frame = CGRect(x: 15, y: resultLabel.frame.maxY, width: resultLabel.frame.width, height: 130)
		makeOrderButton.frame = CGRect(x: 0, y: commentLabel.frame.maxY + 40, width: 280, height: 52)
		toBeginButton.frame = CGRect(x: 0, y: makeOrderButton.frame.maxY + 40, width: 280, height: 52)
		
		makeOrderButton.backgroundColor = .black
		makeOrderButton.setTitleColor(.white, for: .normal)
		makeOrderButton.setTitle("Заказать \((resultType) == .pizza ? "пиццу" : "роллы")!", for: .normal)
		makeOrderButton.layer.cornerRadius = 15
		toBeginButton.setTitleColor(.black, for: .normal)
		toBeginButton.layer.cornerRadius = 15
		toBeginButton.setTitle("В начало", for: .normal)
		makeOrderButton.center.x = view.center.x
		toBeginButton.center.x = view.center.x
		makeOrderButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
		toBeginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		toBeginButton.layer.borderColor = UIColor.black.cgColor
		toBeginButton.layer.borderWidth = 2
		
		
		resultLabel.textAlignment = .left
		resultLabel.numberOfLines = 0
		resultLabel.lineBreakMode = .byWordWrapping
		resultLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
		resultLabel.text = "Результат:\nВы отгадали \(resultPoints) \(getCorrectSuffix(of: resultType, amount: resultPoints)) из 8\n"
		commentLabel.text = getResultComment(of: resultType, amount: resultPoints)
		commentLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		commentLabel.numberOfLines = 0
		commentLabel.textAlignment = .left
		commentLabel.lineBreakMode = .byWordWrapping
		mainLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
		mainLabel.textColor = .black
		mainLabel.numberOfLines = 0
		mainLabel.lineBreakMode = .byWordWrapping
		mainLabel.text = "Поздравляем!\nВы прошли \(resultType.rawValue)-тест!"
		mainLabel.textAlignment = .center
		
		toBeginButton.addTarget(self, action: #selector(changeVCButtonTapped(_:)), for: .touchUpInside)
		makeOrderButton.addTarget(self, action: #selector(changeVCButtonTapped(_:)), for: .touchUpInside)
		
		Helper.shared.addSubviews(views: [mainLabel, resultLabel, commentLabel, mainQuizImage, makeOrderButton, toBeginButton], to: view)
	}
	
	
	
	private func getCorrectSuffix(of type: QuestionType, amount: Int) -> String {
		
		if type == .pizza {
			switch amount {
				case 0: return "пицц"
				case 1: return "пиццу"
				case 2...4: return "пиццы"
				case 5...8: return "пицц"
				default: return "пиццы"
			}
		} else {
			switch amount {
				case 1: return "роллы"
				case 0, 2...8: return "роллов"
				default: return "роллов"
			}
		}
	}
	
	private func getResultComment(of type: QuestionType, amount: Int) -> String {
		
		if type == .pizza {
			switch amount {
				case 0...3: return "Похоже не помешает подкрепиться!\nИ заодно вспомнить как называются и выглядят все эти вкусные круглые штуки. Ждём твоего заказа!"
				case 4...5: return "\"Удовлетворительно\" - сказали бы в универе на такой результат.\nСкорей заказывай парочку горячих, вкусных пицц!\nПодкрепимся и улучшим результат вместе!"
				case 6...7: return "Отличный результат!\nМожет отметим большой горячей и вкусной пиццей, а?\nЖдём твоего заказа!"
				case 8: return "Ух-ты! Ты настоящий пицца-эксперт!\nБесплатная горячая \"Маргарита\" в подарок уже ждёт тебя в заказе!"
				default: return ""
			}
		} else {
			switch amount {
				case 0...3: return "Похоже вы давно не кушали роллы, стоит подкрепиться и вспомнить! Ждём вашего заказа!"
				case 4...5: return "Неплохо! Но мы уверены ты можешь лучше, особенно после горячего свежего сета от нас!"
				case 6...7: return "Хороший результат!\nCтоит отметить вкуснейшим сетом роллов - смело заказывай!"
				case 8: return "Ух-ты! Вы настоящий эксперт роллов! Бесплатный сет в подарок уже ждёт вас в новом заказе!"
				default: return ""
			}
		}
		
	}
}

//MARK: - custom selectors
extension ResultQuizViewController {
	
	@objc private func changeVCButtonTapped(_ sender: UIButton) {
		if sender == toBeginButton {
			self.dismiss(animated: true, completion: nil)
		} else if sender == makeOrderButton {
			let orderVC = OrderViewController()
			orderVC.menuType = resultType
			orderVC.comeFromQuiz = false
			self.present(orderVC, animated: true, completion: nil)
		}
	}
}

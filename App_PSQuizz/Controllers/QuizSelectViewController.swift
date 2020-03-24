//
//  ViewController.swift
//  Lesson7_homework
//
//  Created by MacBook Air on 21.03.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class QuizSelectViewController: UIViewController {
	
	var mainLabel = UILabel()
	var pizzaImageView = UIImageView()
	var sushiImageView = UIImageView()
	var versusLabel = UILabel()
	var pizzaQuizButton = UIButton(type: .system)
	var sushiQuizButton = UIButton(type: .system)
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		
		configurationVC()
	}
	
}


//MARK: - custom methods for current VC
extension QuizSelectViewController {
	
	private func configurationVC() {
		
		view.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.9458087816, alpha: 1)
		mainLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
		mainLabel.text = "Съедобная викторина :)"
		mainLabel.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 80, width: view.frame.width, height: 50)
		mainLabel.center.x = view.center.x
		mainLabel.textAlignment = .center
		mainLabel.textColor = .black
		versusLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
		versusLabel.center.x = view.center.x
		pizzaImageView.frame = CGRect(x: versusLabel.frame.minX - 160, y: mainLabel.frame.maxY + 45, width: 150, height: 150)
		versusLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
		versusLabel.text = "vs"
		versusLabel.textAlignment = .center
		versusLabel.center.y = pizzaImageView.center.y
		pizzaImageView.image = UIImage(named: "mainpizza2")
		sushiImageView.image = UIImage(named: "mainroll2")
		sushiImageView.frame = CGRect(x: versusLabel.frame.maxX + 10, y: 0, width: 150, height: 150)
		sushiImageView.center.y = pizzaImageView.center.y
		sushiImageView.contentMode = .scaleAspectFit
		pizzaImageView.contentMode = .scaleAspectFit
		sushiQuizButton.setTitle("угадаю все РОЛЛЫ", for: .normal)
		pizzaQuizButton.setTitle("угадаю все ПИЦЦЫ", for: .normal)
		pizzaQuizButton.frame = CGRect(x: 0, y: view.center.y + 20, width: 240, height: 52)
		sushiQuizButton.frame = CGRect(x: 0, y: pizzaQuizButton.frame.maxY + 60, width: 240, height: 52)
		sushiQuizButton.center.x = view.center.x
		pizzaQuizButton.center.x = view.center.x
		sushiQuizButton.layer.cornerRadius = 15
		pizzaQuizButton.layer.cornerRadius = 15
		sushiQuizButton.backgroundColor = #colorLiteral(red: 1, green: 0.4509803922, blue: 0.3607843137, alpha: 1)
		pizzaQuizButton.backgroundColor = #colorLiteral(red: 0.168627451, green: 0.6705882353, blue: 0.9215686275, alpha: 1)
		pizzaQuizButton.setTitleColor(.white, for: .normal)
		sushiQuizButton.setTitleColor(.white, for: .normal)
		
		pizzaQuizButton.titleLabel?.font = (pizzaQuizButton.titleLabel != nil) ? UIFont.systemFont(ofSize: 19, weight: .medium) : nil
		sushiQuizButton.titleLabel?.font = (pizzaQuizButton.titleLabel != nil) ? UIFont.systemFont(ofSize: 19, weight: .medium) : nil
		
		pizzaQuizButton.addTarget(self, action: #selector(goToQuizVC(_:)), for: .touchUpInside)
		sushiQuizButton.addTarget(self, action: #selector(goToQuizVC(_:)), for: .touchUpInside)
		
		Helper.shared.addSubviews(views: [mainLabel, pizzaImageView, sushiImageView, versusLabel, pizzaQuizButton, sushiQuizButton], to: self.view)
	}
}

//MARK: - protocol methods realisation
extension QuizSelectViewController: OpenResultVCProtocol {

	func presentResultVC(with type: QuestionType, count: Int) {
		let resultVC = ResultQuizViewController()
		resultVC.resultType = type
		resultVC.resultPoints = count
		resultVC.modalPresentationStyle = .fullScreen
		self.present(resultVC, animated: true, completion: nil)
	}
	
	
}

//MARK: - custom selectors for current VC
extension QuizSelectViewController {
	
	@objc private func goToQuizVC(_ sender: UIButton) {
		let quizVC = QuizViewController()
		quizVC.modalPresentationStyle = .fullScreen
		
		if sender == pizzaQuizButton {
			quizVC.modalTransitionStyle = .flipHorizontal
			quizVC.questions = Question.generateQuestions(with: .pizza, amount: 8)
			quizVC.quizType = .pizza
			quizVC.delegate = self
			self.present(quizVC, animated: true, completion: nil)
		} else if sender == sushiQuizButton {
			quizVC.modalTransitionStyle = .flipHorizontal
			quizVC.questions = Question.generateQuestions(with: .sushi, amount: 8)
			quizVC.quizType = .sushi
			quizVC.delegate = self
			self.present(quizVC, animated: true, completion: nil)
		}
	}
}

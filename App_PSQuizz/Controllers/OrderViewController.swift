//
//  OrderViewController.swift
//  Lesson7_homework
//
//  Created by MacBook Air on 22.03.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
	
	var comeFromQuiz = false
	var menuType: QuestionType!
	var elements: [Question]!
	var mainImage = UIImageView()
	var mainLabel = UILabel()
	var dishNameLabel = UILabel()
	var dishNameSegment = UISegmentedControl()
	var pizzaSizeSegment = UISegmentedControl()
	var pizzaDoughTypeSegment = UISegmentedControl()
	var amountLabel = UILabel()
	var countStepper = UIStepper()
	var makeOrderButton = UIButton(type: .roundedRect)

    override func viewDidLoad() {
        super.viewDidLoad()
		configuratingOrderVC()
    }
	
}



//MARK: - custom methods
extension OrderViewController {
	
	private func configuratingOrderVC() {
		
		view.backgroundColor = .white
		elements = Question.generateQuestions(with: self.menuType, amount: 4)
		mainLabel.frame = CGRect(x: 0, y: 20, width: view.frame.width - 50, height: 40)
		mainLabel.center.x = view.center.x
		mainImage.frame = CGRect(x: 0, y: mainLabel.frame.maxY + 10, width: view.frame.width - 30, height: 300)
		mainImage.center.x = view.center.x
		dishNameLabel.frame = CGRect(x: 20, y: mainImage.frame.maxY, width: view.frame.width - 40, height: 40)
		dishNameSegment.frame = CGRect(x: 20, y: dishNameLabel.frame.maxY + 15, width: view.frame.width - 40, height: 40)
		dishNameSegment.center.x = view.center.x
		
		if menuType == .pizza {
			pizzaSizeSegment.frame = CGRect(x: 20, y: dishNameSegment.frame.maxY + 15, width: view.frame.width - 40, height: 40)
			pizzaSizeSegment.center.x = view.center.x
			pizzaDoughTypeSegment.frame = CGRect(x: 20, y: pizzaSizeSegment.frame.maxY + 15, width: view.frame.width - 40, height: 40)
			pizzaDoughTypeSegment.center.x = view.center.x
			amountLabel.frame = CGRect(x: 25, y: pizzaDoughTypeSegment.frame.maxY + 30, width: 65, height: 40)
			dishNameSegment.setTitleTextAttributes([.font:UIFont.systemFont(ofSize: 14, weight: .medium)], for: .normal)
		} else if menuType == .sushi {
			dishNameSegment.frame = CGRect(x: 5, y: dishNameLabel.frame.maxY + 20, width: view.frame.width - 10, height: 40)
			dishNameSegment.center.x = view.center.x
			dishNameSegment.setTitleTextAttributes([.font:UIFont.systemFont(ofSize: 10, weight: .medium)], for: .normal)
			amountLabel.frame = CGRect(x: 25, y: dishNameSegment.frame.maxY + 40, width: 65, height: 40)
		}
		countStepper.frame = CGRect(x: amountLabel.frame.maxX + 5, y: 0, width: 100, height: 50)
		countStepper.center.y = amountLabel.center.y
		makeOrderButton.frame = CGRect(x: view.frame.width - 180, y: 0, width: 160, height: 43)
		makeOrderButton.center.y = countStepper.center.y
		makeOrderButton.layer.cornerRadius = 17
		makeOrderButton.setTitle("Заказать", for: .normal)
		makeOrderButton.setTitleColor(.red, for: .normal)
		makeOrderButton.layer.borderColor = #colorLiteral(red: 1, green: 0.4509803922, blue: 0.3607843137, alpha: 1)
		makeOrderButton.layer.borderWidth = 1.5
		countStepper.center.y = amountLabel.center.y
		countStepper.minimumValue = 1.0
		countStepper.value = 1.0
		countStepper.stepValue = 1.0
		amountLabel.text = String(Int(countStepper.value)) + " шт"
		amountLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
		amountLabel.textColor = #colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1)
		mainLabel.textAlignment = .center
		mainLabel.text = "Ваш заказ"
		mainLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
		mainImage.contentMode = .scaleAspectFit
		
		dishNameSegment.selectedSegmentTintColor = #colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1)
		dishNameSegment.layer.borderWidth = 1.5
		dishNameSegment.layer.borderColor = #colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1)
		dishNameSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1)], for: .normal)
		dishNameSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: [.highlighted, .selected])
		dishNameSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .selected)
		dishNameSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1).withAlphaComponent(0.5)], for: .highlighted)
		pizzaSizeSegment.selectedSegmentTintColor = #colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1)
		pizzaSizeSegment.layer.borderWidth = 1.5
		pizzaSizeSegment.layer.borderColor = #colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1)
		pizzaSizeSegment.backgroundColor = .clear
		pizzaDoughTypeSegment.selectedSegmentTintColor = #colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1)
		pizzaDoughTypeSegment.layer.borderWidth = 1.5
		pizzaDoughTypeSegment.layer.borderColor = #colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1)
		pizzaSizeSegment.backgroundColor = .clear
		pizzaSizeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1)], for: .normal)
		pizzaSizeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: [.highlighted, .selected])
		pizzaSizeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .selected)
		pizzaSizeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1).withAlphaComponent(0.5)], for: .highlighted)
		pizzaSizeSegment.insertSegment(withTitle: "30 см", at: 0, animated: true)
		pizzaSizeSegment.insertSegment(withTitle: "35 см", at: 1, animated: true)
		pizzaSizeSegment.insertSegment(withTitle: "40 см", at: 2, animated: true)
		countStepper.tintColor = #colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1)
		countStepper.layer.borderWidth = 1.0
		countStepper.layer.borderColor = #colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1)
		countStepper.layer.cornerRadius = 10
		countStepper.backgroundColor = .white
		pizzaDoughTypeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1)], for: .normal)
		pizzaDoughTypeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: [.highlighted, .selected])
		pizzaDoughTypeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .selected)
		pizzaDoughTypeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.1054839975, green: 0.4358024635, blue: 0.6029217366, alpha: 1).withAlphaComponent(0.5)], for: .highlighted)
		pizzaDoughTypeSegment.insertSegment(withTitle: "Традиционное", at: 0, animated: true)
		pizzaDoughTypeSegment.insertSegment(withTitle: "Тонкое", at: 1, animated: true)
		
		dishNameSegment.insertSegment(withTitle: elements[0].correctAnswer, at: 0, animated: true)
		dishNameSegment.insertSegment(withTitle: elements[1].correctAnswer, at: 1, animated: true)
		dishNameSegment.insertSegment(withTitle: elements[2].correctAnswer, at: 2, animated: true)
		dishNameSegment.insertSegment(withTitle: elements[3].correctAnswer, at: 3, animated: true)
		dishNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
		dishNameSegment.isMomentary = false
		
		dishNameSegment.addTarget(self, action: #selector(dishNameSegmentControlChanged), for: .valueChanged)
		countStepper.addTarget(self, action: #selector(stepperTapped), for: .valueChanged)
		makeOrderButton.addTarget(self, action: #selector(makeOrderButtonTapped(_:)), for: .touchUpInside)
		
		Helper.shared.addSubviews(views: [amountLabel, countStepper, mainImage, dishNameLabel, mainLabel, dishNameSegment, pizzaSizeSegment, pizzaDoughTypeSegment, makeOrderButton], to: view)
	}
	
	private func checkAllSegmentsSelected() -> Bool {
		if menuType == .pizza {
			if dishNameSegment.selectedSegmentIndex == -1 || pizzaSizeSegment.selectedSegmentIndex == -1 || pizzaDoughTypeSegment.selectedSegmentIndex == -1 {
				createOkAlertController()
				return false
			}
		} else if menuType == .sushi {
			if dishNameSegment.selectedSegmentIndex == UISegmentedControl.noSegment {
				createOkAlertController()
				return false
			}
		}
		return true
	}
	
	private func createOkAlertController() {
		let alert = UIAlertController(title: "Внимание", message: "Выберите все опции для заказа!", preferredStyle: .alert)
		let okAction = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
		alert.addAction(okAction)
		self.present(alert, animated: true, completion: nil)
		
	}
}



//MARK: - custom selectors
extension OrderViewController {
	
	@objc private func stepperTapped(_ sender: UIStepper) {
		amountLabel.text = String(Int(sender.value)) + " шт"
	}
	
	@objc private func makeOrderButtonTapped(_ sender: UIButton) {
		guard checkAllSegmentsSelected() else { return }
		if sender == makeOrderButton {
			let alert = UIAlertController(title: "Благодорим за заказ", message: "Уже начали готовить!\nCкоро привезём ;)", preferredStyle: .alert)
			
			if comeFromQuiz {
				let continueQuizAction = UIAlertAction(title: "К викторине", style: .destructive) { (_) in
					self.dismiss(animated: true, completion: nil)
				}
				let goToStartVCAction = UIAlertAction(title: "В начало", style: .default) { (_) in
					self.presentingViewController?.dismiss(animated: true, completion: nil)
					self.presentingViewController?.dismiss(animated: true, completion: nil)
				}
				alert.addAction(goToStartVCAction)
				alert.addAction(continueQuizAction)
			} else {
				let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
					self.presentingViewController?.modalTransitionStyle = .flipHorizontal
					self.presentingViewController?.dismiss(animated: true, completion: nil)
					self.presentingViewController?.dismiss(animated: true, completion: nil)
				}
				alert.addAction(okAction)
			}
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	@objc private func dishNameSegmentControlChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
			case 0:
				mainImage.image = elements[0].image
				dishNameLabel.text = elements[0].correctAnswer
			case 1:
				mainImage.image = elements[1].image
				dishNameLabel.text = elements[1].correctAnswer
			case 2:
				mainImage.image = elements[2].image
				dishNameLabel.text = elements[2].correctAnswer
			case 3:
				mainImage.image = elements[3].image
				dishNameLabel.text = elements[3].correctAnswer
			default:
				mainImage.image = elements[0].image
				dishNameLabel.text = elements[0].correctAnswer
		}
	}
}

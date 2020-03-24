//
//  QuizViewController.swift
//  Lesson7_homework
//
//  Created by MacBook Air on 22.03.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit
import Lottie

class QuizViewController: UIViewController {
	
	//create class properties (variables)
	var mainImageView = UIImageView()
	var answersSegmentControl = UISegmentedControl()
	var countQuestionLabel = UILabel()
	var makeOrderLabel = UILabel()
	let makeOrderButton = UIButton(type: .roundedRect)
	var currentQuestion = 1 {
		didSet {
			if self.currentQuestion <= questions.count {
				reloadViewsData()
			} else {
				self.currentQuestion = oldValue
			}
		}
	}
	var questions = [Question]()
	var quizType = QuestionType.pizza
	var totalResult = 0
	let trueAnimationView = AnimationView(name: "899-like") //Best #1
	let falseAnimationView = AnimationView(name: "11201-fail") //#1 as NO
	weak var delegate: OpenResultVCProtocol?
//	let trueAnimationView = AnimationView(name: "5785-checkmark") //MAY be as true! #2
//	let trueAnimationView = AnimationView(name: "2391-like") //MAY be as true! #3
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        configurateVC()
    }

}



//MARK: - custom methods for this View Controller
extension QuizViewController {
	
	private func configurateVC() {
		
		view.backgroundColor = .white
		answersSegmentControl = UISegmentedControl(items: questions[currentQuestion - 1].answerOptions)
		
		makeOrderLabel.frame = CGRect(x: 15, y: 50, width: 230, height: 40)
		makeOrderButton.frame = CGRect(x: view.frame.width - 175, y: 0, width: 160, height: 44)
		makeOrderButton.center.y = makeOrderLabel.center.y
		
		countQuestionLabel.frame = CGRect(x: 0, y: makeOrderLabel.frame.maxY + 30, width: 120, height: 30)
		countQuestionLabel.center.x = view.center.x
		mainImageView.frame = CGRect(x: 0, y: countQuestionLabel.frame.maxY + 5, width: view.frame.width - 40, height: 400)
		mainImageView.center.x = view.center.x
		mainImageView.contentMode = .scaleAspectFit
		answersSegmentControl.frame = CGRect(x: 0, y: view.frame.height - 150, width: view.frame.width - 20, height: 60)
		answersSegmentControl.center.x = view.center.x
		
		countQuestionLabel.textAlignment = .center
		countQuestionLabel.text = "\(currentQuestion) из 8"
		countQuestionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		makeOrderLabel.text = "Надоело, хочу уже есть..."
		makeOrderLabel.textColor = .darkGray
		makeOrderButton.setTitle("Сделать заказ", for: .normal)
		countQuestionLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
		makeOrderButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
		makeOrderButton.layer.borderWidth = 1
		makeOrderButton.layer.cornerRadius = 10
		makeOrderButton.layer.borderColor = makeOrderButton.titleColor(for: .normal)?.cgColor
		
		answersSegmentControl.contentMode = .scaleAspectFill
		mainImageView.image = questions[currentQuestion - 1].image
		if quizType == .pizza {
			answersSegmentControl.setTitleTextAttributes([.font:UIFont.systemFont(ofSize: 14, weight: .medium)], for: .normal)
		} else if quizType == .sushi {
			answersSegmentControl.setTitleTextAttributes([.font:UIFont.systemFont(ofSize: 12, weight: .medium)], for: .normal)
		}
		
		
		makeOrderButton.addTarget(self, action: #selector(makeOrderButtonTapped), for: .touchUpInside)
		answersSegmentControl.addTarget(self, action: #selector(segmentControlSelected), for: .valueChanged)
		answersSegmentControl.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.9215686275, alpha: 1)
		answersSegmentControl.isMomentary = true
		answersSegmentControl.isSpringLoaded = true
		
		falseAnimationView.alpha = 0
		falseAnimationView.frame = CGRect(x: 20, y: 400, width: 48, height: 48)
		falseAnimationView.animationSpeed = 1.4
		falseAnimationView.loopMode = .loop
		trueAnimationView.alpha = 0
		trueAnimationView.frame = CGRect(x: 20, y: 400, width: 110, height: 110)
		trueAnimationView.animationSpeed = 2.5
		trueAnimationView.loopMode = .loop
		
		Helper.shared.addSubviews(views: [mainImageView, countQuestionLabel, makeOrderLabel, makeOrderButton, answersSegmentControl, trueAnimationView, falseAnimationView], to: view)
	}
	
	private func correctAnswerSegmentIndex() -> Int {
		let correctAnswer = questions[currentQuestion - 1].correctAnswer
		switch correctAnswer {
			case answersSegmentControl.titleForSegment(at: 0): return 0
			case answersSegmentControl.titleForSegment(at: 1): return 1
			case answersSegmentControl.titleForSegment(at: 2): return 2
			case answersSegmentControl.titleForSegment(at: 3): return 3
			default: return 4
		}
	}
	
	private func reloadViewsData() {
		UIView.animate(withDuration: 0.4) {
			self.countQuestionLabel.text = "\(self.currentQuestion) из 8"
			self.mainImageView.image = self.questions[self.currentQuestion - 1].image
			self.answersSegmentControl.setTitle(self.questions[self.currentQuestion - 1].answerOptions[0], forSegmentAt: 0)
			self.answersSegmentControl.setTitle(self.questions[self.currentQuestion - 1].answerOptions[1], forSegmentAt: 1)
			self.answersSegmentControl.setTitle(self.questions[self.currentQuestion - 1].answerOptions[2], forSegmentAt: 2)
			self.answersSegmentControl.setTitle(self.questions[self.currentQuestion - 1].answerOptions[3], forSegmentAt: 3)
		}
	}
	
	private func checkEndQuiz() -> Bool {
		return currentQuestion >= questions.count
	}
	
	//flying up animations while segment buttons tapped, depends on true or false answer - different animations
	private func makeAnimation(with origin: CGPoint, and correct: Bool) {
		if correct {
			trueAnimationView.play()
			trueAnimationView.alpha = 1
			self.trueAnimationView.center = origin
			UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: {
				self.trueAnimationView.frame.origin.y -= 80
				self.trueAnimationView.alpha = 0
			}) { (_) in
				self.trueAnimationView.stop()
			}
		} else {
			falseAnimationView.play()
			falseAnimationView.alpha = 1
			self.falseAnimationView.center = origin
			UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: {
				self.falseAnimationView.frame.origin.y -= 80
				self.falseAnimationView.alpha = 0
			}) { (_) in
				self.falseAnimationView.stop()
			}
		}
	}
	
}


//MARK: - custom objc selectors for this view controller
extension QuizViewController {
	
	@objc private func makeOrderButtonTapped(_ sender: UIButton) {
		if sender == makeOrderButton {
			let orderVC = OrderViewController()
			orderVC.menuType = quizType
			orderVC.modalPresentationStyle = .pageSheet
			orderVC.comeFromQuiz = true
			self.present(orderVC, animated: true, completion: nil)
		}
	}
	
	
	@objc private func segmentControlSelected(_ sender: UISegmentedControl) {
		
		let index = sender.selectedSegmentIndex
		let selectedSegmentCenterPosition = CGPoint(x: answersSegmentControl.frame.origin.x + answersSegmentControl.subviews[index].center.x, y: answersSegmentControl.frame.origin.y + 20)
		
		if sender.selectedSegmentIndex == correctAnswerSegmentIndex() {
			answersSegmentControl.selectedSegmentTintColor = #colorLiteral(red: 0.4196078431, green: 1, blue: 0.6392156863, alpha: 1)
			makeAnimation(with: selectedSegmentCenterPosition, and: true)
		} else {
			answersSegmentControl.selectedSegmentTintColor = #colorLiteral(red: 1, green: 0.4509803922, blue: 0.3607843137, alpha: 1)
			makeAnimation(with: selectedSegmentCenterPosition, and: false)
		}
		
		let selectedTitle = answersSegmentControl.titleForSegment(at: answersSegmentControl.selectedSegmentIndex)
		if selectedTitle == questions[currentQuestion - 1].correctAnswer {
			totalResult += 1
		}
		if checkEndQuiz() {
			let resultVC = ResultQuizViewController()
			resultVC.resultPoints = totalResult
			resultVC.resultType = quizType
			self.modalTransitionStyle = .coverVertical
			self.presentingViewController?.modalTransitionStyle = .coverVertical
			self.dismiss(animated: true) {
				self.delegate?.presentResultVC(with: self.quizType, count: self.totalResult)
			}
		}
		self.currentQuestion += 1
	}
	
}

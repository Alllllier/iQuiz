//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Jue Chen on 11/5/18.
//  Copyright © 2018 Jue Chen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
  var questions: [Question] = []
  var currentQuestion : Question?
  var currentAnswer: String = ""
  var numCorrect = 0;
  var numTotal = 0;
  var urlString = ""
  
  @IBOutlet weak var questionLabel: UILabel!
  
  @IBOutlet weak var bt1: UIButton!
  @IBOutlet weak var bt2: UIButton!
  @IBOutlet weak var bt3: UIButton!
  @IBOutlet weak var bt4: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    currentQuestion = questions.removeLast();
    questionLabel.text = currentQuestion?.text
    bt1.setTitle(currentQuestion?.answers[0], for: .normal)
    bt2.setTitle(currentQuestion?.answers[1], for: .normal)
    bt3.setTitle(currentQuestion?.answers[2], for: .normal)
    bt4.setTitle(currentQuestion?.answers[3], for: .normal)
  }
  
  @IBAction func answerClicked(_ sender: UIButton) {
    currentAnswer = String(sender.tag + 1)
    
    bt1.setTitleColor(UIColor.blue, for: .normal)
    bt2.setTitleColor(UIColor.blue, for: .normal)
    bt3.setTitleColor(UIColor.blue, for: .normal)
    bt4.setTitleColor(UIColor.blue, for: .normal)

    sender.setTitleColor(UIColor.red, for: .normal)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "questionToAnswer" {
      let answerVC = segue.destination as! AnswerViewController
      answerVC.question = (currentQuestion?.text)!
      answerVC.answer = (currentQuestion?.answers[Int((currentQuestion?.answer)!)! - 1])!
      answerVC.isCorrect = currentAnswer == currentQuestion?.answer
      answerVC.questionsLeft = questions
      answerVC.numCorrect = numCorrect
      answerVC.numTotal = numTotal
      answerVC.urlString = urlString
    }
  }
}

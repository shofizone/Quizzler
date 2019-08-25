//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions  = QuestionBank()
    var pickedAns : Bool = false
    var questionNumber : Int  = 0
    var score : Int  = 0

    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAns  = true
        }else if sender.tag == 2 {
            pickedAns  = false
        }
     let ans = checkAnswer(index: questionNumber)
        if ans {score+=1}
        nextQuestion()
        updateUI()
    }
    
    
    func updateUI() {
      questionLabel.text = allQuestions.list[questionNumber].questionText
        scoreLabel.text = String(score)
        progressLabel.text  = "\(questionNumber+1)/\(allQuestions.list.count)"
        
        let width = CGFloat(view.frame.size.width) / CGFloat(allQuestions.list.count)
        
        
        progressBar.frame.size.width  = width * CGFloat(questionNumber+1)
        
    }
    

    func nextQuestion() {
        
        if questionNumber < allQuestions.list.count-1 {
            questionNumber+=1
        }else{
            let alert  = UIAlertController(
                title: "Awesome",
                message: "You have finished all the question, do you want start over?",
                preferredStyle: .alert
            )
            
            let  restartAction = UIAlertAction(
                title: "Restart", style:.default,  handler: {
                    (UIAlertAction) in
                    self.startOver()
            }
            )
            alert.addAction(restartAction)
            present(alert,animated: true,completion: nil)
        }
        
        
    }
    
    
    func checkAnswer(index: Int)-> Bool {
        
        let correctAnswer  = allQuestions.list[index].answer
        if correctAnswer == pickedAns {
            ProgressHUD.showSuccess("Correct")
            return true
        }else{
            ProgressHUD.showError("Wrong")
             return false
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        
        updateUI()
    }
    

    
}

//
//  HomeScreenController.swift
//  QuizTastic
//
//  Created by Wayne Rumble on 12/08/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet var lastScoreText: UITextView!
    @IBOutlet var quizTasticLogoImage: UIImageView!
    @IBOutlet var startQuizButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createQuestionsArray()
        
        self.quizTasticLogoImage.image = UIImage(named: "QuiztasticLogo.png")
        self.lastScoreText.text = getHomeScreenText()
        UINavigationBar.appearance().setTitleVerticalPositionAdjustment(CGFloat(10), forBarMetrics: UIBarMetrics.Default)
        self.startQuizButton.titleLabel?.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        
    }
    
    func getHomeScreenText() -> String {
        let scoreHelper = ScoreHelper()
        if scoreHelper.hasPlayedBefore() {
            return "Welcome back! Your last score was \(scoreHelper.getScore()). Can you beat that?"
        }
        return "You haven't completed a quiz yet. Click 'Start a new quiz' to log your first score"
    }
    
    func createQuestionsArray() {
        QuestionManager.sharedInstance.createRandomQuestionsArray()
    }
    
    @IBAction func startNewQuizWasPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("segueToNewQuiz", sender: self)
    }
    
}
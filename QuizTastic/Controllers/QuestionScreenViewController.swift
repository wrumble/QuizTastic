//
//  QuestionScreenController.swift
//  QuizTastic
//
//  Created by Wayne Rumble on 12/08/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//
import UIKit

class QuestionScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var choicesTableView: UITableView!
    @IBOutlet var questionImage: UIImageView!
    @IBOutlet var questionCount: UILabel!
    
    var selectedCellIndex: Int! = -1
    var scoreHelper: ScoreHelper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scoreHelper = ScoreHelper()
        
        self.questionImage.image = UIImage(named: QuestionManager.sharedInstance.questions[0].imageFileName!)
        self.questionCount.text = "\(11 - QuestionManager.sharedInstance.questions.count)/10"
        
        UINavigationBar.appearance().setTitleVerticalPositionAdjustment(CGFloat(10), forBarMetrics: UIBarMetrics.Default)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ChoicesTableViewCell = tableView.dequeueReusableCellWithIdentifier("choiceCell") as! ChoicesTableViewCell
        cell.choiceLabel.text = QuestionManager.sharedInstance.questions[0].choices[indexPath.row]
        cell.selectedCellImage.image = UIImage(named: "")
        
        switch indexPath.row {
            case 0:
                cell.backgroundColor = UIColor(red: 170/255.0, green: 250/255.0, blue: 200/255.0, alpha: 1.0)
            case 1:
                cell.backgroundColor = UIColor(red: 199/255.0, green: 255/255.0, blue: 237/255.0, alpha: 1.0)
            case 2:
                cell.backgroundColor = UIColor(red: 187/255.0, green: 200/255.0, blue: 202/255.0, alpha: 1.0)
            case 3:
                cell.backgroundColor = UIColor(red: 181/255.0, green: 146/255.0, blue: 160/255.0, alpha: 1.0)
            default:
                cell.backgroundColor = UIColor.whiteColor()
            }
        
        // if selectedCellIndex != 0 then the user answered, so display right or wrong icon
        if selectedCellIndex == indexPath.row {
            if QuestionManager.sharedInstance.questions[0].choices[self.selectedCellIndex] == QuestionManager.sharedInstance.questions[0].answer {
                cell.selectedCellImage.image = UIImage(named: "correct.png")
            } else {
                cell.selectedCellImage.image = UIImage(named: "wrong.png")
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (choicesTableView.frame.height) / 4
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedCellIndex = indexPath.row
        calculateCurrentScore(self.selectedCellIndex)
        tableView.reloadData()
        let hasEnded: Bool = hasQuizEnded()
        if hasEnded {
//            self.performSegueWithIdentifier("segueToFinishedQuiz", sender: self)
            print("quiz ended")
        } else {
            // this will make it advance to next question after delay
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.advanceQuestionAndRedraw()
            }
        }
    }
    
    func calculateCurrentScore(indexPath: Int) {
        if QuestionManager.sharedInstance.questions[0].choices[indexPath] == QuestionManager.sharedInstance.questions[0].answer {
            let currentScoreValue: Int = scoreHelper.getPlayingScore()
            scoreHelper.savePlayingScore(currentScoreValue + 1)
        }
        
    }
    
    func advanceQuestionAndRedraw() {
        QuestionManager.sharedInstance.questions.removeAtIndex(0)
        self.selectedCellIndex = -1
        self.questionImage.image = UIImage(named: QuestionManager.sharedInstance.questions[0].imageFileName!)
        self.questionCount.text = "\(11 - QuestionManager.sharedInstance.questions.count)/10"
        self.choicesTableView.reloadData()
    }
    
    func hasQuizEnded() -> Bool {
        if QuestionManager.sharedInstance.questions.count == 1 {
            return true
        }
        return false
    }
    
}

//
//  QuestionHelper.swift
//  QuizTastic
//
//  Created by Wayne Rumble on 16/08/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import Foundation

class QuestionManager {
    
    static let sharedInstance = QuestionManager()
    
    var allQuestions: [Question]!
    var questions: [Question]!
    
    private init() {
    }
    
    func createRandomQuestionsArray() {
        self.questions = []
        let json = ParseJSONData()
        self.allQuestions = json.createQuestionObjectsFromJSON()
        while self.questions.count < 10 {
            let randomIndex = Int(arc4random_uniform(UInt32(self.allQuestions.count)))
            questions.append(self.allQuestions[randomIndex])
            self.allQuestions.removeAtIndex(randomIndex)
        }
    }

}


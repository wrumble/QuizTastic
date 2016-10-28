//
//  ParseJSONData.swift
//  QuizTastic
//
//  Created by Wayne Rumble on 12/08/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import Foundation
import Freddy

class ParseJSONData {
    
    var questions: [Question]?
    var fileName: String = "QuizData"
    var fileType: String = ".json"
    
    func createQuestionObjectsFromJSON() -> [Question] {
        
        self.questions = []
        let filePath = NSBundle.mainBundle().pathForResource(self.fileName, ofType: self.fileType)
        if let data = NSData(contentsOfFile:filePath!) {
            do {
                let json = try JSON(data: data)
                for questionJSON in try json.array("quiz") {
                    var question = Question()
                    var choicesArray = [String]()
                    question.question = try questionJSON.string("question")
                    for choice in try questionJSON.array("choices") {
                        choicesArray.append(String(choice))
                    }
                    question.choices = choicesArray
                    question.answer = try questionJSON.string("answer")
                    question.imageFileName = try questionJSON.string("imageFileName")
                    self.questions?.append(question)
                }
            } catch {
                print("Error parsing questions part of JSON file")
            }
        }
        
        return questions!
        
    }
    
}

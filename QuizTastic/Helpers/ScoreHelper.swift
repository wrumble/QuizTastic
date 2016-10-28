//
//  ScoreHelper.swift
//  QuizTastic
//
//  Created by Wayne Rumble on 16/08/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import Foundation

class ScoreHelper {
    
    func saveScore(score: Int) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(score, forKey: "lastScore")
        userDefaults.synchronize()
    }
    
    func getScore() -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let lastScore = userDefaults.valueForKey("lastScore")
        if lastScore == nil {
            return -1
        }
        return (lastScore?.integerValue)!
    }
    
    func hasPlayedBefore() -> Bool {
        if getScore() == -1 {
            return false
        }
        return true
    }
    
    func savePlayingScore(playingScore: Int) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(playingScore, forKey: "playingScore")
        userDefaults.synchronize()
    }
    
    func getPlayingScore() -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let playingScoreValue = userDefaults.valueForKey("playingScore")
        if playingScoreValue == nil {
            return 0
        }
        let playingScore = playingScoreValue?.integerValue
        return playingScore!
    }
    
}
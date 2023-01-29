//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import XCTest

@testable import QuizAppTDD

final class GameScoreManagerTest: XCTestCase {
    let sut = GameScoreManager()
    
    override func setUp() {
        sut.startGame()
    }
    
    ///    Given: Player is not playing a game
    ///    When: Player starts a game
    ///    Then: Player initial score, combo bonus, and combo multiplier set to 0
    func testStartGame_initialScore_comboBonus_comboMultiplier_sholdSetZero() {
        XCTAssertEqual(sut.score, 0)
        XCTAssertEqual(sut.comboBonus, 0)
        XCTAssertEqual(sut.comboMultiplier, 0)
    }
    
    ///    Given: Player is playing a game
    ///    When: Player selects a correct answer
    ///    Then: Player score increases by 10
    func testSelectsACorrectAnswer_scoreIncreasesByTen_whenPlayerIsPlayingAGame() {
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.score, 10)
        
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.score, 20)
    }
    
    ///    Given: Player is playing a game
    ///    When: Player selects correct answer
    ///    Then: Player combo bonus increases by 5 times combo multiplier
    func testSelectCorrectAnswer_comboBonusIncreasesByFiveTimesComboMultiplier() {
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.comboBonus, 0)
        
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.comboBonus, 5)
        
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.comboBonus, 15)
    }
    
    ///    Given: Player selected a correct answer
    ///    When: Player combo bonus already increase
    ///    Then: Player combo multiplier increases by 1
    func testSelectCorrectAnswer_comboMultiplierIncreasesByOne() {
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.comboMultiplier, 1)
        
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.comboMultiplier, 2)
        
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.comboMultiplier, 3)
    }
    
    ///    Given: Player is playing a game
    ///    When: Player selects a wrong answer
    ///    Then: Player score decreases by 5
    func testSelectWrongAnswer_scoreDecreasesByFive() {
        sut.selectWrongAnswer()
        XCTAssertEqual(sut.score, -5)
        
        sut.selectWrongAnswer()
        XCTAssertEqual(sut.score, -10)
    }
    
    ///    Given: Player selected correct answer
    ///    When: Player selects a wrong answer
    ///    Then: Player score increases by combo bonus
    func testSelectWrongAnswer_scoreIncreasesByComboBonus() {
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        
        sut.selectWrongAnswer()
        
        XCTAssertEqual(sut.score, 20)
    }
    
    ///    Given: Player selected correct answer
    ///    When: Player selects a wrong answer
    ///    Then: Player combo bonus and multiplier resets to 0
    func testSelectWrongAnswer_comboBonusAndMultiplierResetsToZero() {
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        
        sut.selectWrongAnswer()
        
        XCTAssertEqual(sut.comboBonus, 0)
        XCTAssertEqual(sut.comboMultiplier, 0)
    }
    
    ///    Given: Player is playing a game
    ///    When: Player ends the game
    ///    Then: Player score added by the current combo bonus
    func testEndsGame_scoreAddedByCurrentComboBonus() {
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        
        sut.endGame()
        
        XCTAssertEqual(sut.score, 45)
    }
    
    ///    Given: Player is already playing game and then ends the game
    ///    When: Player start playing a game again
    ///    Then: Player score, combo bonus and multiplier resets to 0
    func testStartGame_scoreComboBonusAndMultiplierResetsToZero_afterPreviousGame() {
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        sut.endGame()
        XCTAssertEqual(sut.score, 25)
        
        sut.startGame()
        
        XCTAssertEqual(sut.score, 0)
        XCTAssertEqual(sut.comboBonus, 0)
        XCTAssertEqual(sut.comboMultiplier, 0)
    }
}

//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import XCTest

@testable import QuizAppTDD

final class GameScoreManagerTest: XCTestCase {
    let sut = GameScoreManager()
    
    ///    Given: Player is not playing a game
    ///    When: Player starts a game
    ///    Then: Player initial score, combo bonus, and combo multiplier set to 0
    func testStartGame_initialScore_comboBonus_comboMultiplier_sholdSetZero() {
        sut.startGame()
        
        XCTAssertEqual(sut.score, 0)
        XCTAssertEqual(sut.comboBonus, 0)
        XCTAssertEqual(sut.comboMultiplier, 0)
    }
    
    ///    Given: Player is playing a game
    ///    When: Player selects a correct answer
    ///    Then: Player score increases by 10
    func testSelectsACorrectAnswer_scoreIncreasesByTen_whenPlayerIsPlayingAGame() {
        sut.startGame()
        
        sut.selectCorrectAnswer()
        
        XCTAssertEqual(sut.score, 10)
    }
    
    ///    Given: Player is playing a game and selected correct answer
    ///    When: Player selects another correct answer
    ///    Then: Player score increases again by 10
    func testSelectAnotherCorrectAnswer_scoreIncreasesAgainByTen_whenSelectedCorrectAnswer() {
        sut.startGame()
        sut.selectCorrectAnswer()
        
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.score, 20)
    }
    
    ///    Given: Player is playing a game
    ///    When: Player selects correct answer
    ///    Then: Player combo bonus increases by 5 times combo multiplier
    func testSelectCorrectAnswer_comboBonusIncreasesByFiveTimesComboMultiplier() {
        sut.startGame()
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.comboBonus, 0)
        
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.comboBonus, 5)
    }
    
    ///    Given: Player selected a correct answer
    ///    When: Player combo bonus already increase
    ///    Then: Player combo multiplier increases by 1
    func testSelectCorrectAnswer_comboMultiplierIncreasesByOne() {
        sut.startGame()
        sut.selectCorrectAnswer()
        
        XCTAssertEqual(sut.comboMultiplier, 1)
    }
    
    ///    Given: Player combo multiplier is 1
    ///    When: Player selected a correct answer
    ///    Then: Player combo multiplier increases to 2
    func testSelectCorrectAnswer_comboMultiplierIncreasesToTwo() {
        sut.startGame()
        sut.comboMultiplier = 1
        
        sut.selectCorrectAnswer()
        
        XCTAssertEqual(sut.comboMultiplier, 2)
    }
    
    ///    Given: Player is playing a game
    ///    When: Player selects a wrong answer
    ///    Then: Player score decreases by 5
    func testSelectWrongAnswer_scoreDecreasesByFive() {
        sut.startGame()
        sut.selectWrongAnswer()
        
        XCTAssertEqual(sut.score, -5)
    }
    
    ///    Given: Player selected correct answer
    ///    When: Player selects a wrong answer
    ///    Then: Player score increases by combo bonus
    func testSelectWrongAnswer_scoreIncreasesByComboBonus_whenSelectedCorrectAnswer() {
        sut.startGame()
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        
        sut.selectWrongAnswer()
        
        XCTAssertEqual(sut.score, 20)
    }
    
    ///    Given: Player selected correct answer
    ///    When: Player selects a wrong answer
    ///    Then: Player combo bonus and multiplier resets to 0
    func testSelectWrongAnswer_comboBonusAndMultiplierResetsToZero() {
        sut.startGame()
        sut.selectCorrectAnswer()
        
        sut.selectWrongAnswer()
        
        XCTAssertEqual(sut.score, 5)
        XCTAssertEqual(sut.comboBonus, 0)
        XCTAssertEqual(sut.comboMultiplier, 0)
    }
    
    ///    Given: Player is playing a game
    ///    When: Player ends the game
    ///    Then: Player score added by the current combo bonus
    func testEndsGame_scoreAddedByCurrentComboBonus() {
        sut.startGame()
        sut.endGame()
        
        XCTAssertEqual(sut.score, 0)
    }
    
    ///    Given: Player is playing a game and select some correct answer
    ///    When: Player ends the game
    ///    Then: Player score added by the current combo bonus
    func testEndsGame_scoreAddedByCurrentComboBonus_whenSelectSomeCorrectAnswer() {
        sut.startGame()
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        
        sut.endGame()
        
        XCTAssertEqual(sut.score, 45)
    }
    
    ///    Given: Player is already playing game and then ends the game
    ///    When: Player start playing a game again
    ///    Then: Player score, combo bonus and multiplier resets to 0
    func testStartGame_scoreComboBonusAndMultiplierResetsToZero() {
        sut.startGame()
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

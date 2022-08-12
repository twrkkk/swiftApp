 //
//  GameViewController.swift
//  test2
//
//  Created by xcode on 10/08/2022.
//  Copyright © 2022 vsu. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    lazy var game = Game(countItems: buttons.count, time: 30) { [weak self] (status, time) in
        guard let self = self else {return}
        
        self.timerLabel.text = time.secondsToString()//time.secondsToString()
        self.updateInfoGame(with: status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreen() 
    }

    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index: buttonIndex)
        
        updateUI()
    } 
    
    private func setupScreen()
    {
        for index in game.items.indices{
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI(){
        for index in game.items.indices{
            buttons[index].alpha = game.items[index].isFound ? 0 : 1 
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError{
                UIView.animate(withDuration: 0.3, animations: { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                }) { [weak self] (_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }
            }
            
        }
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status: StatusGame){
        switch status{
        case .start:
            statusLabel.text = "Let's go!"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .lose:
            statusLabel.text = "You're lose!"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
        case .win:
            statusLabel.text = "You're win!"
            statusLabel.textColor = .green
            newGameButton.isHidden = false
        }
    }
    
 }

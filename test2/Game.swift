//
//  Game.swift
//  test2
//
//  Created by xcode on 10/08/2022.
//  Copyright © 2022 vsu. All rights reserved.
//

import Foundation

enum StatusGame{
    case start
    case win
    case lose
}

class Game{
    
    struct Item{
        var title: String
        var isFound: Bool = false
        var isError: Bool = false
    }
    
    var data = [1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    70,
    71,
    72,
    73,
    74,
    75,
    76,
    77,
    78,
    79,
    80,
    81,
    82,
    83,
    84,
    85,
    86,
    87,
    88,
    89,
    90,
    91,
    92,
    93,
    94,
    95,
    96,
    97,
    98,
    99]
   
    var items:[Item] = []
    
    var nextItem:Item?
    
    var status:StatusGame = .start{
        didSet{
            if status != .start{
                stopGame()
            }
        }
    }
    
    private var countItems:Int
    private var timeForGame:Int
    private var secondsGame:Int{
        didSet{
            if secondsGame == 0{
                status = .lose
            }
            updateTimer(status, secondsGame)

        }
    }
    private var timer:Timer?
    private var updateTimer:((StatusGame, Int)->Void)
    
    init(countItems:Int, time:Int, updateTimer: @escaping (_ status:StatusGame, _ seconds:Int)->Void){
        self.countItems = countItems
        self.secondsGame = time
        self.timeForGame = time
        self.updateTimer = updateTimer
        setupGame()
    }
    
    private func setupGame()
    {
        var digits = data.shuffled()
        items.removeAll()
        while items.count < countItems
        {
            let item = Item(title: "\(digits.removeFirst())", isFound: false)
            items.append(item)
        }
        
        nextItem = items.shuffled().first
        
        updateTimer(status, secondsGame)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (_) in
            self?.secondsGame -= 1
        })
    }
    
    func newGame(){
        status = .start
        self.secondsGame = self.timeForGame 
        setupGame()
    }
    
    func check(index:Int){
        guard status == .start else {return}
        if items[index].title == nextItem?.title{
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { (item) -> Bool in item.isFound == false })
        }
        else{
            items[index].isError = true
        }
        
        if nextItem == nil{
            status = .win
        }
    }
    
    private func stopGame()
    {
        timer?.invalidate()
    }
    
}


extension Int{
    func secondsToString() -> String{
        let minutes = self / 60
        let seconds = self % 60
        
        return String(format: "%d:%02d", minutes, seconds)
    }
}

//
//  ViewController.swift
//  iOS_advanced_labTest1
//
//  Created by Litson Thomas on 2022-01-18.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var winner_text: UILabel!
    @IBOutlet weak var player_x_score_text: UITextView!
    @IBOutlet weak var player_o_score_text: UITextView!
    @IBOutlet weak var player_turn_text: UITextView!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    var buttons = [UIButton]();
    var tac_toe = TacToe(player: Turn.X, value: "O", x_score: 0, o_score: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        appendAllButtons();
        player_turn_text.text = tac_toe.get_player_turn_text()
        tac_toe.set_buttons(btns: buttons) // set the tac toe buttons
        // apply the button style to all the buttons
        for btn in buttons {
            myButton(button: btn);
        }
        tac_toe.reset_tiles()
        // initiate the swipe gestures
        initSwipeGestures()
    }
    
    // method to initialize the gesture to enable the gesture to reset the game if a gesture is triggered!
    func initSwipeGestures(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func swiped(gesture: UISwipeGestureRecognizer){
        switch gesture.direction{
        case UISwipeGestureRecognizer.Direction.left:
            start_new_game()
        case UISwipeGestureRecognizer.Direction.right:
            start_new_game()
        case UISwipeGestureRecognizer.Direction.down:
            start_new_game()
        case UISwipeGestureRecognizer.Direction.up:
            start_new_game()
        default:
            break
        }
    }
    
    // method that reset the whole game where the scores are all reset to 0
    func start_new_game(){
        reset_game()
        tac_toe.set_player_o_score(score: 0)
        tac_toe.set_player_x_score(score: 0)
        update_score()
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        if(sender.currentBackgroundImage == UIImage(named: "blank")){
            if(winner_text.text != "") {
                winner_text.text = ""
            }
            sender.setBackgroundImage(tac_toe.get_player_image(), for: .normal)
            player_turn_text.text = tac_toe.get_player_turn_text()
            tac_toe.check_game_completion()
            winner_text.text = tac_toe.get_winner_text()
            update_score()
        }
    }
    
    // method to reset game
    func reset_game(){
        tac_toe.reset_tiles()
        winner_text.text = ""
    }
    
    // method to update score
    func update_score(){
        player_o_score_text.text = tac_toe.get_player_o_score()
        player_x_score_text.text = tac_toe.get_player_x_score()
    }
    
    // method to append all the buttons to the button array
    // need to call this method in the first run of the app
    func appendAllButtons(){
        buttons.append(a1)
        buttons.append(a2)
        buttons.append(a3)
        buttons.append(b1)
        buttons.append(b2)
        buttons.append(b3)
        buttons.append(c1)
        buttons.append(c2)
        buttons.append(c3)
    }

}


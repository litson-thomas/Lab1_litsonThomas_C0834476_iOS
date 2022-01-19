//
//  TacToe.swift
//  Lab1_litsonThomas_C0834476_iOS
//
//  Created by Litson Thomas on 2022-01-18.
//

import UIKit

// set and enum for both the players X and O
enum Turn{
    case O
    case X
}

class TacToe {
    var current_player: Turn
    var current_player_text: String
    var player_x_score: Int
    var player_o_score: Int
    var buttons = [UIButton]()
    var winner_text: String = ""
    
    init(player: Turn, value: String, x_score: Int, o_score: Int){
        self.current_player = player
        self.current_player_text = value
        self.player_o_score = o_score
        self.player_x_score = x_score
    }
    
    // method to check if the game is complete or not
    func check_game_completion(){
        var tiles_completed = 0;
        for btn in buttons {
            if(btn.currentBackgroundImage == UIImage(named: "blank")){
                tiles_completed += 1
            }
        }
        if(tiles_completed <= 0){
            reset_tiles()
            winner_text = "Game is a Draw!"
        }
        else{
            check_player_win()
        }
    }
    
    func check_player_win(){
        let if_x_win = check_for_winner(value: "x");
        let if_o_win = check_for_winner(value: "o");
        if(if_x_win) {
            inc_player_x_score()
            reset_tiles()
            winner_text = "Player X Won!"
        }
        if(if_o_win) {
            inc_player_o_score()
            reset_tiles()
            winner_text = "Player O Won!"
        }
    }
    
    func check_for_winner(value: String) -> Bool{
        // horizontal tiles check
        if if_button_has_value(button: buttons[0], value: value) && if_button_has_value(button: buttons[1], value: value) && if_button_has_value(button: buttons[2], value: value){
            return true
        }
        if if_button_has_value(button: buttons[3], value: value) && if_button_has_value(button: buttons[4], value: value) && if_button_has_value(button: buttons[5], value: value){
            return true
        }
        if if_button_has_value(button: buttons[6], value: value) && if_button_has_value(button: buttons[7], value: value) && if_button_has_value(button: buttons[8], value: value){
            return true
        }
        // vertical tiles check
        if if_button_has_value(button: buttons[0], value: value) && if_button_has_value(button: buttons[3], value: value) && if_button_has_value(button: buttons[6], value: value){
            return true
        }
        if if_button_has_value(button: buttons[1], value: value) && if_button_has_value(button: buttons[4], value: value) && if_button_has_value(button: buttons[7], value: value){
            return true
        }
        if if_button_has_value(button: buttons[2], value: value) && if_button_has_value(button: buttons[5], value: value) && if_button_has_value(button: buttons[8], value: value){
            return true
        }
        // diagnol tiles check
        if if_button_has_value(button: buttons[0], value: value) && if_button_has_value(button: buttons[4], value: value) && if_button_has_value(button: buttons[8], value: value){
            return true
        }
        if if_button_has_value(button: buttons[2], value: value) && if_button_has_value(button: buttons[4], value: value) && if_button_has_value(button: buttons[6], value: value){
            return true
        }
        
        return false
    }
    
    func if_button_has_value(button: UIButton, value: String) -> Bool{
        var response = false
        if(value == "x"){
            if(button.currentBackgroundImage == UIImage(named: "x")){
                response = true;
            }
        }
        if(value == "o"){
            if(button.currentBackgroundImage == UIImage(named: "o")){
                response = true;
            }
        }
        return response
    }
    
    // method to reset all tiles to blank
    func reset_tiles(){
        // reset all the tiles buttons to blank image
        for btn in buttons {
            btn.setBackgroundImage(UIImage.init(named: "blank"), for: .normal); // reset all the buttons to blank
        }
    }
    
    func reset_score(){
        player_x_score = 0
        player_o_score = 0
    }
    
    func get_player_image() -> UIImage{
        var image = UIImage()
        if(current_player == Turn.O){
            image = UIImage(named: "o")!
            // change the current player variable as soon as the image is changed
            change_player()
            return image
        }
        if(current_player == Turn.X){
            image = UIImage(named: "x")!
            // change the current player variable as soon as the image is changed
            change_player()
            return image
        }
        return image
    }
    
    // method to change the player
    func change_player(){
        if(current_player == Turn.O){
            current_player = Turn.X
            current_player_text = "X"
            return
        }
        if(current_player == Turn.X){
            current_player = Turn.O
            current_player_text = "O"
            return
        }
    }
    
    func get_winner_text() -> String{
        return winner_text
    }
    
    func set_buttons(btns: [UIButton]){
        buttons = btns
    }
    
    func get_player_turn_text() -> String{
        return "Player \(String(current_player_text))'s turn"
    }
    
    func get_player_x_score() -> String{
        return "X's Score: \(String(player_x_score))"
    }
    
    func inc_player_x_score(){
        player_x_score += 1
    }
    
    func set_player_x_score(score: Int){
        player_x_score = score
    }
    
    func get_player_o_score() -> String{
        return "O's Score: \(String(player_o_score))"
    }
    
    func set_player_o_score(score: Int){
        player_o_score = score
    }
    
    func inc_player_o_score(){
        player_o_score += 1
    }
    
    func get_current_player() -> Turn{
        return current_player
    }
    
    func set_current_player(player: Turn){
        current_player = player
    }
    
    func get_current_player_text() -> String{
        return current_player_text
    }
    
    func set_current_player_text(player: String){
        current_player_text = player
    }
}

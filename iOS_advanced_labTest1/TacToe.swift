//
//  TacToe.swift
//  Lab1_litsonThomas_C0834476_iOS
//
//  Created by Litson Thomas on 2022-01-18.
//

import UIKit
import CoreData

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
    var can_player_x_undo: Bool = false
    var can_player_o_undo: Bool = false
    var selected_slot: Int = -1
    
    init(player: Turn, value: String, x_score: Int, o_score: Int){
        self.current_player = player
        self.current_player_text = value
        self.player_o_score = o_score
        self.player_x_score = x_score
    }
    
    // method to initialize core data
    func initialize_core_data(context: NSManagedObjectContext){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TacToeGame")
        do{
            let game_details = try context.fetch(request)
            if(game_details.isEmpty){
                reset_core_data(context: context)
            }
            else{
                update_with_core_data(context: context)
            }
        }
        catch{
            print(error)
        }
    }
    
    // method to update the local app data with existing core data details
    func update_with_core_data(context: NSManagedObjectContext){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TacToeGame")
        do{
            let game_details = try context.fetch(request)
            for data in game_details as! [NSManagedObject]{
                current_player = get_player_turn_from_text(player: data.value(forKey: "current_turn") as! String)
                current_player_text = data.value(forKey: "current_turn") as! String
                player_o_score = data.value(forKey: "player_o_score") as! Int
                player_x_score = data.value(forKey: "player_x_score") as! Int
                buttons[0].setBackgroundImage(UIImage.init(named: data.value(forKey: "a1") as! String), for: .normal);
                buttons[1].setBackgroundImage(UIImage.init(named: data.value(forKey: "a2") as! String), for: .normal);
                buttons[2].setBackgroundImage(UIImage.init(named: data.value(forKey: "a3") as! String), for: .normal);
                buttons[3].setBackgroundImage(UIImage.init(named: data.value(forKey: "b1") as! String), for: .normal);
                buttons[4].setBackgroundImage(UIImage.init(named: data.value(forKey: "b2") as! String), for: .normal);
                buttons[5].setBackgroundImage(UIImage.init(named: data.value(forKey: "b3") as! String), for: .normal);
                buttons[6].setBackgroundImage(UIImage.init(named: data.value(forKey: "c1") as! String), for: .normal);
                buttons[7].setBackgroundImage(UIImage.init(named: data.value(forKey: "c2") as! String), for: .normal);
                buttons[8].setBackgroundImage(UIImage.init(named: data.value(forKey: "c3") as! String), for: .normal);
            }
        }
        catch{
            print(error)
        }
    }
    
    // method to get the player turn from the player string
    func get_player_turn_from_text(player: String) -> Turn{
        if(player == "X") {
            return Turn.X
        }
        else{
            return Turn.O
        }
    }
    
    // method to update the game data in the core data
    func update_core_data(context: NSManagedObjectContext){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TacToeGame")
        do{
            let game_details = try context.fetch(request)
            for data in game_details as! [NSManagedObject]{
                data.setValue(player_x_score, forKey: "player_x_score")
                data.setValue(player_o_score, forKey: "player_o_score")
                data.setValue(current_player_text, forKey: "current_turn")
                data.setValue(get_button_name(btn: buttons[0]), forKey: "a1")
                data.setValue(get_button_name(btn: buttons[1]), forKey: "a2")
                data.setValue(get_button_name(btn: buttons[2]), forKey: "a3")
                data.setValue(get_button_name(btn: buttons[3]), forKey: "b1")
                data.setValue(get_button_name(btn: buttons[4]), forKey: "b2")
                data.setValue(get_button_name(btn: buttons[5]), forKey: "b3")
                data.setValue(get_button_name(btn: buttons[6]), forKey: "c1")
                data.setValue(get_button_name(btn: buttons[7]), forKey: "c2")
                data.setValue(get_button_name(btn: buttons[8]), forKey: "c3")
            }
            do{
                try context.save()
            }
            catch{
                print(error)
            }
        }
        catch{
            print(error)
        }
    }
    
    // method to get the button name
    func get_button_name(btn: UIButton) -> String{
        if(btn.currentBackgroundImage == UIImage(named: "x")){
            return "x"
        }
        if(btn.currentBackgroundImage == UIImage(named: "o")){
            return "o"
        }
        return "blank"
    }
    
    // method to reset game data in the core data
    func reset_core_data(context: NSManagedObjectContext){
        delete_core_data_entries(context: context) // make sure we delete all the entries till now
        let game_details = NSEntityDescription.insertNewObject(forEntityName: "TacToeGame", into: context)
        game_details.setValue(0, forKey: "player_x_score")
        game_details.setValue(0, forKey: "player_o_score")
        game_details.setValue(current_player_text, forKey: "current_turn")
        game_details.setValue("blank", forKey: "a1")
        game_details.setValue("blank", forKey: "a2")
        game_details.setValue("blank", forKey: "a3")
        game_details.setValue("blank", forKey: "b1")
        game_details.setValue("blank", forKey: "b2")
        game_details.setValue("blank", forKey: "b3")
        game_details.setValue("blank", forKey: "c1")
        game_details.setValue("blank", forKey: "c2")
        game_details.setValue("blank", forKey: "c3")
        do{
            try context.save()
        }
        catch{
            print(error)
        }
    }
    
    // method to delete all the entries in the core data
    func delete_core_data_entries(context: NSManagedObjectContext){
        let delete_req = NSFetchRequest<NSFetchRequestResult>(entityName: "TacToeGame")
        let request = NSBatchDeleteRequest(fetchRequest: delete_req)
        do {
            try context.execute(request)

        } catch {
            print(error)
        }
    }
    
    // method to undo the move
    func undo_move(){
        if(current_player == Turn.O){
            current_player = Turn.X
            current_player_text = "X"
            can_player_x_undo = false
            set_slot_blank()
            return
        }
        if(current_player == Turn.X){
            current_player = Turn.O
            current_player_text = "O"
            can_player_o_undo = false
            set_slot_blank()
            return
        }
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
        can_player_x_undo = false
        can_player_o_undo = false
        selected_slot = -1
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
            can_player_o_undo = true
            return
        }
        if(current_player == Turn.X){
            current_player = Turn.O
            current_player_text = "O"
            can_player_x_undo = true
            return
        }
    }
    
    func get_winner_text() -> String{
        return winner_text
    }

    func set_slot_blank(){
        if(selected_slot > -1){
            buttons[selected_slot].setBackgroundImage(UIImage.init(named: "blank"), for: .normal);
        }
    }
    
    func set_selected_slot(slot: Int){
        selected_slot = slot
    }
    
    func get_selected_slot() -> Int{
        return selected_slot
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

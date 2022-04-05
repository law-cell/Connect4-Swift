//
//  Connect4VC.swift
//  Connect4
//
//  Created by 罗俊豪 on 04/04/2022.
//

import UIKit

class Connect4VC: UIViewController {
    var game: Connect4 = Connect4()
    
    @IBOutlet weak var gameView: GameView!
    @IBOutlet weak var whoseTurnLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //testing
//        game.pieces.insert(Piece(col: 0, row: 5, isRed: true))
//        game.pieces.insert(Piece(col: 1, row: 5, isRed: false))
        
        gameView.shadowPieces = game.pieces
        gameView.setNeedsDisplay()
        
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        let fingerLocation = sender.location(in: gameView)
        let col = gameView.columAt(x: fingerLocation.x)
        print(col)
        game.dropAt(col: col)
//        gameView.shadowPieces = game.pieces
//        gameView.setNeedsDisplay()
        //updateUI()
        if let winningPieces = game.gameOverAt(col: col) {
            gameView.shadowWinningPieces = winningPieces
            whoseTurnLabel.text = game.redTurn ? "Yellow wins" : "Red wins"
            gameView.isUserInteractionEnabled = false
        } else {
            if game.redTurn {
                whoseTurnLabel.text = "Red"
            } else {
                whoseTurnLabel.text = "Yellow"
            }
        }
        gameView.shadowPieces = game.pieces
        gameView.setNeedsDisplay()
        
        print(game.gameOverAt(col: col))
        
    }
    @IBAction func reset(_ sender: UIButton) {
        game.reset()
        gameView.shadowWinningPieces.removeAll()
        gameView.shadowPieces = game.pieces
        gameView.setNeedsDisplay()
        whoseTurnLabel.text = "Yellow"
        gameView.isUserInteractionEnabled = true
    }
    

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  GameView.swift
//  Connect4
//
//  Created by 罗俊豪 on 04/04/2022.
//

import UIKit

class GameView: UIView {
    let boardToScreenRatio: CGFloat = 0.9
    
    var originX: CGFloat = 13
    var originY: CGFloat = 35
    var cellSide: CGFloat = 53.5
    var shadowPieces: Set<Piece> = Set<Piece>()
    var shadowWinningPieces: Set<Piece> = Set<Piece>()
    
    override func draw(_ rect: CGRect) {
        let boardWidth = bounds.width * boardToScreenRatio
        cellSide = boardWidth / CGFloat(Connect4.cols)
        originX = (1 - boardToScreenRatio) * bounds.width / 2
        originY = (bounds.height - CGFloat(Connect4.rows) * cellSide) / 2
        
        drawBoard()
        drawPieces()
    }
    
    func columAt(x: CGFloat) -> Int {
        return Int((x - originX) / cellSide)
    }
    
    func drawPieces() {
        for piece in shadowPieces {
            drawCircle(col: piece.col, row: piece.row, color: piece.isRed ? .red : .yellow, withStrock: false)
        }
        
        for piece in shadowWinningPieces {
            drawCircle(col: piece.col, row: piece.row, color: piece.isRed ? .red : .yellow, withStrock: true)
        }
    }
    
    func drawBoard() {
        UIColor.link.setFill()
        let boardPath = UIBezierPath(roundedRect: CGRect(x: originX, y: originY, width: CGFloat(Connect4.cols) * cellSide, height: CGFloat(Connect4.rows) * cellSide), cornerRadius: 0.25 * cellSide)
        boardPath.stroke()
        boardPath.fill()
        
        
        UIColor.white.setFill()
        
        for row in 0..<Connect4.rows {
            for col in 0..<Connect4.cols {
                drawCircle(col: col, row: row, color: UIColor.white, withStrock: false)
            }
        }

    }
    
    func drawCircle(col: Int, row: Int, color: UIColor, withStrock: Bool) {
        color.setFill()
        let circleCenterX: CGFloat = originX + 0.5 * cellSide + CGFloat(col) * cellSide
        let circleCenterY: CGFloat = originY + 0.5 * cellSide + CGFloat(row) * cellSide
        
        let circle = UIBezierPath(arcCenter: CGPoint(x: circleCenterX, y: circleCenterY), radius: 0.4 * cellSide, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        circle.fill()
        if withStrock {
            UIColor.orange.setStroke()
            circle.lineWidth = 3
            circle.stroke()
        }
    }
}

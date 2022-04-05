//
//  Connect4.swift
//  Connect4
//
//  Created by 罗俊豪 on 04/04/2022.
//

import Foundation

struct Connect4: CustomStringConvertible {
    static let rows: Int = 6
    static let cols: Int = 7
    var pieces: Set<Piece> = Set<Piece>()
    var redTurn: Bool = false
    
    
    mutating func reset() {
        pieces.removeAll()
        redTurn = false
    }
    
    
    func gameOverAt(col: Int) -> Set<Piece>? {
        let row = Connect4.rows - numberOfPiecesAt(col: col)
        return fourConnectedAt(col: col, row: row, isRed: !redTurn)
    }
    
    
    //check
    func fourConnectedAt(col: Int, row: Int, isRed: Bool) -> Set<Piece>? {
        var horizontalBox: Set<Piece> = Set<Piece>()
        var verticalBox: Set<Piece> = Set<Piece>()
        var diagonalTL2BRBox: Set<Piece> = Set<Piece>()
        var diagonalBL2TRBox: Set<Piece> = Set<Piece>()
        
        for i in 1...3 {
            if let piece = pieceAt(col: col - i, row: row), piece.isRed == isRed {
                horizontalBox.insert(piece)
            }
            if let piece = pieceAt(col: col - i, row: row + i), piece.isRed == isRed {
                diagonalBL2TRBox.insert(piece)
            }
            if let piece = pieceAt(col: col, row: row + i), piece.isRed == isRed {
                verticalBox.insert(piece)
            }
            if let piece = pieceAt(col: col + i, row: row + i), piece.isRed == isRed {
                diagonalTL2BRBox.insert(piece)
            }
            if let piece = pieceAt(col: col + i, row: row), piece.isRed == isRed {
                horizontalBox.insert(piece)
            }
            if let piece = pieceAt(col: col + i, row: row - i), piece.isRed == isRed {
                diagonalBL2TRBox.insert(piece)
            }
            if let piece = pieceAt(col: col, row: row - i), piece.isRed == isRed {
                verticalBox.insert(piece)
            }
            if let piece = pieceAt(col: col - i, row: row - i), piece.isRed == isRed {
                diagonalTL2BRBox.insert(piece)
            }
        }
        
        if horizontalBox.count == 3 {
            horizontalBox.insert(pieceAt(col: col, row: row)!)
            return horizontalBox
        } else if verticalBox.count == 3 {
            verticalBox.insert(pieceAt(col: col, row: row)!)
            return verticalBox
        } else if diagonalTL2BRBox.count == 3 {
            diagonalTL2BRBox.insert(pieceAt(col: col, row: row)!)
            return diagonalTL2BRBox
        } else if diagonalBL2TRBox.count == 3 {
            diagonalBL2TRBox.insert(pieceAt(col: col, row: row)!)
            return diagonalBL2TRBox
        }
            
            
            
            
        return nil
    }
    
    
    //drop one piece
    mutating func dropAt(col: Int) {
        if numberOfPiecesAt(col: col) >= Connect4.rows {
            return
        }
        let numberOfPieces = numberOfPiecesAt(col: col)
        let row = Connect4.rows - 1 - numberOfPieces
        let newPiece = Piece(col: col, row: row, isRed: redTurn)
        pieces.insert(newPiece)
        redTurn = !redTurn
    }
    
    //report how many rest
    func numberOfPiecesAt(col: Int) -> Int {
        var numberOfPieces: Int = 0
        for piece in pieces where piece.col == col {
            numberOfPieces += 1
        }
        return numberOfPieces
    }
    
    func pieceAt(col: Int, row: Int) -> Piece? {
        for piece in pieces {
            if col == piece.col && row == piece.row {
                return piece
            }
        }
        return nil
    }
    
    
    var description: String {
        var desc = "  "
        for col in 0..<Connect4.cols {
            desc += "\(col)"
        }
        desc += "\n"
        for row in 0..<Connect4.rows {
            desc += "\(row)"
            for col in 0..<Connect4.cols {
                let piece = pieceAt(col: col, row: row)
                if piece == nil {
                    desc += ". "
                } else {
                    if piece!.isRed {
                        desc += "o "
                    } else {
                        desc += "x "
                    }
                }
            }
            desc += "\n"
        }
        
        return desc
    }
}

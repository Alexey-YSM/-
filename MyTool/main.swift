import Foundation

let finalSquare = 100
var player1 = 1
var player2 = 1
var move = true // будем переключать ходы игроков с её помощью

var board = [Int](repeating: 0, count: finalSquare + 1)

board[13] = +11; board[17] = +20; board[22] = +10; board[35] = +19; board[58] = +14; board[81] = +12;
board[15] = -9; board[34] = -12; board[55] = -22; board[66] = -21; board[73] = -10; board[95] = -17;


func drawBoard(player11: Int, player22: Int) {
    print("                     👾ИГРОВОЕ ПОЛЕ👾")
    let a = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    for row in a {
        var rowString = ""
        let direction = row % 2 == 0 // если True, то строки идут справа налево
        for col in 0...9 {
            let number = direction ? (row * 10 + col + 1) : (row * 10 + 10 - col)
            var str = "\(number)"
            
            if number == player11 && number == player22 {
                str = "🫂"
            } else if number == player11 {
                str = "1️⃣"
            } else if number == player22 {
                str = "2️⃣"
            } else if board[number] > 0 {
                str = "🪜"
            } else if board[number] < 0 {
                str = "🐍"
            }
            if number < 10 {
                rowString += "   \(str)  "
            } else if number == 100 {
                rowString += "  \(str) "
            } else {
                rowString += "  \(str)  "
            }
        }
        print(rowString)
    }
    print("------------------------------------------------------------")
}

print("🎲 Игра 'Змеи и Лестницы' 🎲")


while player1 < finalSquare && player2 < finalSquare {
    let currentPlayer = move ? "Игрок 1" : "Игрок 2"
    var currentSquare = move ? player1 : player2
    _ = readLine()
    print("Ходит \(currentPlayer)")
    let diceRoll = Int.random(in: 1...6)
    print("🎲 Выпало: \(diceRoll)")
    
    switch currentSquare + diceRoll {
    case finalSquare:
        currentSquare = finalSquare
        print("🎯 Идеальное попадание 🎯")
    case let newSquare where newSquare > finalSquare:
        print("❌ Перебор! \(currentPlayer) должен выкинуть ровно \(finalSquare - currentSquare). Ход пропущен ❌")
    default:
        currentSquare += diceRoll
    }
    if currentSquare < board.count {
        currentSquare += board[currentSquare]
    }
    if move {
        player1 = currentSquare
    } else {
        player2 = currentSquare
    }
    
    drawBoard(player11: player1, player22: player2)
    
    if currentSquare == finalSquare {
        print("\n🏆🏆🏆 WWWWW!!! \(currentPlayer) дошел до финиша!!! 🏆🏆🏆")
        break
    }
    move = !move
}

print("Игра окончена!")

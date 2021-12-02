import UIKit

var greeting = "Hello, playground"
/* Задание 1

Измените сабскрипт таким образом, чтобы он корректно обрабатывал удаление фигуры с шахматной доски. Не забывайте, что у класса Chessman есть метод kill(). То есть должно происходить не просто удаление фигуры с поля, но и изменение свойства coordinates на nil у самой фигуры.
2) Реализуйте метод printDesk() в классе gameDesk, выполняющий вывод на консоль изображения шахматной доски с помощью символов в следующем виде:
// 1 _ _ _ _ _ _ _ _
// 2 _ _ _ _ _ _ _ _
// 3 _ _ _ _ _ _ _ _
// 4 _ _ _ _ _ _ _ _
// 5 _ _ _ _ _ _ _ _
// 6 _ _ _ _ _ _ _ _
// 7 _ _ _ _ _ _ _ _
// 8 _ _ _ _ _ _ _ _
//   A B C D E F G H
При этом там, где располагаются созданные фигуры должны выводиться их графически отображения (значение свойства symbol класса Chessman).

3) Доработайте классы таким образом, чтобы убитые фигуры (убранные с поля, значение координат изменено на nil) при использовании метода printDesk() появлялись над и под шахматной доской (над шахматной – черные фигуры), под шахматной – белые).
4) Доработайте классы таким образом, чтобы появилась возможность изменить координаты фигуры на поле.
Например:
game.move(from:to:)
5) Если вы чувствуете в себе силы, то реализуйте следующий функционал:
– при попытке передвижения фигуры должна производиться проверка возможности ее перемещения. Попытайтесь реализовать хотя бы для одного типа фигур (к примеру пешка). При этом должны учитываться: особенности первого хода, будет ли съедена в результате хода фигура противника и т.д.

Пример вывода:

♝♜
1 _ _ _ _ _ _ _ _
2 _ _ _ ♚ _ _ _ _
3 _ _ _ _ _ ♛ _ _
4 _ _ _ _ _ _ _ _
5 _ _ _ _ _ _ _ _
6 _ _ _ _ _ _ _ _
7 _ _ _ ♔ _ _ _ _
8 _ _ _ _ _ _ _ _
  A B C D E F G H
♙♘♕♖♗
 */
class Chessman {
    enum ChessmanType {
        case king, castle, bishop, pawn, knight, queen
    }
    enum ChessmanColor {
        case black, white
    }
    let type: ChessmanType
    let color: ChessmanColor
    var coordinates: (String, Int)? = nil
    let figureSymbol: Character
    init(type: ChessmanType, color: ChessmanColor, figure:
        Character){
        self.type = type
        self.color = color
        self.figureSymbol = figure
    }
    init(type: ChessmanType, color: ChessmanColor, figure:
        Character, coordinates: (String, Int)){
        self.type = type
        self.color = color
        self.figureSymbol = figure
        self.setCoordinates(char: coordinates.0, num:coordinates.1)
    }
    func setCoordinates(char c:String, num n: Int){
        self.coordinates = (c, n)
    }
    func kill(){
        self.coordinates = nil
    }
}

class GameDesk {
    var desk: [Int:[String:Chessman]] = [:]
    init(){
        for i in 1...8 {
            desk[i] = [:]
        }
    }
    subscript(alpha: String, number: Int) -> Chessman? {
        get{
            return self.desk[number]![alpha]
        }
        set{
            if let chessman = newValue {
                self.setChessman(chess: chessman, coordinates: (alpha, number))
            }else{
                //Получение фигуры
                let chess = self.desk[number]![alpha]
                //удаление координат у фигуры
                chess!.kill()
                //Удаление фигуры с поля
                self.desk[number]![alpha] = nil
            }
        }
    }
    func setChessman(chess: Chessman , coordinates: (String, Int)){
        let rowRange = 1...8
        let colRange = "A"..."Z"
        if( rowRange.contains( coordinates.1 ) && colRange.contains( coordinates.0 )) {
            self.desk[coordinates.1]![coordinates.0] = chess
            chess.setCoordinates(char: coordinates.0, num: coordinates.1)
        } else {
            print("Coordinates out of range")
        }
    }
}
var game = GameDesk()
var queenBlack = Chessman(type: .queen, color: .black, figure: "\u{265B}", coordinates: ("A", 6))
game["C",5] = queenBlack
game["C",5]
game["C",5] = nil
game["C",5]
queenBlack.coordinates


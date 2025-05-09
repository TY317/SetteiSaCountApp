//
//  myFunction.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/12.
//

import SwiftUI

struct myFunction: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


// ///////////////////////////////
// 関数：配列をJSONデータに変換して保存する
// ///////////////////////////////
func saveArray<T: Encodable>(_ array: T, forKey key: String) {
    if let encodedData = try? JSONEncoder().encode(array) {
        UserDefaults.standard.set(encodedData, forKey: key)
    }
}

// ///////////////////////////////
// 関数：ArrayDataをデコードして配列に変換する、文字列配列用
// ///////////////////////////////
func decodeStringArray(from data: Data?) -> [String] {
    if let data = data,
       let decodedArray = try? JSONDecoder().decode([String].self, from: data) {
        return decodedArray
    }
    return []
}


// ///////////////////////////////
// 関数：ArrayDataをデコードして配列に変換する、整数列配列用
// ///////////////////////////////
func decodeIntArray(from data: Data?) -> [Int] {
    if let data = data,
       let decodedArray = try? JSONDecoder().decode([Int].self, from: data) {
        return decodedArray
    }
    return []
}


// ///////////////////////////////
// 関数：ArrayDataから特定のデータの数をカウントする
// ///////////////////////////////
func arrayStringDataCount(arrayData: Data?, countString: String) -> Int {
    let array = decodeStringArray(from: arrayData)
    return array.filter { $0 == countString }.count
}


// ///////////////////////////////
// 関数：Array内のデータの数をカウントする、整数配列用
// ///////////////////////////////
func arrayIntAllDataCount(arrayData: Data?) -> Int {
    let array = decodeIntArray(from: arrayData)
    return array.count
}


// ///////////////////////////////
// 関数：Array内のデータの数をカウントする、文字列配列用
// ///////////////////////////////
func arrayStringAllDataCount(arrayData: Data?) -> Int {
    let array = decodeStringArray(from: arrayData)
    return array.count
}


// ///////////////////////////////
// 関数：Array内の整数データを全て合計する、整数配列専用
// ///////////////////////////////
func arrayIntAllDataSum(arrayData: Data?) -> Int {
    let array = decodeIntArray(from: arrayData)
    return array.reduce(0, +)
}


// //////////////////////////////
// 関数：配列から最新の1行を削除する、文字列配列用
// //////////////////////////////
func arrayStringRemoveLast(arrayData: Data?, key: String) {
    var array = decodeStringArray(from: arrayData)
    if array.count > 0 {
        array.removeLast()
        saveArray(array, forKey: key)
    } else {
        
    }
}


// //////////////////////////////
// 関数：配列から最新の1行を削除する、整数配列用
// //////////////////////////////
func arrayIntRemoveLast(arrayData: Data?, key: String) {
    var array = decodeIntArray(from: arrayData)
    if array.count > 0 {
        array.removeLast()
        saveArray(array, forKey: key)
    } else {
        
    }
}


// //////////////////////////////
// 関数：配列にデータを追加する、文字列配列用
// //////////////////////////////
func arrayStringAddData(arrayData: Data?, addData: String, key: String) {
    var array = decodeStringArray(from: arrayData)
    array.append(addData)
    saveArray(array, forKey: key)
}


// //////////////////////////////
// 関数：配列にデータを追加する、整数配列用
// //////////////////////////////
func arrayIntAddData(arrayData: Data?, addData: Int, key: String) {
    var array = decodeIntArray(from: arrayData)
    array.append(addData)
    saveArray(array, forKey: key)
}


// //////////////////////////////
// 関数：配列のデータを全消去する、文字列配列用
// //////////////////////////////
func arrayStringRemoveAll(arrayData: Data?, key: String) {
    var array = decodeStringArray(from: arrayData)
    array.removeAll()
    saveArray(array, forKey: key)
}


// //////////////////////////////
// 関数：配列のデータを全消去する、整数配列用
// //////////////////////////////
func arrayIntRemoveAll(arrayData: Data?, key: String) {
    var array = decodeIntArray(from: arrayData)
    array.removeAll()
    saveArray(array, forKey: key)
}


// //////////////////////////////
// 関数：ゲーム数配列から総ゲーム数を算出する、ATとCZがある場合
// //////////////////////////////
func arraySumPlayGameResetWordOne(gameArrayData: Data?, bonusArrayData: Data?, resetWord: String) -> Int {
    let gameArray = decodeIntArray(from: gameArrayData)
    let bonusArray = decodeStringArray(from: bonusArrayData)
    var lastGame = 0
    var currentGame = 0
    var hitGame = 0
    var playGame = 0
    
    // 配列の数を確認し0なら0を返す
    if gameArray.count == 0 {
        return 0
    }
    // 配列にデータがあれば1個ずつ確認しながらゲーム数を足していく
    else {
        for (index, bonus) in bonusArray.enumerated() {
            if bonus == resetWord {
                hitGame = gameArray[index]
                playGame = playGame + hitGame - currentGame
                currentGame = 0
                lastGame = 0
            } else {
                currentGame = gameArray[index]
                playGame = playGame + currentGame - lastGame
                lastGame = currentGame
            }
        }
        return playGame
    }
}


// //////////////////////////////
// 関数：2つの文字列配列から特定のキーワードに両方合致するデータのカウント
// //////////////////////////////
func arrayString2Array2AndDataCount(array1Data: Data?, array2Data: Data?, key1: String, key2: String) -> Int {
    let array1 = decodeStringArray(from: array1Data)
    let array2 = decodeStringArray(from: array2Data)
    var count = 0
    
    // 配列の数を確認し0なら0を返す
    if array1.count == 0 ||
        array2.count == 0 {
        count = 0
    }
    
    // 配列にデータがあれば1個ずつ確認しながらカウントしていく
    else {
        for (index, array1Data) in array1.enumerated() {
            if array2.indices.contains(index) {
                if array1Data == key1 && array2[index] == key2 {
                    count += 1
                }
            }
        }
    }
    return count
}

// //////////////////////////////
// 関数：整数配列と文字列配列から指定数値以上かつ特定のキーワードに両方合致するデータのカウント
// //////////////////////////////
func arrayKeywordAndOverGameCount(intArrayData: Data?, stringArrayData: Data?, overGame: Int, keyword: String) -> Int {
    let intArray = decodeIntArray(from: intArrayData)
    let stringArray = decodeStringArray(from: stringArrayData)
    var count = 0
    
    // 配列の数を確認し0なら0を返す
    if intArray.count == 0 ||
        stringArray.count == 0 {
        count = 0
    }
    
    // 配列にデータがあれば1個ずつ確認しながらカウントしていく
    else {
        for (index, intData) in intArray.enumerated() {
            if stringArray.indices.contains(index) {
                if intData > overGame && stringArray[index] == keyword {
                    count += 1
                }
            }
        }
    }
    return count
}


// //////////////////////////////
// 関数：特定のゲーム数以上のデータの数をカウント
// //////////////////////////////
func arrayIntOverGameCount(intArrayData: Data?, overGame: Int) -> Int {
    let intArray = decodeIntArray(from: intArrayData)
    var count = 0
    
    // 配列の数を確認し0なら0を返す
    if intArray.count == 0 {
        count = 0
    }
    else {
        for intData in intArray {
            if intData > overGame {
                count += 1
            }
        }
    }
    return count
}

// //////////////////////////////
// 関数：カウントボタンの処理
// /////////////////////////////
func countUpDown(minusCheck: Bool, count: Int) -> Int {
    var newCount = count
    
    // カウントダウン処理
    if minusCheck {
        // 0以上ならカウントダウン
        if newCount > 0 {
            newCount -= 1
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        }
        // 0ならば何もしない
        else {
            
        }
    }
    // カウントアップ処理
    else {
        newCount += 1
        UINotificationFeedbackGenerator().notificationOccurred(.warning)
    }
    
    return newCount
}


// //////////////////////////////
// 関数：合計
// //////////////////////////////
func countSum(_ numbers: Int...) -> Int {
    return numbers.reduce(0, +)
}


// /////////////////////////////
// 関数：95%信頼区間の下限値を算出
// /////////////////////////////
func statistical95Lower(denominate: Double, times: Int) -> Double {
    let probability = 1.0 / denominate
    let standardError = sqrt(probability * (1.0 - probability)/Double(times))
    let zScore = 1.96
    let lowerRatio = probability - (zScore * standardError)
    let lower = lowerRatio * Double(times) > 0 ? lowerRatio * Double(times) : 0
    return times > 0 ? lower : 0
}


// /////////////////////////////
// 関数：95%信頼区間の上限値を算出
// /////////////////////////////
func statistical95Upper(denominate: Double, times: Int) -> Double {
    let probability = 1.0 / denominate
    let standardError = sqrt(probability * (1.0 - probability)/Double(times))
    let zScore = 1.96
    let upperRatio = probability + (zScore * standardError)
    let upper = upperRatio * Double(times) > 0 ? upperRatio * Double(times) : 0
    return times > 0 ? upper : 0
}


// /////////////////////////////
// 関数：95%信頼区間の下限値を算出、パーセントバージョン
// /////////////////////////////
func statistical95LowerPercent(percent: Double, times: Int) -> Double {
    let probability = percent / 100.0
    let standardError = sqrt(probability * (1.0 - probability)/Double(times))
    let zScore = 1.96
    let lowerRatio = probability - (zScore * standardError)
    let lower = lowerRatio * Double(times) > 0 ? lowerRatio * Double(times) : 0
    return times > 0 ? lower : 0
}


// /////////////////////////////
// 関数：95%信頼区間の上限値を算出、パーセントバージョン
// /////////////////////////////
func statistical95UpperPercent(percent: Double, times: Int) -> Double {
    let probability = percent / 100.0
    let standardError = sqrt(probability * (1.0 - probability)/Double(times))
    let zScore = 1.96
    let upperRatio = probability + (zScore * standardError)
    let upper = upperRatio * Double(times) > 0 ? upperRatio * Double(times) : 0
    return times > 0 ? upper : 0
}


#Preview {
    myFunction()
}

// : Playground - noun: a place where people can play

import UIKit

var fibs = [2, 3, 45, 53, 32, 12, 32, 1, 0, 1]

fibs.map {
    Double($0 * 3)
}

let suits = ["♠", "♥", "♣", "♦"]

let ranks = ["J", "Q", "K", "A"]

let allCombinations = suits.flatMap { suit in
    ranks.map { rank in
        (suit, rank)
    }
}

suits.flatMap { (suit) -> [String]? in
    [suit, suit]
}

suits.flatMap { (suit) -> [String] in
    if suit != "♥" {
        return [suit]
    } else {
        return []
    }
}

fibs.flatMap { (num) in
    print(num)
}

fibs.sort {
    $0 > $1
}

fibs.lexicographicalCompare([3])
fibs.lexicographicalCompare([1])
fibs.lexicographicalCompare([3]) { (num0, num1) -> Bool in
    num0 > num1
}
fibs.lexicographicalCompare([1]) { (num0, num1) -> Bool in
    num0 > num1
}

fibs.reduce(0) { (total, num) -> Int in
    total + num
}

fibs.filter { (num) -> Bool in
    num % 3 == 0
}

fibs.indexOf(4)
fibs.indexOf(1)
fibs.contains(4)
fibs.contains(1)

fibs.minElement()
fibs.minElement { (num0, num1) -> Bool in
    num0 < num1
}
fibs.minElement { (num0, num1) -> Bool in
    num0 > num1
}
fibs.maxElement()
fibs.maxElement { (num0, num1) -> Bool in
    print("num0: \(num0), num1: \(num1)")
    return num0 < num1
}

fibs.maxElement { (num0, num1) -> Bool in
    num0 > num1
}

var strs = ["Lee", "Bee", "Will", "10", ""]
strs.maxElement { (str0, str1) -> Bool in
    str0 < str1
}
strs.maxElement { (str0, str1) -> Bool in
    str0 > str1
}

strs.elementsEqual(["Lee", "Bee", "Will", "10"])
strs.elementsEqual(["Lee", "Bee", "Will", "10", ""])

strs.startsWith(["Lee"])
strs.startsWith(["10"])
strs.startsWith(["Lee"]) { (str0, str1) -> Bool in
    str0 == str1
}

strs.split("10")
strs.split("3")
fibs.split(1)

fibs.split(1, maxSplit: 2, allowEmptySlices: true)
fibs.split(1, maxSplit: 2, allowEmptySlices: false)
fibs.split(1, maxSplit: 3, allowEmptySlices: true)
fibs.split(1, maxSplit: 6, allowEmptySlices: false)
fibs.split(3333, maxSplit: 2, allowEmptySlices: true)
fibs.split(44444, maxSplit: 2, allowEmptySlices: false)

fibs.split(32, maxSplit: 0, allowEmptySlices: true)
fibs.split(32, maxSplit: 1, allowEmptySlices: false)
fibs.split(32, maxSplit: 2, allowEmptySlices: true)
fibs.split(32, maxSplit: 3, allowEmptySlices: false)

fibs.split { (num) -> Bool in
    num % 2 == 0
}

fibs.split(1, allowEmptySlices: true) { (num) -> Bool in
    num % 2 == 1
}

fibs.split(66, allowEmptySlices: true) { (num) -> Bool in
    num % 2 == 1
}

fibs.forEach { (num) in
    print(num - 44)
}

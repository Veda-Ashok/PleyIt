//
//  Match.swift
//  Pleyit
//
//  Created by Veda Ashok on 7/25/19.
//  Copyright © 2019 Veda Ashok. All rights reserved.
//

import Foundation

class Match {
    
//    func checkNum() -> Int {
//        let randNum = Int(arc4random_uniform(13)) + 1
//        var previousNum = [Int]()
//        for n in previousNum{
//            print(n)
//        }
//        if previousNum.contains(randNum){
//        //    checkNum()
//        }
//        previousNum.append(randNum)
//
//        return randNum
//
//    }
    
    var notes = ["C2", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B", "C3"]

    func getNoteNames() -> [Note] {
        
        //declare array of note names
        var noteArray = [Note]()
        var count = 0;
        var n = 13
        //randomize selection from array
        while count < 13 {
            let randNum = Int(arc4random_uniform(UInt32(n))) + 1
            let newNote = Note()
            newNote.noteName = notes[randNum - 1]
        
            noteArray.append(newNote)
            notes.remove(at: (randNum - 1))
            n -= 1
            count += 1
        }
        //return array
        return noteArray
    }
    
    func game(){
        
    }
    
}


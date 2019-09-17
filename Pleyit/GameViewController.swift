//
//  GameViewController.swift
//  Pleyit
//
//  Created by Veda Ashok on 7/11/19.
//  Copyright © 2019 Veda Ashok. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

struct Question{
    var Question : String!
    var Ans : [String]!
    var Answer : Int!
}


class GameViewController: UIViewController {
    var audio = AVAudioPlayer()
    var model = Match()
    var matchArray = [Note]()
    //var noteImages: [UIImage] = []
    
    @IBOutlet var QuestionLabel: UILabel!
    
    var Questions = [Question]()
    var ranNum = 13
    var numAns = Int()
    var numQ = Int()
    
    @IBOutlet var notes: [UIButton]!
    let references = ["C2", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B", "C3"]
    let Answers = ["C2", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B", "C3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call getNoteNames in Match
        matchArray = model.getNoteNames()
        
        Questions = [Question(Question: "C2", Ans: Answers, Answer: 0),
                     Question(Question: "C#", Ans: Answers, Answer: 1),
                     Question(Question: "D", Ans: Answers, Answer:  2),
                     Question(Question: "Eb", Ans: Answers, Answer: 3),
                     Question(Question: "E", Ans: Answers, Answer: 4),
                     Question(Question: "F", Ans: Answers,  Answer: 5),
                     Question(Question: "F#", Ans: Answers, Answer: 6),
                     Question(Question: "G", Ans: Answers, Answer: 7),
                     Question(Question: "Ab", Ans: Answers, Answer: 8),
                     Question(Question: "A", Ans: Answers, Answer: 9),
                     Question(Question: "Bb", Ans: Answers, Answer: 10),
                     Question(Question: "B", Ans: Answers, Answer: 11),
                     Question(Question: "C3",Ans: Answers, Answer: 12)]
        
        
        PickQ()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    func PickQ() {
        print("Count ", Questions.count)
        if Questions.count == 0 {
            NSLog("Congrats! You did it!")
        }
        
        if Questions.count > 0{
            numQ = Int.random(in: 0 ..< ranNum)
            if(ranNum == 0){
                QuestionLabel.text = Questions[0].Question
                numAns = Questions[0].Answer
            }
            // print("Count ", Questions.count)
            QuestionLabel.text = Questions[numQ].Question
            numAns = Questions[numQ].Answer
            
           // ranNum -= 1;
            print("RanNum: ", ranNum);
        
            
        }
        //        else{
        //            NSLog("Congrats! You did it!")
        //        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func noteClicked(_ sender: UIButton) {
        play(note: notes.firstIndex(of: sender)!)
        correctAnswer(note: notes.firstIndex(of: sender)!)
        
    }
    
    
    func play(note: Int){
        print(note,references[note])
        let reference = references[note]
        if let path = Bundle.main.path(forResource: reference, ofType: "m4a"){
            let url = URL(fileURLWithPath: path)
            //  print(reference)
            do {
                audio = try AVAudioPlayer(contentsOf: url)
                audio.prepareToPlay()
                audio.play()
            }
            catch{
                print(error)
            }
        }
        
    }
    
    func correctAnswer(note: Int){
        //        print("numAns ", numAns)
        //        print("numQ ",numQ)
        //         print("Answer", references[numAns])
        //         print("Answer picked", references[note])
        //         print("Question", (Questions[numQ]).Question)
        if references[note]==(Questions[numQ]).Question{
            // if numAns == numQ {
            print("Correct!")
            Questions.remove(at: numQ)
            print("current status: ");
            print(Questions.description)
            ranNum -= 1
            //numQ = numQ+1
            PickQ()
        }
        else{
            print("Incorrect")
            //Questions.append(Questions[numQ])
           // ranNum += 1;
//            for i in 0...Questions.count - 1{
//                print("Questions: " , ranNum);
//
//            }
//
            PickQ()
        }
    }
}

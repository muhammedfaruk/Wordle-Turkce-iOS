//
//  ViewController.swift
//  Wordle ios
//
//  Created by Muhammed Faruk Söğüt on 8.02.2022.
//

import UIKit

enum letterType {
    case add
    case remove
}

class ViewController: UIViewController{
    
    var collectionView : UICollectionView!
    var backcollectionView : UICollectionView!
    
    var selectedCell : Int = 0
    var whichColumn : Int = 0
    
    var letters : [String] = []
    
    var word : String = ""
    
    var words : [String] = []
    
    var controlDic : [Int:UIColor] = [:]
    
    var textField : UITextField = {
        let textField = UITextField()
        textField.becomeFirstResponder()
        textField.spellCheckingType  = .no
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    var playGame : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let randomword = words.randomElement()
        guard let rnd = randomword else {return}
        word = rnd
        print(rnd)
        configureBackCollection()
        configureCollection()
        configureTextField()
    }
        
    
    func configureTextField(){
        view.addSubview(textField)
        textField.delegate      = self
        textField.keyboardType  = .alphabet
        textField.returnKeyType = .done
    }
    
    
    func setLetter(letter: String, type: letterType){        
        print(selectedCell)
        switch type {
       
        case .add:
            letters.append(letter)
        case .remove:
            letters.remove(at: selectedCell)
        }

        collectionView.reloadData()
    }
    
    func controlWord(){
        guard selectedCell % 5 == 0, selectedCell != 0 else {return}
        
        let isInWord = isInWord(whichColum: whichColumn, letters: letters)
        if isInWord == true{
            let wordl = word.lowercased()
            control(whichColumn: whichColumn, word: wordl, letters: letters) {[weak self] answerDic, win  in
                guard let self = self else {return}
                
                self.controlDic = self.controlDic.mergeOnto(target: answerDic)
                backcollectionView.reloadData()
                
                if win == true{
                    won()
                }else if win == false && whichColumn == 4{
                    gameOver()
                }else {
                    whichColumn += 1
                }
            }
            
        }else {
            goBack()
            showfastAlert(title: "Kelime listesinde yok")
        }
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView{
            let width: CGFloat = (collectionView.bounds.width / 5) - 10
            return CGSize(width: width, height: width)
        }else {
            let width: CGFloat = (collectionView.bounds.width / 5) - 10
            return CGSize(width: width, height: width)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionView{
            return 20
        }else {
            return 20
        }
    }
}



extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView{
            return min(letters.count,25)
        }else {
            return 25
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            cell.label.text = letters[indexPath.item]
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "backCell", for: indexPath) as! BackCollectionViewCell
            
            let color = controlDic[indexPath.item]
            cell.set(color: color)
            return cell
        }
    }
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                if whichColumn == 0{
                    selectedCell -= 1
                    setLetter(letter: string, type: .remove)
                    
                }else if whichColumn == 1 && selectedCell <= 5 {
                    selectedCell = 5
                    
                }else if whichColumn == 2 && selectedCell <= 10 {
                    selectedCell = 10
                    
                }else if whichColumn == 3 && selectedCell <= 15 {
                    selectedCell = 15
                    
                }else if whichColumn == 4 && selectedCell <= 20 {
                    selectedCell = 5
                }else {
                    selectedCell -= 1
                    setLetter(letter: string, type: .remove)
                }
                
                
            }else if string == " "{
                return false
                
            }else if string == "1" {
                return false
            }
            else {
                selectedCell += 1
                setLetter(letter: string, type: .add)
                controlWord()
            }
        }
        
        return true
    }
    
}




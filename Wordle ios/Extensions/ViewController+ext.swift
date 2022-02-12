//
//  ViewController+ext.swift
//  Wordle ios
//
//  Created by Muhammed Faruk Söğüt on 9.02.2022.
//

import Foundation
import UIKit

extension ViewController{
    
    func control(whichColumn:Int,word:String, letters:[String], completion: ([Int:UIColor]?,Bool)->()){
        print(letters)
        
        var letterArray : [String] = []
        var value : Int = 0
        
        if whichColumn == 0{
            for i in 0...4{
                letterArray.append(letters[i])
            }
        }else if whichColumn == 1{
            for i in 5...9{
                letterArray.append(letters[i])
            }
            value = 5
        }else if whichColumn == 2{
            for i in 10...14{
                letterArray.append(letters[i])
            }
            value = 10
        }else if whichColumn == 3{
            for i in 15...19{
                letterArray.append(letters[i])
            }
            value = 15
        }else if whichColumn == 4{
            for i in 20...24{
                letterArray.append(letters[i])
            }
            value = 20
        }
        
        
        
        var answrDic : [Int:UIColor] = [:]
        
        var helperArray : [String] = []
        
        let str = Array(word)
        for (wordIndex, wordItem) in str.enumerated(){
            let a = String(wordItem)
            for (index, item)in letterArray.enumerated() {
                if a == item && wordIndex == index {
                    
                    answrDic[index + value] = UIColor.systemGreen
                    helperArray.append(a)
                    
                }else if a == item{
                    if !helperArray.contains(a){
                        answrDic[index + value] = UIColor.systemYellow
                        helperArray.append(a)
                    }
                }
            }
        }
        
        if !answrDic.values.contains(UIColor.systemYellow) && !answrDic.values.contains(UIColor.systemGreen){
            completion(answrDic,false)
        }else if answrDic.values.contains(UIColor.systemYellow){
            completion(answrDic,false)
        }
        else if answrDic.values.contains(UIColor.systemGreen){
            if answrDic.count == 5{
                completion(answrDic,true)
            }else {
                completion(answrDic,false)
            }
        }
        
    }
    
    func isInWord(whichColum: Int, letters: [String] ) -> Bool{
        
        var controlingWord = ""
        
        if whichColumn == 0{
            for i in 0...4{
                controlingWord += letters[i]
            }
        }else if whichColumn == 1{
            for i in 5...9{
                controlingWord += letters[i]
            }
            
        }else if whichColumn == 2{
            for i in 10...14{
                controlingWord += letters[i]
            }
            
        }else if whichColumn == 3{
            for i in 15...19{
                controlingWord += letters[i]
            }
            
        }else if whichColumn == 4{
            for i in 20...24{
                controlingWord += letters[i]
            }
        }
        let controlWord = controlingWord.capitalizingFirstLetter()
        if words.contains(controlWord){
            return true
        }else {
            return false
        }
    }
    
    func goBack(){
        for _ in 1...5{
            letters.removeLast()
        }
        selectedCell -= 5
    }
    
    
    // MARK: Alert settings
    
    func showAlert(title:String, message: String, action: [UIAlertAction]){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for i in action {
            alert.addAction(i)
        }
        present(alert, animated: true)
    }
    
    func showfastAlert(title: String){
        let alertControl = UIAlertController(title: title, message: "", preferredStyle: .alert)
        present(alertControl, animated: true) {
            self.dismiss(animated: true)
        }
    }
    
    func won(){
        let alertAction = UIAlertAction(title: "Tekrar Oyna 🤙", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
            self.letters.removeAll()
            self.controlDic.removeAll()
            
        }
        let shareAction = UIAlertAction(title: "Sonucu Paylaş 🥳", style: .default) { _ in
            
            self.share(shareText: self.createBoxes())
            self.letters.removeAll()
            self.controlDic.removeAll()
            self.navigationController?.popToRootViewController(animated: true)
        }
        showAlert(title: "Tebrikler 🤩", message: "Doğru kelimeyi buldunuz \nKelime: \(word)", action: [alertAction,shareAction])
        
    }
    
    func share(shareText: String){
        let text = "Wordle iOS Türkçe \(whichColumn+1)/5\n\(shareText)"
        
        // set up activity view controller
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToTwitter ]
        
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func gameOver() {
        let alertAction = UIAlertAction(title: "Tekrar Oyna", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
            self.letters.removeAll()
            self.controlDic.removeAll()
        }
        showAlert(title: "Tekrar deneyin 😇", message: "Bulunamayan kelime : \n\(word)", action: [alertAction])
    }
    
    func createBoxes() -> String{
        
        var result : String = ""
        let value = ((whichColumn + 1) * 5)
        
        for i in 0...value{
            
            if i % 5 == 0 {
                result += "\n"
            }
            
            if controlDic.keys.contains(i){
                if controlDic[i] == UIColor.systemGreen{
                    result += "🟩"
                }else if controlDic[i] == UIColor.systemYellow{
                    result += "🟨"
                }
            }else {
                result += "⬛"
            }
        }
        result.removeLast()
       
        return result
    }
    
    
    // MARK: Design
    func configureCollection(){
        view.backgroundColor = .systemBackground
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        //let bottomConstant:CGFloat = DeviceTypes.isiPad ? print("evet ipad"): print("evet ipad")
        let bottomConstant:CGFloat = DeviceTypes.isiPad ? -450 : -150
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstant)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func configureBackCollection(){
        view.backgroundColor = .systemBackground
        backcollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(backcollectionView)
        backcollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstant:CGFloat = DeviceTypes.isiPad ? -450 : -150
        
        NSLayoutConstraint.activate([
            backcollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            backcollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backcollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backcollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstant)
        ])
        
        backcollectionView.dataSource = self
        backcollectionView.delegate   = self
        backcollectionView.register(BackCollectionViewCell.self, forCellWithReuseIdentifier: "backCell")
    }
}



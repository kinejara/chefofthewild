//
//  FirstViewController.swift
//  chefofthewild
//
//  Created by Jorge Villa on 3/10/17.
//  Copyright © 2017 kinejara. All rights reserved.
//

import UIKit
import HFCardCollectionViewLayout

struct CardLayoutSetupOptions {
    var firstMovableIndex: Int = 0
    var cardHeadHeight: CGFloat = 80
    var cardShouldExpandHeadHeight: Bool = true
    var cardShouldStretchAtScrollTop: Bool = true
    var cardMaximumHeight: CGFloat = 0
    var bottomNumberOfStackedCards: Int = 5
    var bottomStackedCardsShouldScale: Bool = true
    var bottomCardLookoutMargin: CGFloat = 10
    var bottomStackedCardsMaximumScale: CGFloat = 1.0
    var bottomStackedCardsMinimumScale: CGFloat = 0.94
    var spaceAtTopForBackgroundView: CGFloat = 0
    var spaceAtTopShouldSnap: Bool = true
    var spaceAtBottom: CGFloat = 0
    var scrollAreaTop: CGFloat = 120
    var scrollAreaBottom: CGFloat = 120
    var scrollShouldSnapCardHead: Bool = false
    var scrollStopCardsAtTop: Bool = true
    
    var numberOfCards: Int = 15
}

class FirstViewController : UICollectionViewController, HFCardCollectionViewLayoutDelegate {
    
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    
    @IBOutlet var backgroundView: UIView?
    @IBOutlet var backgroundNavigationBar: UINavigationBar?
    
    var cardLayoutOptions: CardLayoutSetupOptions = CardLayoutSetupOptions()
    var shouldSetupBackgroundView = false
    
    var colorArray: [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupExample()
    }
    
    // MARK: CollectionView
    
    func cardCollectionViewLayout(_ collectionViewLayout: HFCardCollectionViewLayout, canUnrevealCardAtIndex index: Int) -> Bool {
        if(self.colorArray.count == 1) {
            return false
        }
        return true
    }
    
    func cardCollectionViewLayout(_ collectionViewLayout: HFCardCollectionViewLayout, willRevealCardAtIndex index: Int) {
        if let cell = self.collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? ExampleCollectionViewCell {
            cell.cardCollectionViewLayout = self.cardCollectionViewLayout
            cell.cardIsRevealed(true)
        }
    }
    
    func cardCollectionViewLayout(_ collectionViewLayout: HFCardCollectionViewLayout, willUnrevealCardAtIndex index: Int) {
        if let cell = self.collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? ExampleCollectionViewCell {
            cell.cardCollectionViewLayout = self.cardCollectionViewLayout
            cell.cardIsRevealed(false)
        }
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colorArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        cell.backgroundColor = self.colorArray[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cardCollectionViewLayout?.revealCardAt(index: indexPath.item)
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempColor = self.colorArray[sourceIndexPath.item]
        self.colorArray.remove(at: sourceIndexPath.item)
        self.colorArray.insert(tempColor, at: destinationIndexPath.item)
    }
    
    // MARK: Actions
    
    @IBAction func goBackAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addCardAction() {
        let index = 0
        if(self.colorArray.count == 1 || self.cardCollectionViewLayout!.revealedIndex >= 0) {
            self.cardCollectionViewLayout?.unrevealCard(completion: {
                self.colorArray.insert(self.getRandomColor(), at: index)
                self.collectionView?.insertItems(at: [IndexPath(item: index, section: 0)])
            })
        } else {
            self.colorArray.insert(self.getRandomColor(), at: index)
            self.collectionView?.insertItems(at: [IndexPath(item: index, section: 0)])
        }
        
        if(self.colorArray.count == 1) {
            self.cardCollectionViewLayout?.revealCardAt(index: 0)
        }
    }
    
    @IBAction func deleteCardAtIndex0orSelected() {
        var index = 0
        if(self.cardCollectionViewLayout!.revealedIndex >= 0) {
            index = self.cardCollectionViewLayout!.revealedIndex
        }
        if(self.colorArray.count > index) {
            self.cardCollectionViewLayout?.unrevealCard(completion: {
                self.colorArray.remove(at: index)
                self.collectionView?.deleteItems(at: [IndexPath(item: index, section: 0)])
                
                if(self.colorArray.count == 1) {
                    self.cardCollectionViewLayout?.revealCardAt(index: 0)
                }
            })
        }
    }
    
    // MARK: Private Functions
    
    private func setupExample() {
        if let cardCollectionViewLayout = self.collectionView?.collectionViewLayout as? HFCardCollectionViewLayout {
            self.cardCollectionViewLayout = cardCollectionViewLayout
        }
        
        if(self.traitCollection.horizontalSizeClass == .regular) {
            self.collectionView?.contentInset.left = 100
            self.collectionView?.contentInset.right = 100
        } else {
            self.collectionView?.contentInset.left = 0
            self.collectionView?.contentInset.right = 0
        }
        if(self.shouldSetupBackgroundView == true) {
            self.setupBackgroundView()
        }
        
        let count = cardLayoutOptions.numberOfCards
        for _ in 0..<count {
            self.colorArray.append(self.getRandomColor())
        }
        
        self.collectionView?.reloadData()
    }
    
    private func setupBackgroundView() {
        if(self.cardLayoutOptions.spaceAtTopForBackgroundView == 0) {
            self.cardLayoutOptions.spaceAtTopForBackgroundView = 44 // Height of the NavigationBar in the BackgroundView
        }
        self.collectionView?.backgroundView = self.backgroundView
        self.backgroundNavigationBar?.shadowImage = UIImage()
        self.backgroundNavigationBar?.setBackgroundImage(UIImage(), for: .default)
    }
    
    private func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

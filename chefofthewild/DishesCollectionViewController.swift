//
//  DishesCollectionViewController.swift
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

class DishesCollectionViewController : UICollectionViewController, HFCardCollectionViewLayoutDelegate {
    
    @IBOutlet var backgroundView: UIView?
    @IBOutlet var backgroundNavigationBar: UINavigationBar?
    
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    var dishes = [DishesModel]()
    var cardLayoutOptions: CardLayoutSetupOptions = CardLayoutSetupOptions()
    var shouldSetupBackgroundView = false
    var shouldLoadRestoreHeartsDishes = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customizeAppStyle()
        
        if self.shouldLoadRestoreHeartsDishes {
            self.dishes = DishesApiClient.fetchRestoreHeartsDishes()
        } else {
            self.dishes = DishesApiClient.fetchRestoreStaminaDishes()
        }
        
        self.setupCollectionView()
    }
    
    private func customizeAppStyle() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        self.tabBarController?.tabBar.barTintColor = UIColor.clear
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.backgroundColor = UIColor.clear
        self.tabBarController?.tabBar.layer.backgroundColor = UIColor.clear.cgColor
        self.tabBarController?.tabBar.shadowImage = nil
        
        let defaultBg = UIImage(named: "bg")
        let toolBarImage = UIImage.image(with: defaultBg!, scaledTo: (self.tabBarController?.tabBar.frame.size)!)
        
        self.tabBarController?.tabBar.backgroundImage = toolBarImage
    }
    
    // MARK: CollectionView
    
    func cardCollectionViewLayout(_ collectionViewLayout: HFCardCollectionViewLayout, canUnrevealCardAtIndex index: Int) -> Bool {
        return true
    }
    
    func cardCollectionViewLayout(_ collectionViewLayout: HFCardCollectionViewLayout, willRevealCardAtIndex index: Int) {
        if let cell = self.collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? DishCollectionViewCell {
            cell.cardCollectionViewLayout = self.cardCollectionViewLayout
            cell.cardIsRevealed(true)
        }
    }
    
    func cardCollectionViewLayout(_ collectionViewLayout: HFCardCollectionViewLayout, willUnrevealCardAtIndex index: Int) {
        if let cell = self.collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? DishCollectionViewCell {
            cell.cardCollectionViewLayout = self.cardCollectionViewLayout
            cell.cardIsRevealed(false)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dishes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! DishCollectionViewCell
        let greenLink = UIColor(colorLiteralRed: 13/255, green: 146/255, blue: 99/255, alpha: 1)
        cell.backgroundColor = greenLink
        
        let heartDish = self.dishes[indexPath.item]
        cell.dishDetails = heartDish.details
        cell.labelText?.text = heartDish.food
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cardCollectionViewLayout?.revealCardAt(index: indexPath.item)
    }
    
    // MARK: Actions
    
    @IBAction func goBackAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Private Functions
    
    private func setupCollectionView() {
        let softGreenLink = UIColor(colorLiteralRed: 74/255, green: 186/255, blue: 145/255, alpha: 1)
        self.collectionView?.backgroundColor = softGreenLink
        
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
    
    
}

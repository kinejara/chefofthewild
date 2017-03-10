//
//  DishCollectionViewCell.swift
//  HFCardCollectionViewLayoutExample
//
//  Created by Hendrik Frahmann on 02.11.16.
//  Copyright © 2016 Hendrik Frahmann. All rights reserved.
//

import UIKit
import QuartzCore
import HFCardCollectionViewLayout

class DishCollectionViewCell: HFCardCollectionViewCell, UITableViewDelegate, UITableViewDataSource  {
    
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    var dishDetails : [String : String]?
    var dishRows = [Details]()
    
    struct Details {
        var sectionName : String!
        var sectionObjects : [String]!
    }
    
    @IBOutlet var buttonFlip: UIButton?
    @IBOutlet var tableView: UITableView?
    @IBOutlet var labelText: UILabel?
    @IBOutlet var backView: UIView?
    @IBOutlet var buttonFlipBack: UIButton?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.buttonFlip?.isHidden = true
        self.tableView?.scrollsToTop = false
        self.tableView?.tableFooterView = UIView()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    func cardIsRevealed(_ isRevealed: Bool) {
        self.buttonFlip?.isHidden = true
        self.tableView?.scrollsToTop = isRevealed
        
        if let details = self.dishDetails {
            self.dishRows.removeAll()
            
            for (key, value) in details {
                self.dishRows.append(Details(sectionName: key, sectionObjects: [value] as [String]))
            }
            
            self.tableView?.reloadData()
        }
    }
    
    @IBAction func buttonFlipAction() {
        if let backView = self.backView {
            backView.layer.cornerRadius = self.cornerRadius
            backView.layer.masksToBounds = true
            
            self.cardCollectionViewLayout?.flipRevealedCard(toView: backView)
        }
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return self.dishRows.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dishRows[section].sectionObjects.count
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dishRows[section].sectionName
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dishDetailCell", for: indexPath)
        cell.textLabel?.text = self.dishRows[indexPath.section].sectionObjects[indexPath.row]
        
        return cell
    }
    
    
}

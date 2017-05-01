//
//  CalendarViewController.swift
//  Tipsy
//
//  Created by Christopher Martin on 5/1/17.
//  Copyright © 2017 Christopher Martin. All rights reserved.
//

import UIKit
class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    let pastDates = CollectionOfPastDates(fromRefDate: Date(), daysToGoBack: 61).generateDates()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendarCollectionView.delegate = self
        self.calendarCollectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let index = IndexPath.init(item: self.pastDates.count - 1, section: 0)
        self.calendarCollectionView.scrollToItem(at: index, at: .right, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pastDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.calendarCollectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath)
        
        let comps = Calendar.current.dateComponents([.day, .month], from: self.pastDates[indexPath.row])
        let dayAsInt = comps.day!
        let monthAsInt = comps.month!
        let month = Calendar.current.monthSymbols[monthAsInt - 1]
        
        if indexPath.row == self.pastDates.count - 1 {
            
            let font = UIFont(name: "Antipasto", size: 25.0)
            
            (cell as! TipDateCollectionViewCell).dateLabel.font = font!
            (cell as! TipDateCollectionViewCell).dateLabel.text = "Today"
            (cell as! TipDateCollectionViewCell).monthLabel.text = ""
        }else{
            
            let font = UIFont(name: "Antipasto", size: 42.0)
            
            (cell as! TipDateCollectionViewCell).dateLabel.font = font!
            
            (cell as! TipDateCollectionViewCell).dateLabel.text = "\(dayAsInt)"
            (cell as! TipDateCollectionViewCell).monthLabel.text = month
        }
        return cell
    }
    
    
}

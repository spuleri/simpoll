//
//  PollDetailViewController.swift
//  simpoll
//
//  Created by Sergio Puleri on 11/7/15.
//  Copyright © 2015 Sergio Puleri. All rights reserved.
//


import UIKit
import Foundation

class PollDetailViewController: UIViewController {
    
    var poll: Poll!

    let majorityColor = UIColor(red:0.82, green:0.58, blue:0.82, alpha:1.0)
    let minorityColor: UIColor = UIColor(red:0.38, green:0.75, blue:0.70, alpha:1.0)
    
    @IBOutlet var pollQuestionText: UILabel!
    
    // MARK: Lifecycle
    // ----------------------------------------------------------------------------------- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pollQuestionText.text = poll.question
        
        configurePieChart()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    @IBAction func touchShareButton(sender: AnyObject) {
        print("pressed share button")
        let linkToQuestion: NSURL = NSURL(string: "http://simpoll-remote.cloudapp.net/" + poll.ID)!
        let objectsToShare: [AnyObject] = [linkToQuestion]
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        let excludeActivities = [UIActivityTypeAirDrop, UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo]
        activityVC.excludedActivityTypes = excludeActivities
        self.presentViewController(activityVC, animated: true, completion: nil)

    }
    func configurePieChart() {
        var opt1Color: UIColor
        var opt2Color: UIColor
        
        if poll.option1Votes > poll.option2Votes {
            opt1Color = majorityColor
            opt2Color = minorityColor
        }
        else {
            opt1Color = minorityColor
            opt2Color = majorityColor
        }
        // Init Pie Chart
        let items: [PNPieChartDataItem] = [PNPieChartDataItem(value: CGFloat(poll.option1Votes), color: opt1Color, description: poll.option1), PNPieChartDataItem(value: CGFloat(poll.option2Votes), color: opt2Color, description: poll.option2)]
        
        let pieChart: PNPieChart = PNPieChart(frame: CGRectMake(0, 0, 240.0, 240.0), items: items)
        pieChart.descriptionTextColor = UIColor.whiteColor()
        pieChart.descriptionTextFont = UIFont(name: "Avenir-Medium", size: 14.0)
        pieChart.strokeChart()
        pieChart.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)
        self.view.addSubview(pieChart)
    }
}

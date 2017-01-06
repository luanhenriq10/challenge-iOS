//
//  PullDetailViewController.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class PullDetailViewController: UIViewController {

    // MARK - Storyboard restoration
    class func newInstanceFromStoryboard() -> PullDetailViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("PullDetailViewController") as! PullDetailViewController
        
        return vc
    }
    
    // MARK - Attributes
    @IBOutlet weak var closedLbl: UILabel!
    @IBOutlet weak var openedLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet var emptyView: UIView!
    
    var repository: Repository?
    var listOfPulls: [PullRequest] = [PullRequest]()
    var openIssuesCount: Int = 0
    var isLoading: Bool =  false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.emptyDataSetSource = self
        
        self.navigationController?.navigationBar.topItem?.title = ""
        if self.repository != nil {
            self.getPullRequest()
            self.navigationItem.title = self.repository?.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK - Customization Screen
    func updateUI() {
        self.openIssuesCount = 0
        for pullRequest in self.listOfPulls {
            self.openIssuesCount += (pullRequest.base?.repo?.openIssues)!
        }
        
        self.openedLbl.text = "\(self.openIssuesCount) opened"
    }
    
    // MARK - Service
    
    func getPullRequest() {
        self.showLoading()
        self.isLoading = true
        
        let creator = self.repository?.owner?.login
        let repo    = self.repository?.name
        
        PullRequestService.getPullRequests(creator!, repository: repo!, onSuccess: { (listOfPulls, serviceResponse) in
            if listOfPulls != nil {
                self.listOfPulls = listOfPulls!
                self.updateUI()
            } else {
                self.displaySingleButtonAlert("Unexpected Error", message: "Unable to load repositories", buttonTitle: "Ok", buttonCallback: { (alert) in
                    self.navigationController?.popViewControllerAnimated(true)
                })
            }
        }, onFailure: { (err) in
            self.displayAlertForServiceWrap(err, dismissBlock: {
                self.navigationController?.popViewControllerAnimated(true)
            })

        }) { 
            self.hideLoading()
            self.isLoading = false
            self.tblView.reloadData()
        }
    }
}

extension PullDetailViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.listOfPulls[indexPath.row]
        
        if let urlStr = item.url {
            let url = NSURL(string: urlStr)
            UIApplication.sharedApplication().openURL(url!)
        }
    }
}

extension PullDetailViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listOfPulls.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PullDetailCell") as! PullDetailTableViewCell
        
        let pullReq = self.listOfPulls[indexPath.row]
        
        cell.setup(pullReq)
        
        return cell
    }
}

extension PullDetailViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func customViewForEmptyDataSet(scrollView: UIScrollView!) -> UIView! {
        if self.isLoading {
            return UIView()
        }
        
        return self.emptyView
    }
}

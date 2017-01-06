//
//  HomeViewController.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 02/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

let LOADING_TAG: Int = 2969
class HomeViewController: UIViewController {

    // MARK - Storyboard restoration
    class func newInstanceFromStoryboard() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        
        return vc
    }
    
    // MARK - Attributes
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet var emptyView: UIView!
    @IBOutlet weak var emptyTextLbl: UILabel!
    
    var page: Int = 1
    var itemsArray: [Repository] = [Repository]()
    var isLoading: Bool =  false
    
    // MARK - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        
        self.getJavaRepositories()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "GitHub JavaPop"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK - Service Functions
    func getJavaRepositories() {
        if self.page == 1 {
            self.showLoading()
            
        }
        
        self.isLoading = true
        SearchRepositoryService.getJavaRepository(self.page, onSuccess: { (javaRepositories, serviceResponse) in
            if javaRepositories != nil {
                for repo in (javaRepositories?.items)! {
                    self.itemsArray.append(repo)
                }
            } else {
                self.displaySingleButtonAlert("Unexpected error", message: "There is an error with communicating with server. Try again later", buttonTitle: "Ok", buttonCallback: { (alert) in
                    self.navigationController?.popViewControllerAnimated(true)
                })
            }
        }, onFailure: { (err) in
            self.displayAlertForServiceWrap(err, dismissBlock: {
                self.navigationController?.popViewControllerAnimated(true)
            })
            
        }, onCompleted: {
            self.hideLoading()
            self.tblView.reloadData()
            self.isLoading = false
        })
    }
}

// For threating delegate methods, like click actions
extension HomeViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = PullDetailViewController.newInstanceFromStoryboard()
        
        vc.repository = self.itemsArray[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// For data source methods, to create and customizating cells
extension HomeViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.itemsArray.count > 0 {
            return itemsArray.count + 1
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < self.itemsArray.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as! HomeTableViewCell
            let javaRepo = self.itemsArray[indexPath.row]
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.setup(javaRepo)
            return cell
        } else {
            let loadingCell = tableView.dequeueReusableCellWithIdentifier("LoadingCell") as! LoadingTableViewCell
            loadingCell.tag = LOADING_TAG
            loadingCell.setup()
            
            return loadingCell
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.tag == LOADING_TAG {
            self.page += 1
            self.getJavaRepositories()
        }
    }
}

extension HomeViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func customViewForEmptyDataSet(scrollView: UIScrollView!) -> UIView! {
        if self.isLoading {
            return UIView()
        }
        
        return self.emptyView
    }
}

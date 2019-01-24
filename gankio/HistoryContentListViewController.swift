//
//  HistoryContentListViewController.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/20.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import UIKit

class HistoryContentListViewController: UITableViewController, HistContentView {
    
    private var contentList: [Content] = []
    private var dateFormatter = DateFormatter()
    
    var threshold: CGFloat = 0.7

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.timeZone = TimeZone(identifier: "CST")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        HistoryContentPresenterImpl(view: self)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contentList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentItem", for: indexPath)
        let content = contentList[indexPath.row]
        let contentItem = cell.contentView.subviews[0] as? HistoryContentCell
        contentItem?.dateText = dateFormatter.string(from: content.publishedAt!)
        contentItem?.title = content.title
        contentItem?.imageUrl = getImageUrl(content: content.content)
//        let imageViewHeigh = (self.view.frame.width - 20) / 2
//        contentItem?.heightAnchor.constraint(equalToConstant: imageViewHeigh).isActive = true
//        cell.contentView.heightAnchor.constraint(equalToConstant: imageViewHeigh + 10)
        return cell
    }
    
    private func getImageUrl(content: String?) -> String? {
        var range = content?.range(of: "src")
        if range == nil {
            return nil
        }
        let startIndex = content?.index(range!.upperBound, offsetBy: 2)
        if startIndex == nil {
            return nil
        }
        var subString = content?.suffix(from: startIndex!)
        range = subString?.range(of: "\"")
        if range == nil {
            return nil
        }
        guard let str = subString?.prefix(upTo: range!.lowerBound) else {
            return nil
        }
        return String(str)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    typealias T = HistoryContentPresenterImpl<HistoryContentListViewController>
    
    var presenter: HistoryContentPresenterImpl<HistoryContentListViewController>? {
        didSet {
            presenter?.start()
        }
    }
    
    func addHistContentList(contents: [Content]?) {
        if contents == nil {
            fatalError()
        }
        contentList.append(contentsOf: contents!)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let current = scrollView.contentOffset.y + scrollView.frame.height
        let total = scrollView.contentSize.height
        if (current == 0 || total == 0) {
            return
        }
        let ratio = current / total
        if ratio >= threshold {
            presenter?.loadNextPage()
        }
    }
    @IBAction func onBackClick(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showDetail":
            guard let detailController = segue.destination as? FirstViewController else {
                fatalError()
            }
            guard let selectCell = sender as? UITableViewCell else {
                fatalError()
            }
            guard let index = tableView.indexPath(for: selectCell) else {
                fatalError()
            }
            let content = contentList[index.row]
            detailController.currentDate = content.publishedAt
        default:
            fatalError()
        }
    }
    
}

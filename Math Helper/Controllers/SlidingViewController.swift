//
//  SlidingViewController.swift
//  Math Helper
//
//  Created by Geniusjames on 09/01/2022.
//

import UIKit
 import NavigationDrawer

class SlidingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var menuItems = ["Equation Solver", "Offline Calculator", "Number Facts", "Math Wiki", "Math Formula"]
    var interactor: Interactor?
    override func viewDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "menu")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Handle Gesture
    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        let progress = MenuHelper.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .left)

        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor) {
                self.dismiss(animated: true, completion: nil)
            }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as? MenuTableViewCell
        else {
            return UITableViewCell()
        }
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    @IBAction func closeBtnPressed(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}

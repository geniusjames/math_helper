//
//  BaseViewController.swift
//  Math Helper
//
//  Created by Geniusjames on 09/01/2022.
//

import UIKit
import NavigationDrawer

class BaseViewController: UITabBarController {

    let interactor = Interactor()
    override func viewDidLoad() {
        super.viewDidLoad()

        let edgeSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(swipeGesture))
        edgeSwipe.edges = .left

        self.view.addGestureRecognizer(edgeSwipe)
        // Do any additional setup after loading the view.
    }

    @IBAction func homeButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showMenu", sender: nil)
    }
    @objc func swipeGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: view)

        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .right)

        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor) {
                self.performSegue(withIdentifier: "showMenu", sender: nil)
            }
    }
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: view)

        let progress = MenuHelper.calculateProgress(translationInView: translation,
                                                    viewBounds: view.bounds,
                                                    direction: .right)

        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor) {
                self.performSegue(withIdentifier: "showMenu", sender: nil)
            }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SlidingViewController {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = self.interactor
        }
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
extension BaseViewController: UIViewControllerTransitioningDelegate {

func animationController(forPresented presented: UIViewController,
                         presenting: UIViewController,
                         source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return PresentMenuAnimator(direction: .left)
}

func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
return DismissMenuAnimator()
}

func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
return interactor.hasStarted ? interactor : nil
}

func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
return interactor.hasStarted ? interactor : nil
}
}

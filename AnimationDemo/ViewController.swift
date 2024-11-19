//
//  ViewController.swift
//  AnimationDemo
//
//  Created by Priyal on 18/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var selIndex : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
        //tblView.register(UINib(nibName: "TblCell", bundle: nil), forCellReuseIdentifier: "TblCell")
        // Do any additional setup after loading the view.
    }


}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TblCell", for: indexPath)
        let randomColor = UIColor(
                red: CGFloat.random(in: 0...1),
                green: CGFloat.random(in: 0...1),
                blue: CGFloat.random(in: 0...1),
                alpha: 1.0
            )
            
            // Set the cell's background color
            cell.backgroundColor = randomColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedCellFrame = tableView.rectForRow(at: indexPath)
    let selectedCellFrameInSuperview = tableView.convert(selectedCellFrame, to: tableView.superview)
                
                let story = UIStoryboard(name: "selectView", bundle: nil)
                let detailVC = story.instantiateViewController(withIdentifier: "selectVC")as! selectVC
        if let selectedCell = tableView.cellForRow(at: indexPath) {
            detailVC.view.backgroundColor = selectedCell.backgroundColor
          }
        selIndex = indexPath.row
    detailVC.modalPresentationStyle = .custom
    detailVC.transitioningDelegate = self
    detailVC.startingFrame = selectedCellFrameInSuperview
        detailVC.endingFrame = selectedCellFrameInSuperview
    present(detailVC, animated: true, completion: nil)
}
    
}
extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentationAnimator(startingFrame: (presented as? selectVC)?.startingFrame ?? .zero)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomDismissAnimator(endingFrame: (dismissed as? selectVC)?.endingFrame ?? .zero)
       }
}
class CustomPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let startingFrame: CGRect

    init(startingFrame: CGRect) {
        self.startingFrame = startingFrame
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        toView.frame = startingFrame
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.frame = containerView.bounds
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
class CustomDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let endingFrame: CGRect
    
    init(endingFrame: CGRect) {
        
        self.endingFrame = endingFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.frame = self.endingFrame
            fromView.clipsToBounds = true
        }) { _ in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

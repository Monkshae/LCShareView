//
//  CustomPresentationController.swift
//  LCShareView
//
//  Created by licong on 16/9/20.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit


//有关UIPresentationController 详见http://www.cocoachina.com/industry/20140707/9053.html
class CustomPresentationController: UIPresentationController {

    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        presentedViewController.modalPresentationStyle = .Custom
    }
    
    //alpha为0.5的蒙版， UIPresentationController 的子类是负责「被呈现」及「负责呈现」的 controller 以外的 controller，这里主要就是半透明的蒙版
    lazy var dimmingView: UIView = {
        let dimmingView = UIView(frame: (self.containerView?.bounds)!)
        dimmingView.backgroundColor = UIColor.blackColor()
        dimmingView.opaque = false
        dimmingView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CustomPresentationController.dimmingViewTapped(_:))))
        return dimmingView
    }()
    
    //点击蒙层触发事件
    func dimmingViewTapped(sender: UITapGestureRecognizer) {
        self.presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*下面是UIPresentationController四个周期方法 */
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        let view = presentedView()!
        view.layer.shadowOpacity = 0.44
        view.layer.shadowRadius = 13
        view.layer.shadowOffset = CGSizeMake(0, -6)
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        containerView?.addSubview(view)
        
        //添加过渡过程中的半透明的背景图
        containerView?.addSubview(dimmingView)
        //转场动画调度器,transitionCoordinator确保我们的动画与其他动画一道儿播放。
        let transitionCoordinator = presentingViewController.transitionCoordinator()
        dimmingView.alpha = 0.0
        transitionCoordinator?.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext) in
            self.dimmingView.alpha = 0.5
            }, completion: nil)
    }
    
    //如果present没有完成，清除临时视图dimmingView
    override func presentationTransitionDidEnd(completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    //dismiss开始时,让dimmingView慢慢透明，animateAlongsideTransition保证了了个动画和animator中的动画同时执行
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        let transitionCoordinator = presentingViewController.transitionCoordinator()
        transitionCoordinator?.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext) in
            self.dimmingView.alpha = 0.0
            }, completion: nil)
    }
    
    //dismiss结束时,从视图结构中删除dimmingView
    override func dismissalTransitionDidEnd(completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    //是否remove presentedView,默认是false
    override func shouldRemovePresentersView() -> Bool{
        return false
    }
}


//这里是改变了presentedView的大小
extension CustomPresentationController {
    //当一个容器ViewController的ChildViewController的这个值改变时，UIKit会调用preferredContentSizeDidChangeForChildContentContainer这个方法告诉当前容器ViewController。我们可以在这个方法里根据新的Size对界面进行调整。
    override func preferredContentSizeDidChangeForChildContentContainer(container: UIContentContainer) {
        super.preferredContentSizeDidChangeForChildContentContainer(container)
        
        if let container = container as? UIViewController where
            container == self.presentedViewController{
            self.containerView?.setNeedsLayout()
        }
    }
    
    /* 1.一个容器ViewController可以使用这个方法设置ChildViewController的size。当容器ViewControllerviewWillTransitionToSize:withTransitionCoordinator:被调用时(我们重写这个方法时要调用Super)
     2.sizeForChildContentContainer方法将会被调用。然后我们可以把需要设置的size发送给ChildViewController。
     3.当我们设置的这个size和当前ChildViewController的size一样，那么ChildViewController的viewWillTransitionToSize方法将不会被调用。
     4.sizeForChildContentContainer默认的实现是返回 parentSize
     */
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if let container = container as? UIViewController where
            container == self.presentedViewController{
            return container.preferredContentSize
        }
        else {
            return super.sizeForChildContentContainer(container, withParentContainerSize: parentSize)
        }
    }
    
    //在我们的自定义呈现中，被呈现的 view 并没有完全完全填充整个屏幕，而是很小的一个矩形。被呈现的 view 的过渡动画之后的最终位置，是由 UIPresentationViewController 来负责定义的。我们重载 frameOfPresentedViewInContainerView
    override func frameOfPresentedViewInContainerView() -> CGRect {
        let containerViewBounds = containerView?.bounds
        let presentedViewContentSize = sizeForChildContentContainer(presentedViewController, withParentContainerSize: (containerViewBounds?.size)!)
        let presentedViewControllerFrame = CGRectMake(containerViewBounds!.origin.x, CGRectGetMaxY(containerViewBounds!) - presentedViewContentSize.height, (containerViewBounds?.size.width)!, presentedViewContentSize.height)
        return presentedViewControllerFrame
    }
    
    //slide滑动时候触发,手动更改presentedView的frame
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        dimmingView.frame = (self.containerView?.bounds)!
        presentedView()?.frame = self.frameOfPresentedViewInContainerView()
    }
}


extension CustomPresentationController: UIViewControllerTransitioningDelegate {
    
    
}
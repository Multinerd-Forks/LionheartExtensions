//
//  UIView.swift
//  Upriise
//
//  Created by Daniel Loewenherz on 11/13/15.
//  Copyright © 2015 Upriise LLC. All rights reserved.
//

import Foundation

/**
 Auto Layout and general utility methods for `UIView`.
 
 - author: Daniel Loewenherz
 - copyright: ©2016 Lionheart Software LLC
 - date: February 18, 2016
 */
public extension UIView {
    /**
     Remove all subviews of the calling `UIView`.

     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    func centerOnXAxis() {
        centerXAnchor.constraintEqualToAnchor(superview?.centerXAnchor).active = true
    }
    
    func centerOnYAxis() {
        centerYAnchor.constraintEqualToAnchor(superview?.centerYAnchor).active = true
    }

    /**
     Set the height of this view to a specified value using Auto Layout.
    
     - parameter height: A `Float` specifying the view's height.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
    */
    func setHeight(height: CGFloat) {
        heightAnchor.constraintEqualToConstant(height).active = true
    }
    
    /**
     Set the width of this view to a specified value using Auto Layout.
     
     - parameter width: A `Float` specifying the view's width.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func setWidth(width: CGFloat) {
        widthAnchor.constraintEqualToConstant(width).active = true
    }

    /**
     Set the size of the view using Auto Layout.
     
     - parameter size: A `CGSize` specifying the view's size.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func setContentSize(size: CGSize) {
        widthAnchor.constraintEqualToConstant(size.width).active = true
        heightAnchor.constraintEqualToConstant(size.height).active = true
    }

    /**
     Pin the view's horizontal edges to the left and right of its superview.

     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func fillWidthOfSuperview() {
        fillWidthOfSuperview(margin: 0)
    }

    /**
     Pin the view's vertical edges to the top and bottom of its superview.
     
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func fillHeightOfSuperview() {
        fillHeightOfSuperview(margin: 0)
    }

    /**
     Pin the view's horizontal edges to the left and right of its superview with a margin.
     
     - parameter margin: A `CGFloat` representing the horizontal margin.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func fillWidthOfSuperview(margin margin: CGFloat) {
        if let superview = superview {
            leftAnchor.constraintEqualToAnchor(superview.leftAnchor, constant: margin).active = true
            rightAnchor.constraintEqualToAnchor(superview.rightAnchor, constant: -margin).active = true
        }
    }

    /**
     Pin the view's vertical edges to the top and bottom of its superview with a margin.
     
     - parameter margin: A `CGFloat` representing the vertical margin.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func fillHeightOfSuperview(margin margin: CGFloat) {
        if let superview = superview {
            topAnchor.constraintEqualToAnchor(superview.topAnchor, constant: margin).active = true
            bottomAnchor.constraintEqualToAnchor(superview.bottomAnchor, constant: -margin).active = true
        }
    }

    /**
     Pin the view's edges to the top, bottom, left, and right of its superview with a margin.
     
     - parameter axis: Optional. Specify only when you want to pin the view to a particular axis.
     - parameter margin: A `CGFloat` representing the vertical margin.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func fillSuperview(axis: UILayoutConstraintAxis? = nil, margin: CGFloat = 0) {
        if let axis = axis {
            switch (axis) {
            case .Horizontal:
                fillWidthOfSuperview(margin: margin)

            case .Vertical:
                fillHeightOfSuperview(margin: margin)
            }
        }
        else {
            fillWidthOfSuperview(margin: margin)
            fillHeightOfSuperview(margin: margin)
        }
    }

    /**
     Apply the specified visual format constraints to the current view. The "view" placeholder is used in the provided VFL string. Usage can best be illustrated through examples:
     
     Pin a `UIView` to the left and right of its superview with a 20px margin:

     ```
     let view = UIView()
     view.addVisualFormatConstraints("|-20-[view]-20-|")
     ```
     
     Set a view to be at least 36px high, and at least 16px from the top of its superview.
     
     ```
     view.addVisualFormatConstraints("V:|-(>=16)-[view(>36)]")
     ```
     
     - parameter format: The format specification for the constraints. For more information, see Visual Format Language in Auto Layout Guide.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func addVisualFormatConstraints(format: String) {
        let views = [
            "view": self,
        ]

        UIView.addConstraints(format, views: views)
    }

    /**
     Apply the VFL format constraints to the specified views, with the provided metrics.
     
     - parameter format: The format specification for the constraints. For more information, see Visual Format Language in Auto Layout Guide.
     - parameter metrics: A dictionary of constants that appear in the visual format string. The dictionary’s keys must be the string values used in the visual format string. Their values must be NSNumber objects.
     - parameter views: A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    class func addConstraints(format: String, metrics: [String: AnyObject]? = nil, views: [String: UIView]) {
        let options = NSLayoutFormatOptions(rawValue: 0)
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: metrics, views: views)

        for constraint in constraints {
            constraint.active = true
        }
    }

    /**
    Return the given distance from a view to a specified `CGPoint`.
    
    - parameter point: The `CGPoint` to measure the distance to.
    - returns: A `Float` representing the distance to the specified `CGPoint`.
    - author: Daniel Loewenherz
    - copyright: ©2016 Lionheart Software LLC
    - date: February 17, 2016
    */
    func distanceToPoint(point: CGPoint) -> Float {
        if CGRectContainsPoint(frame, point) {
            return 0
        }

        var closest: CGPoint = frame.origin
        let size = frame.size
        if frame.origin.x + size.width < point.x {
            closest.x += size.width
        }
        else if point.x > frame.origin.x {
            closest.x = point.x
        }
        
        if frame.origin.y + size.height < point.y {
            closest.y += size.height
        }
        else if point.y > frame.origin.y {
            closest.y = point.y
        }

        let a = powf(Float(closest.y-point.y), 2)
        let b = powf(Float(closest.x-point.x), 2)
        return sqrtf(a + b)
    }
    
    // MARK - Misc
    
    func centerRect() -> CGRect {
        return CGRect(x: CGRectGetWidth(frame) / 2, y: CGRectGetHeight(frame), width: 1, height: 1)
    }

    func recursiveSubviews<T>(passingTest test: (T) -> Bool = { _ in true }) -> [T] {
        var views: [T] = []
        for view in subviews {
            if let view = view as? T {
                if test(view) {
                    views.append(view)
                }
            }

            views.appendContentsOf(view.recursiveSubviews(passingTest: test))
        }
        return views
    }
}

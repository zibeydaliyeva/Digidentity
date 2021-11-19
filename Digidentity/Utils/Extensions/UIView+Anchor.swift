//
//  UIView+Anchor.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 16.11.21.
//

import UIKit

enum Anchor {
    case fillSuperview(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0, isSafeArea: Bool = false)
    case fillSuperviewPadding(_ padding: CGFloat, isSafeArea: Bool = false)
    
    case top(_ top: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0, priority: UILayoutPriority? = UILayoutPriority.required)
    case topGreater(_ top: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0)
    case topLess(_ top: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0)
    
    case leading(_ leading: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0, priority: UILayoutPriority? = UILayoutPriority.required)
    case leadingGreater(_ leading: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0)
    case leadingLess(_ leading: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0)
    
    case bottom(_ bottom: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0, priority: UILayoutPriority? = UILayoutPriority.required)
    case bottomGreater(_ bottom: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0)
    case bottomLess(_ bottom: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0)
    
    case trailing(_ trailing: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0, priority: UILayoutPriority? = UILayoutPriority.required)
    case trailingGreater(_ trailing: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0)
    case trailingLess(_ trailing: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0)
    
    case height(_ constant: CGFloat, priority: UILayoutPriority? = UILayoutPriority.required)
    case heightEqualTo(_ height: NSLayoutAnchor<NSLayoutDimension>, constant: CGFloat = 0)
    
    case heightGreater(_ constant: CGFloat)
    case heightLess(_ constant: CGFloat)
    case heightTo(_ view: UIView,  multiplier: CGFloat = 1, priority: UILayoutPriority? = UILayoutPriority.required)
    
    case width(_ constant: CGFloat, priority: UILayoutPriority? = UILayoutPriority.required)
    case widthGreater(_ constant: CGFloat)
    case widthLess(_ constant: CGFloat)
    case widthTo(_ view: UIView, multiplier: CGFloat = 1, priority: UILayoutPriority? = UILayoutPriority.required)
    case widthEqual(_ equalTo:  NSLayoutDimension, multiplier: CGFloat = 1)
    
    case size(width: CGFloat, height: CGFloat)
    case sizeTo(_ view: UIView)
    
    case centerX(_ centerX: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0)
    case centerY(_ centerY: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0)
    case centerSuperview(x: CGFloat = 0, y: CGFloat = 0)
}

extension Anchor {
    
    static func top(_ top: NSLayoutYAxisAnchor) -> Anchor {
        return .top(top, constant: 0, priority: nil)
    }

    static func top(_ constant: CGFloat) -> Anchor {
        return .top(nil, constant: constant, priority: nil)
    }
    
    static func top(_ top: NSLayoutYAxisAnchor, constant: CGFloat) -> Anchor {
        return .top(top, constant: constant, priority: nil)
    }
    
    
    static func bottom(_ bottom: NSLayoutYAxisAnchor) -> Anchor {
        return .bottom(bottom, constant: 0, priority: nil)
    }

    static func bottom(_ constant: CGFloat) -> Anchor {
        return .bottom(nil, constant: constant, priority: nil)
    }
    
    static func bottom(_ bottom: NSLayoutYAxisAnchor, constant: CGFloat) -> Anchor {
        return .bottom(bottom, constant: constant, priority: nil)
    }
    
    
    static func leading(_ leading: NSLayoutXAxisAnchor) -> Anchor {
        return .leading(leading, constant: 0, priority: nil)
    }

    static func leading(_ constant: CGFloat) -> Anchor {
        return .leading(nil, constant: constant, priority: nil)
    }
    
    
    static func trailing(_ trailing: NSLayoutXAxisAnchor) -> Anchor {
        return .trailing(trailing, constant: 0, priority: nil)
    }

    static func trailing(_ constant: CGFloat) -> Anchor {
        return .trailing(nil, constant: constant, priority: nil)
    }
}

extension UIView {
    
    func anchor(_ anchors: Anchor...) {
        translatesAutoresizingMaskIntoConstraints = false
        
        anchors.forEach { anchor in
            switch anchor {
            case .fillSuperview(let top, let leading, let bottom, let trailing, let isSafeArea):
                var topAnchor: NSLayoutYAxisAnchor?
                var leadingAnchor: NSLayoutXAxisAnchor?
                var bottomAnchor: NSLayoutYAxisAnchor?
                var trailingAnchor: NSLayoutXAxisAnchor?
                
                if isSafeArea {
                    topAnchor = superview?.safeAreaTopAnchor
                    leadingAnchor = superview?.safeAreaLeadingAnchor
                    bottomAnchor = superview?.safeAreaBottomAnchor
                    trailingAnchor = superview?.safeAreaTrailingAnchor
                }
                
                self.anchor(
                    .top(topAnchor, constant: top),
                    .leading(leadingAnchor, constant: leading),
                    .bottom(bottomAnchor, constant: bottom),
                    .trailing(trailingAnchor, constant: trailing))
                
            case .fillSuperviewPadding(let padding, let isSafeArea):
                self.anchor(.fillSuperview(top: padding, leading: padding, bottom: -padding, trailing: -padding, isSafeArea: isSafeArea))
                
            case .top(let anchor, let constant, let priority):
                let equalTo = (anchor == nil) ? superview!.topAnchor : anchor
                let constraint = topAnchor.constraint(equalTo: equalTo!, constant: constant)
                if let priority = priority {
                    constraint.priority = priority
                }
                constraint.isActive = true
                
            case .topGreater(let anchor, let constant):
                let equalTo = (anchor == nil) ? superview!.topAnchor : anchor
                topAnchor.constraint(greaterThanOrEqualTo: equalTo!, constant: constant).isActive = true
                
            case .topLess(let anchor, let constant):
                let equalTo = (anchor == nil) ? superview!.topAnchor : anchor
                topAnchor.constraint(lessThanOrEqualTo: equalTo!, constant: constant).isActive = true
                
                
            case .leading(let anchor, let constant, let priority):
                let equalTo = (anchor == nil) ? superview!.leadingAnchor : anchor
                let constraint = leadingAnchor.constraint(equalTo: equalTo!, constant: constant)
                if let priority = priority {
                    constraint.priority = priority
                }
                constraint.isActive = true
                
            case .leadingGreater(let anchor, let constant):
                let equalTo = (anchor == nil) ? superview!.leadingAnchor : anchor
                leadingAnchor.constraint(greaterThanOrEqualTo: equalTo!, constant: constant).isActive = true
                
            case .leadingLess(let anchor, let constant):
                let equalTo = (anchor == nil) ? superview!.leadingAnchor : anchor
                leadingAnchor.constraint(lessThanOrEqualTo: equalTo!, constant: constant).isActive = true
                
                
            case .bottom(let anchor, let constant, let priority):
                let equalTo = (anchor == nil) ? superview!.bottomAnchor : anchor
                let constraint = bottomAnchor.constraint(equalTo: equalTo!, constant: constant)
                if let priority = priority {
                    constraint.priority = priority
                }
                constraint.isActive = true
                
            case .bottomGreater(let anchor, let constant):
                let equalTo = (anchor == nil) ? superview!.bottomAnchor : anchor
                bottomAnchor.constraint(greaterThanOrEqualTo: equalTo!, constant: constant).isActive = true
                
            case .bottomLess(let anchor, let constant):
                let equalTo = (anchor == nil) ? superview!.bottomAnchor : anchor
                bottomAnchor.constraint(lessThanOrEqualTo: equalTo!, constant: constant).isActive = true
                
                
            case .trailing(let anchor, let constant, let priority):
                let equalTo = (anchor == nil) ? superview!.trailingAnchor : anchor
                let constraint = trailingAnchor.constraint(equalTo: equalTo!, constant: constant)
                if let priority = priority {
                    constraint.priority = priority
                }
                constraint.isActive = true
                
            case .trailingGreater(let anchor, let constant):
                let equalTo = (anchor == nil) ? superview!.trailingAnchor : anchor
                trailingAnchor.constraint(greaterThanOrEqualTo: equalTo!, constant: constant).isActive = true
                
            case .trailingLess(let anchor, let constant):
                let equalTo = (anchor == nil) ? superview!.trailingAnchor : anchor
                trailingAnchor.constraint(lessThanOrEqualTo: equalTo!, constant: constant).isActive = true
                
            case .heightEqualTo(let anchor, let constant):
                heightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
                
            case .height(let constant, let priority):
                if constant > 0 {
                    let constraint = heightAnchor.constraint(equalToConstant: constant)
                    if let priority = priority {
                        constraint.priority = priority
                    }
                    constraint.isActive = true
                }
                
            case .heightGreater(let constant):
                heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
                
            case .heightLess(let constant):
                heightAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
                
            case .heightTo(let view, let multiplier, let priority):
                let constraint = heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier)
                if let priority = priority {
                    constraint.priority = priority
                }
                constraint.isActive = true
                
                
            case .width(let constant, let priority):
                if constant > 0 {
                    let constraint = widthAnchor.constraint(equalToConstant: constant)
                    if let priority = priority {
                        constraint.priority = priority
                    }
                    constraint.isActive = true
                }
                
            case .widthGreater(let constant):
                widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
                
            case .widthLess(let constant):
                widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
                
            case .widthTo(let view, let multiplier, let priority):
                let constraint = widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier)
                if let priority = priority {
                    constraint.priority = priority
                }
                constraint.isActive = true
                
            case .widthEqual(let dimension, let multiplier):
                let constraint = widthAnchor.constraint(equalTo: dimension, multiplier: multiplier)
                constraint.isActive = true
                
            case .size(let width, let height):
                if width != 0 {
                    widthAnchor.constraint(equalToConstant: width).isActive = true
                }
                
                if height != 0 {
                    heightAnchor.constraint(equalToConstant: height).isActive = true
                }
                
            case .sizeTo(let view):
                widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
                heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
                
                
            case .centerX(let anchor, let constant):
                let equalTo = (anchor == nil) ? superview!.centerXAnchor : anchor
                centerXAnchor.constraint(equalTo: equalTo!, constant: constant).isActive = true
                
            case .centerY(let anchor, let constant):
                let equalTo = (anchor == nil) ? superview!.centerYAnchor : anchor
                centerYAnchor.constraint(equalTo: equalTo!, constant: constant).isActive = true
                
            case .centerSuperview(let x, let y):
                self.anchor(.centerX(constant: x), .centerY(constant: y))
            }
        }
    }
    
    var safeAreaTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }

    var safeAreaBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }

    var safeAreaLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leadingAnchor
        } else {
            return self.leadingAnchor
        }
    }

    var safeAreaTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.trailingAnchor
        } else {
            return self.trailingAnchor
        }
    }
    
}




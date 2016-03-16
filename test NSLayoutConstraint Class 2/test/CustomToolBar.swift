import UIKit

/**
 Swift NSDictionaryOfVariableBindings substitute

 - parameter arr: UIView array: (view1, view2)

 - returns: return ["v1": UIView, "v2": view2]
 */
func dictionaryOfNames(arr: UIView ...) -> [String: UIView] {
    var d = [String: UIView]()
    for (ix, v) in arr.enumerate() {
        d["v\(ix+1)"] = v
    }
    return d
}

class CustomToolBar: UIView {

    var textField: UITextField!
    var commentCountButton: UIButton!
    var commentImageButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {

        let topLine = UIView()
        topLine.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        self.addSubview(topLine)

        textField = UITextField()
        textField.placeholder = "Write some in your deep mind."
        self.addSubview(textField)

        commentImageButton = UIButton(type: .Custom)
        commentImageButton.setBackgroundImage(UIImage(named: "comment"), forState: .Normal)
        self.addSubview(commentImageButton)

        commentCountButton = UIButton(type: .Custom)
        commentCountButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        commentCountButton.setTitle("8888888888", forState: .Normal)
        commentCountButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.addSubview(commentCountButton)

        topLine.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        commentImageButton.translatesAutoresizingMaskIntoConstraints = false
        commentCountButton.translatesAutoresizingMaskIntoConstraints = false

        // NSLayoutConstraintsHelper.swift
        let d = dictionaryOfNames(topLine, textField, commentImageButton, commentCountButton)

        self.addConstraints([
            NSLayoutConstraint.constraintsWithVisualFormat("H:|[v1]|", options: [], metrics: nil, views: d),
            NSLayoutConstraint.constraintsWithVisualFormat("V:|[v1(0.5)]", options: [], metrics: nil, views: d),

        NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[v2]-[v3(14)][v4]-|", options: .AlignAllCenterY, metrics: nil, views: d),
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-[v2]-|", options: [], metrics: nil, views: d),
            NSLayoutConstraint.constraintsWithVisualFormat("V:[v3(14)]", options: [], metrics: nil, views: d),
            NSLayoutConstraint.constraintsWithVisualFormat("V:[v4(14)]", options: [], metrics: nil, views: d),
        ].flatten().map { $0 })
    }
}


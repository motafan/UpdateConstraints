//
//  ViewController.swift
//  UpdateConstraints
//
//  Created by 风起兮 on 2024/4/8.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let customView = CustomView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .systemPink
        view.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customView.widthAnchor.constraint(equalToConstant: 270),
            customView.heightAnchor.constraint(equalToConstant: 270)
        ])
    }


}


class CustomView: UIView {

    let button = UIButton(type: .system)
    let label = UILabel()

    var isLabelCentered = true

    private var labelCenterXConstraint: NSLayoutConstraint!
    private var labelLeadingConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .white

        button.setTitle("Move Label", for: .normal)
        button.addTarget(self, action: #selector(moveLabel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)

        label.text = "Label"
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        // Button constraints
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])

        // Label constraints
        labelCenterXConstraint = label.centerXAnchor.constraint(equalTo: centerXAnchor)
        labelLeadingConstraint = label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelCenterXConstraint
        ])
    }

    override func updateConstraints() {
        if isLabelCentered {
            NSLayoutConstraint.deactivate([labelLeadingConstraint])
            NSLayoutConstraint.activate([labelCenterXConstraint])
        } else {
            NSLayoutConstraint.deactivate([labelCenterXConstraint])
            NSLayoutConstraint.activate([labelLeadingConstraint])
        }
        super.updateConstraints()
    }


    @objc func moveLabel() {
        isLabelCentered.toggle()
        self.setNeedsUpdateConstraints()
        if let superview {
            UIView.animate(withDuration: 0.3) {
                superview.layoutIfNeeded()
            }
        }
    }

}

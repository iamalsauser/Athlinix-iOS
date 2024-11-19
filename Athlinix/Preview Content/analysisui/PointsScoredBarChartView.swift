//
//  PointsScoredBarChartView.swift
//  GamePlay
//
//  Created by admin65 on 19/11/24.
//

import UIKit

class PointsScoredBarChartView: UIView {
    
        let years = [ "2018", "2019", "2020", "2021", "2022"]
        let values: [CGFloat] = [300, 800, 200, 400, 300]
        
        private var popupLabel: UILabel?

        override func draw(_ rect: CGRect) {
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            // Setup dimensions and styles
            let maxBarHeight: CGFloat = rect.height * 0.6
            let barWidth: CGFloat = rect.width / CGFloat(years.count) * 0.4
            let spacing: CGFloat = (rect.width / CGFloat(years.count)) * 0.6
            let maxValue: CGFloat = 800
            let originY: CGFloat = rect.height * 0.8
            let baseColor = UIColor.systemPurple.withAlphaComponent(0.5)
            let lineColor = UIColor.systemRed
            
            // Draw grid lines and values
            let gridLineColor = UIColor.lightGray.withAlphaComponent(0.4)
            context.setStrokeColor(gridLineColor.cgColor)
            context.setLineWidth(1)
            
            let numGridLines = 5
            let gridValueSpacing = maxValue / CGFloat(numGridLines)
            let labelFont = UIFont.systemFont(ofSize: 12)
            let labelColor = UIColor.darkGray
            
            for i in 0...numGridLines {
                let y = originY - (CGFloat(i) / CGFloat(numGridLines) * maxBarHeight)
                
                // Draw grid line
                context.move(to: CGPoint(x: 0, y: y))
                context.addLine(to: CGPoint(x: rect.width, y: y))
                
                // Draw value labels for grid
                let gridValue = Int(gridValueSpacing * CGFloat(i))
                let valueLabel = UILabel()
                valueLabel.text = "\(gridValue)"
                valueLabel.font = labelFont
                valueLabel.textColor = labelColor
                valueLabel.sizeToFit()
                valueLabel.frame.origin = CGPoint(x: 4, y: y - valueLabel.frame.height / 2)
                self.addSubview(valueLabel)
            }
            context.strokePath()
            
            let leftMargin: CGFloat = 24
            // Draw bars and dots
            for (index, value) in values.enumerated() {
                let x = leftMargin + CGFloat(index) * (barWidth + spacing)
                let barHeight = (value / maxValue) * maxBarHeight
                let barRect = CGRect(x: x, y: originY - barHeight, width: barWidth, height: barHeight)
                
                
                context.setFillColor(baseColor.cgColor)
                context.fill(barRect)
                
                // Draw the dot
                let circleCenter = CGPoint(x: barRect.midX, y: barRect.minY)
                let circleRadius: CGFloat = 6
                context.setFillColor(lineColor.cgColor)
                context.addEllipse(in: CGRect(x: circleCenter.x - circleRadius,
                                              y: circleCenter.y - circleRadius,
                                              width: circleRadius * 2,
                                              height: circleRadius * 2))
                context.fillPath()
                
                // Draw year labels below bars
                let yearLabel = UILabel()
                yearLabel.text = years[index]
                yearLabel.font = labelFont
                yearLabel.textColor = labelColor
                yearLabel.textAlignment = .center
                yearLabel.sizeToFit()
                yearLabel.center = CGPoint(x: barRect.midX, y: originY + yearLabel.frame.height)
                self.addSubview(yearLabel)
            }
            
            // Draw connecting line
            context.setStrokeColor(lineColor.cgColor)
            context.setLineWidth(2)
            context.setLineJoin(.round)
            
            context.beginPath()
            for (index, value) in values.enumerated() {
                let x = CGFloat(index) * (barWidth + spacing) + spacing / 2 + barWidth / 2
                let y = originY - (value / maxValue) * maxBarHeight
                if index == 0 {
                    context.move(to: CGPoint(x: x, y: y))
                } else {
                    context.addLine(to: CGPoint(x: x, y: y))
                }
            }
            context.strokePath()
        }
        
        // Handle touches
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            
            // Detect which dot is touched
            let maxBarHeight: CGFloat = self.bounds.height * 0.6
            let barWidth: CGFloat = self.bounds.width / CGFloat(years.count) * 0.4
            let spacing: CGFloat = (self.bounds.width / CGFloat(years.count)) * 0.6
            let maxValue: CGFloat = 800
            let originY: CGFloat = self.bounds.height * 0.8
            
            for (index, value) in values.enumerated() {
                let x = CGFloat(index) * (barWidth + spacing) + spacing / 2 + barWidth / 2
                let y = originY - (value / maxValue) * maxBarHeight
                
                let dotRadius: CGFloat = 10
                let dotFrame = CGRect(x: x - dotRadius, y: y - dotRadius, width: dotRadius * 2, height: dotRadius * 2)
                
                if dotFrame.contains(location) {
                    // Show the popup
                    showPopup(at: CGPoint(x: x, y: y), value: value)
                    break
                }
            }
        }
        
        // Show a popup for the selected dot
        private func showPopup(at point: CGPoint, value: CGFloat) {
            // Remove any existing popup
            popupLabel?.removeFromSuperview()
            
            // Create a new label
            let label = UILabel()
            label.text = "\(Int(value))"
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = .white
            label.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            label.textAlignment = .center
            label.layer.cornerRadius = 6
            label.clipsToBounds = true
            label.sizeToFit()
            
            // Add padding to the label
            label.frame.size.width += 16
            label.frame.size.height += 8
            label.center = CGPoint(x: point.x, y: point.y - label.frame.height / 2 - 10)
            
            self.addSubview(label)
            popupLabel = label
            
            // Animate the popup to disappear after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                label.removeFromSuperview()
            }
        }
    }

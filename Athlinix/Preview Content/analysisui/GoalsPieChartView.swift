//
//  GoalsPieChartView.swift
//  GamePlay
//
//  Created by admin65 on 19/11/24.
//


import UIKit

class GoalsPieChartView: UIView {
    
    // Properties for the graph data
        var percentages: [CGFloat] = []
        var colors: [UIColor] = [
            UIColor(hex: "#962DFF")!,
            UIColor(hex: "#C6D2FD")!,
            UIColor(hex: "#4A3AFF")!
        ]
        var ringWidths: [CGFloat] = [20, 15, 10]
        private var arcs: [CGRect] = []
        private var radiusList: [CGFloat] = []
        private var percentageLabel: UILabel!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
            loadData()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
            loadData()
        }
        
        private func setup() {
            // Initialize the label for percentage display
            percentageLabel = UILabel()
            percentageLabel.textAlignment = .center
            percentageLabel.font = UIFont.boldSystemFont(ofSize: 20)
            percentageLabel.textColor = .black
            percentageLabel.alpha = 0 // Initially hidden
            addSubview(percentageLabel)
            
            // Add tap gesture recognizer
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            addGestureRecognizer(tapGesture)
        }
        
        private func loadData() {
            let filePath = "/Users/admin65/Desktop/GamePlay/GamePlay/missesvsmade.json"
            
            do {
                // Read the JSON file
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL)
                
                // Decode the JSON data
                let players = try JSONDecoder().decode([MissesVsMade].self, from: data)
                
                // Calculate percentages (example: based on made vs missed shots)
                guard let player = players.first else { return } // Example: use first player
                let totalFreeThrows = CGFloat(player.freethrowsmade + player.freethrowsmissed)
                let total2pt = CGFloat(player.twoptfgmade + player.twoptfgmissed)
                let total3pt = CGFloat(player.threeptfgmade + player.threeptfgmissed)
                
                percentages = [
                    totalFreeThrows == 0 ? 0 : CGFloat(player.freethrowsmade) / totalFreeThrows,
                    total2pt == 0 ? 0 : CGFloat(player.twoptfgmade) / total2pt,
                    total3pt == 0 ? 0 : CGFloat(player.threeptfgmade) / total3pt
                ]
                
                // Redraw the pie chart with the new data
                setNeedsDisplay()
            } catch {
                print("Error loading or parsing JSON: \(error)")
            }
        }
        
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            guard percentages.count == colors.count, percentages.count == ringWidths.count else {
                print("Mismatch in the number of percentages, colors, or ring widths!")
                return
            }
            
            arcs = [] // Reset the arcs for tap detection
            radiusList = []
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            var radius = min(rect.width, rect.height) / 2 - ringWidths.max()! // Adjust radius based on ring width
            
            for (index, percentage) in percentages.enumerated() {
                // Draw full grey ring
                drawCircle(center: center,
                           radius: radius,
                           startAngle: 0,
                           endAngle: 2 * .pi,
                           color: UIColor.systemGray6,
                           lineWidth: ringWidths[index])
                
                // Draw percentage arc
                let endAngle = 2 * .pi * percentage
                drawCircle(center: center,
                           radius: radius,
                           startAngle: -.pi / 2,
                           endAngle: endAngle - .pi / 2,
                           color: colors[index],
                           lineWidth: ringWidths[index])
                
                // Track arcs and radii for tap detection
                let arcRect = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
                arcs.append(arcRect)
                radiusList.append(radius)
                
                // Update the radius for the next ring
                radius -= ringWidths[index] + 10 // Add spacing between rings
            }
        }
        
        private func drawCircle(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, color: UIColor, lineWidth: CGFloat) {
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            color.setStroke()
            path.lineWidth = lineWidth
            path.lineCapStyle = .round
            path.stroke()
        }
        
        @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
            let touchPoint = gesture.location(in: self)
            
            // Check if the touch is within any arc
            for (index, arc) in arcs.enumerated() {
                let radius = radiusList[index]
                let center = CGPoint(x: arc.midX, y: arc.midY)
                let distance = sqrt(pow(touchPoint.x - center.x, 2) + pow(touchPoint.y - center.y, 2))
                
                // Check if the touch is within the radius range
                if distance >= radius - ringWidths[index] && distance <= radius {
                    showPercentage(percentages[index])
                    return
                }
            }
        }
        
        private func showPercentage(_ percentage: CGFloat) {
            percentageLabel.text = "\(Int(percentage * 100))%"
            percentageLabel.sizeToFit()
            percentageLabel.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
            percentageLabel.alpha = 1
            
            // Animate the label to fade out after 2 seconds
            UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseOut) {
                self.percentageLabel.alpha = 0
            }
        }
    }

    // Extension for UIColor to initialize with hex values
    extension UIColor {
        convenience init?(hex: String) {
            var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
            
            var rgb: UInt64 = 0
            Scanner(string: hexSanitized).scanHexInt64(&rgb)
            
            let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgb & 0x0000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }

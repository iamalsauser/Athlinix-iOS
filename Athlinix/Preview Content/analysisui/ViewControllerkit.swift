import UIKit
import Charts

class ViewControllerkitUI: UIViewController {
    
    
    @IBOutlet weak var totalPointsScoredView: UIView!
    @IBOutlet weak var totalPointsScoredLabel: UILabel!
    
    @IBOutlet weak var gamesPlayedView: UIView!
    @IBOutlet weak var gamesPlayedLabel: UILabel!
    
    @IBOutlet weak var scoringEfficiencyView: UIView!
    @IBOutlet weak var pointsPerGame: UILabel!
    @IBOutlet weak var percentageIncrease: UILabel!
    @IBOutlet weak var scoringEfficiencyLineGraphView: UIView!
    
    
    @IBOutlet weak var reboundsView: UIView!
    @IBOutlet weak var reboundsNumber: UILabel! //number of rebounds
    @IBOutlet weak var reboundsPercentageIncrease: UILabel!
    @IBOutlet weak var reboundsIncreaseLinceGraphView: UIView!
    
    @IBOutlet weak var statisticsView: UIView!
    @IBOutlet weak var assistsToTurnoverLabel: UILabel! //will have ratio in "9:3" format
    @IBOutlet weak var assistsToTurnoverPercentageLabel: UILabel! //percentage increase/decrease
    @IBOutlet weak var assistsToTurnoverLineGraphView: UIView!
    
    @IBOutlet weak var pointsScoredView: UIView!
    //@IBOutlet weak var pointsScoredBarChartView: UIView!
    @IBOutlet weak var pointsScoredBarChartView: PointsScoredBarChartView! //year wise points scored by a player, in gradient shades of #962DFF.
    
    
    @IBOutlet weak var goalsVsBricksView: UIView!
    @IBOutlet weak var goalsVsBricksPieChartView: UIView! //pie chart having three circles telling, out of the number of goals made, how many where missed, in 2PTFGS, 3PTFGS and Free Throws.
    
    
    @IBOutlet weak var gamePerformanceView: UIView!
    
    @IBOutlet weak var gamePerformanceBarChartView: GamePerformanceBarChartView!

    //@IBOutlet weak var gamePerformanceBarChartView: UIView! //bar graph of the number of rebounds, free throws, 2ptg and 3ptfg made in different months of an year in colours:- #962DFF, #4A3AFF, #E0C6FD, #93AAFD
    
    @IBOutlet weak var teamPerformanceView: UIView!
    
   
    @IBOutlet weak var teamPerformanceBarChartView: TeamPerformanceBarChartView!
    
    //bar graph of points scored by members of users team.
    
    @IBOutlet weak var teamPerformanceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: calling cards
        let cardViews = [
            totalPointsScoredView,
            gamesPlayedView,
            scoringEfficiencyView,
            reboundsView,
            statisticsView,
            pointsScoredView,
            goalsVsBricksView,
            gamePerformanceView,
            teamPerformanceView
        ]
        for cardView in cardViews {
            styleOuterCardView(cardView!)
        }
        //MARK: POPULATING STACK 1 CARDS
        
        guard let stats = fetchMatchStats() else { return }
            let calculatedStats = calculateStats(stats: stats)
            
            totalPointsScoredLabel.text = "\(calculatedStats.totalPoints)"
            gamesPlayedLabel.text = "\(calculatedStats.gamesPlayed)"
            pointsPerGame.text = String(format: "%.1f", calculatedStats.pointsPerGame)
            percentageIncrease.text = String(format: "%.2f%%", calculatedStats.percentageIncrease)
            percentageIncrease.textColor = calculatedStats.percentageIncrease < 0 ? .red : .green

        
            reboundsNumber.text = String(format: "%.1f", calculatedStats.avgRebounds)
            reboundsPercentageIncrease.text = String(format: "%.2f%%", calculatedStats.reboundsPercentageIncrease)
            reboundsPercentageIncrease.textColor = calculatedStats.reboundsPercentageIncrease < 0 ? .red : .green

        
        assistsToTurnoverLabel.text = "2.3"
        assistsToTurnoverPercentageLabel.text = "-3.5%"
        
        // MARK: CALLING LINE GRAPH FUNC
        
        let (pointsData, reboundsData, assistsToTurnoverData) = extractGraphData(stats: stats)
          drawLineGraph(in: scoringEfficiencyLineGraphView, dataPoints: pointsData)
          drawLineGraph(in: reboundsIncreaseLinceGraphView, dataPoints: reboundsData)
          drawLineGraph(in: assistsToTurnoverLineGraphView, dataPoints: assistsToTurnoverData)
        
        // MARK: PIE CHART
        

        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: CARD STYLING FUNCTIONS
    func styleOuterCardView(_ view: UIView) {
        view.layer.cornerRadius = 10 // Rounded corners
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
    }
    
    
    // MARK: GRAPHS
    
    
     //MARK: LINE GRAPHS
    
    func drawLineGraph(in view: UIView, dataPoints: [CGFloat]) {
        let path = UIBezierPath()
        let width = view.bounds.width
        let height = view.bounds.height
        let maxDataPoint = dataPoints.max() ?? 1
        
        // Start the path at the first data point
        path.move(to: CGPoint(x: 0, y: height - (dataPoints[0] / maxDataPoint * height)))
        
        // Add lines for the remaining data points
        for (index, value) in dataPoints.enumerated() {
            let x = CGFloat(index) * (width / CGFloat(dataPoints.count - 1))
            let y = height - (value / maxDataPoint * height)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        // Create the shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemRed.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        // Add animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1.5
        shapeLayer.add(animation, forKey: "lineAnimation")
        
        // Add the shape layer to the view
        view.layer.addSublayer(shapeLayer)
        
        // Add dots at each data point
        for (index, value) in dataPoints.enumerated() {
            let x = CGFloat(index) * (width / CGFloat(dataPoints.count - 1))
            let y = height - (value / maxDataPoint * height)
            let dot = UIView(frame: CGRect(x: x - 2.5, y: y - 2.5, width: 5, height: 5))
            dot.backgroundColor = UIColor.systemRed
            dot.layer.cornerRadius = 2.5
            view.addSubview(dot)
        }
    }
    
    //MARK: calculating stats
    
    func calculateStats(stats: [MatchStatskit]) -> (totalPoints: Int, gamesPlayed: Int, pointsPerGame: Double, percentageIncrease: Double, avgRebounds: Double, reboundsPercentageIncrease: Double) {
        let totalPoints = stats.reduce(0) { $0 + $1.points }
        let gamesPlayed = stats.count
        let pointsPerGame = Double(totalPoints) / Double(gamesPlayed)
        
        // Calculate percentage increase/decrease in points
        let firstGamePoints = stats.first?.points ?? 0
        let lastGamePoints = stats.last?.points ?? 0
        let percentageIncrease = firstGamePoints == 0 ? 0 : (Double(lastGamePoints - firstGamePoints) / Double(firstGamePoints)) * 100
        
        let totalRebounds = stats.reduce(0) { $0 + $1.rebounds }
        let avgRebounds = Double(totalRebounds) / Double(gamesPlayed)
        
        // Calculate percentage increase/decrease in rebounds
        let firstGameRebounds = stats.first?.rebounds ?? 0
        let lastGameRebounds = stats.last?.rebounds ?? 0
        let reboundsPercentageIncrease = firstGameRebounds == 0 ? 0 : (Double(lastGameRebounds - firstGameRebounds) / Double(firstGameRebounds)) * 100
        
        return (totalPoints, gamesPlayed, pointsPerGame, percentageIncrease, avgRebounds, reboundsPercentageIncrease)
    }

    
   
    
}

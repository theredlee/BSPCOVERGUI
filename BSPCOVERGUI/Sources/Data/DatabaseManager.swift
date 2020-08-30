//
//  Database.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import Foundation
import Charts

final class DatabaseManager {
    
    /// Shared instance of class
    public static let shared = DatabaseManager()
    
    // Time series loading directory setting
    private static let home = FileManager.default.homeDirectoryForCurrentUser
    private static let playgroundPath = "Desktop/Files.playground"
    private static let playgroundUrl = {
        return home.appendingPathComponent(playgroundPath)
    }()
    
    public func initData() -> [Timeseries] {
        var values = [Timeseries]()
        values.append(DatabaseManager.shared.addData(num: 0))
        values.append(DatabaseManager.shared.addData(num: 4, label: 0))
        values.append(DatabaseManager.shared.addData(num: 1))
        values.append(DatabaseManager.shared.addData(num: 2))
        return values
    }
    
    private func addData(num: Int) -> Timeseries {
        let label = Label(id: num, value: num)
        let values = addvalues(num: num)
        return Timeseries(id: num, values: values, label: label)
    }
    
    private func addData(num: Int, label: Int) -> Timeseries {
        let label = Label(id: num, value: num)
        let values = addvalues(num: num)
        return Timeseries(id: num, values: values, label: label)
    }
    
    private func addvalues(num: Int) -> [Double] {
        return Array(1..<10).map { x in return sin(Double(x*num) / 2.0 / 3.141 * 1.5) }
    }
    
}

extension DatabaseManager {
    /// Read time series raw data from local directory
    /// URL: Search -> FileManager Class Tutorial for macOS: Getting Started with the File System
    
    /*
     playgroundUrl.path
     playgroundUrl.absoluteString
     playgroundUrl.absoluteURL
     playgroundUrl.baseURL
     playgroundUrl.pathComponents
     playgroundUrl.lastPathComponent
     playgroundUrl.pathExtension
     playgroundUrl.isFileURL
     playgroundUrl.hasDirectoryPath
     */
    
    public func readLocalTimeseriesDirectory(fileDirectory: URL) -> String {
        //        let url = URL(fileURLWithPath: "/path/to/directory")
        if !fileDirectory.hasDirectoryPath {
            return "Failed to find directory."
        }
        
        let url = fileDirectory
        
        var files = [URL]()
        if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
            for case let fileURL as URL in enumerator {
                do {
                    let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                    if fileAttributes.isRegularFile! {
                        files.append(fileURL)
                    }
                } catch { print(error, fileURL)
                    return "Error"
                }
            }
            print(files)
        }
        
        // process files with a loop
        var message: String = ""
        var cumCount = 0
        for url in files {
            // Read each file
            print("Found \(url.absoluteString)")
            let info = readLocalTimeseriesData(cumCount: cumCount, fileName: url.absoluteString)
            cumCount += info.0
            message += info.1
        }
        return "\(files.count) \n\n\(cumCount) \n\n\(files.debugDescription) \n\n\(message)"
    }
    
    //
    private func readLocalTimeseriesData(cumCount: Int, fileName: String) -> (Int, String) {
        guard fileName != "file:///" else {
            print("Failed to fetch local path.")
            return (-1, "Failed to fetch local path. \n\(fileName)")
        }
        let path = fileName.replacingOccurrences(of: "file://", with: "")
        
        do {
            let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8).trimmingCharacters(in: .whitespaces)
            let lines = data.components(separatedBy: "\n")
            
            // Define a [[Double]] container
            let rowDataset: [[Double]] = {
                var rowDataset = [[Double]]()
                lines.forEach  { line in
                    // Filter the empty trash line
                    if !line.isEmpty {
                        let trimmedLine = line.trimmingCharacters(in: .whitespaces)
                        let strArr = trimmedLine.components(separatedBy: ",")
                        rowDataset.append(strArr.compactMap(Double.init))
                    }
                }
                return rowDataset
            }()
            
            // Define a [Double] container
            let labelset: [Int] = {
                var labelset = [Int]()
                rowDataset.forEach { line in
                    // The first element should be label
                    guard (round(line[0]) == line[0]) else {
                        print("The dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer].")
                        return
                    }
                    labelset.append(Int(line[0]))
                }
                return labelset
            }()
            
            // Check the result
            guard labelset.count == rowDataset.count else {
                print("The dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer].")
                return (-1, "The dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer].")
            }
            
            // Define a [[Double]] container
            let valueset: [[Double]] = {
                var dataset = [[Double]]()
                rowDataset.forEach { line in
                    // Drop the first elements in an array
                    var lineSkipped = [Double]()
                    for index in 0..<line.count {
                        if index > 0 {
                            lineSkipped.append(line[index])
                        }
                    }
                    dataset.append(lineSkipped)
                }
                return dataset
            }()
            
            // Check the result
            guard labelset.count == valueset.count && valueset.count == rowDataset.count else {
                print("The number of labels doesn't equal to the number of dataset OR the dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer ...].")
                return (-1, "The number of labels doesn't equal to the number of dataset OR the dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer ...].")
            }
            
            // Pass data into [timeseires]
            let str = timeseriesInit(cumCount: cumCount, labelset: labelset, valueset: valueset)
            return (cumCount + valueset.count, str)
        } catch let error {
            print("Failed to fetch local data.")
            return (-1, "Failed to fetch local data. \n\(error)")
        }
    }
    
    //
    private func timeseriesInit(cumCount: Int, labelset: [Int], valueset: [[Double]]) -> String {
        guard (labelset.count == valueset.count && valueset.count > 0 && valueset.first?.count ?? 0 > 0 && valueset.last?.count ?? 0 > 0)  else {
            print("Failed to load dataset values.")
            return "Failed to load dataset values."
        }
        let timeseriesArr = { () -> [Timeseries] in
            var timeseriesArr = [Timeseries]()
            for index in 0..<valueset.count {
                let values = valueset[index]
                let label = Label(id: index, value: labelset[index])
                timeseriesArr.append(Timeseries(id: index + cumCount, values: values, label: label))
            }
            return timeseriesArr
        }()
        
        // Pass data into database
        return Database.shared.timeseriesInsert(myAllTimeseries: timeseriesArr)
    }
}

extension DatabaseManager {
    /// Read time series raw data from local directory
    /// URL: Search -> FileManager Class Tutorial for macOS: Getting Started with the File System
    
    /*
     playgroundUrl.path
     playgroundUrl.absoluteString
     playgroundUrl.absoluteURL
     playgroundUrl.baseURL
     playgroundUrl.pathComponents
     playgroundUrl.lastPathComponent
     playgroundUrl.pathExtension
     playgroundUrl.isFileURL
     playgroundUrl.hasDirectoryPath
     */
    
    public func readLocalShapeletDirectory(fileDirectory: URL) -> String {
        var raedShapelet:Bool = false
        var raedShapeletWeight:Bool = false
        //        let url = URL(fileURLWithPath: "/path/to/directory")
        if !fileDirectory.hasDirectoryPath {
            return "Failed to find directory."
        }
        
        let url = fileDirectory
        
        var files = [URL]()
        if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
            for case let fileURL as URL in enumerator {
                do {
                    let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                    if fileAttributes.isRegularFile! {
                        files.append(fileURL)
                    }
                } catch { print(error, fileURL)
                    return "Error"
                }
            }
            print(files)
        }
        
        // process files with a loop
        var message: String = ""
        var cumCount = 0
        for url in files {
            // Read each file
            print("Found \(url.absoluteString)")
            if url.absoluteString.contains("shapelet-original") && !raedShapelet {
                let info = readLocalShapeletData(cumCount: cumCount, fileName: url.absoluteString)
                cumCount += info.0
                message += info.1
                // Only read onece
                raedShapelet = true
            }else if url.absoluteString.contains("shapelet-weight") && !raedShapeletWeight {
                let info = readLocalShapeletWeight(fileName: url.absoluteString)
                message += info
                // Only read onece
                raedShapeletWeight = true
            }
            else {
                break
            }
        }
        
        // Match distances between all shapelets and timeseries
        let distMapArr: [Distance] = getUniversalDistances()
        Database.shared.initDistMap(distMapArr: distMapArr)
        
        return "\(files.count) \n\n\(cumCount) \n\n\(files.debugDescription) \n\n\(message)"
    }
    
    //
    private func readLocalShapeletData(cumCount: Int, fileName: String) -> (Int, String) {
        guard fileName != "file:///" else {
            print("Failed to fetch local path.")
            return (-1, "Failed to fetch local path. \n\(fileName)")
        }
        let path = fileName.replacingOccurrences(of: "file://", with: "")
        
        do {
            let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8).trimmingCharacters(in: .whitespaces)
            let lines = data.components(separatedBy: "\n")
            
            // Define a [[Double]] container
            let rowDataset: [[Double]] = {
                var rowDataset = [[Double]]()
                lines.forEach  { line in
                    // Filter the empty trash line
                    if !line.isEmpty {
                        let trimmedLine = line.trimmingCharacters(in: .whitespaces)
                        let strArr = trimmedLine.components(separatedBy: ",")
                        rowDataset.append(strArr.compactMap(Double.init))
                    }
                }
                return rowDataset
            }()
            
            // Define a [Double] container
            let labelset: [Int] = {
                var labelset = [Int]()
                rowDataset.forEach { line in
                    // The first element should be label
                    guard (round(line[0]) == line[0]) else {
                        print("The dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer].")
                        return
                    }
                    labelset.append(Int(line[0]))
                }
                return labelset
            }()
            
            // Check the result
            guard labelset.count == rowDataset.count else {
                print("The dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer].")
                return (-1, "The dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer].")
            }
            
            // Define a [[Double]] container
            let valueset: [[Double]] = {
                var dataset = [[Double]]()
                rowDataset.forEach { line in
                    // Drop the first elements in an array
                    var lineSkipped = [Double]()
                    for index in 0..<line.count {
                        if index > 0 {
                            lineSkipped.append(line[index])
                        }
                    }
                    dataset.append(lineSkipped)
                }
                return dataset
            }()
            
            // Check the result
            guard labelset.count == valueset.count && valueset.count == rowDataset.count else {
                print("The number of labels doesn't equal to the number of dataset OR the dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer ...].")
                return (-1, "The number of labels doesn't equal to the number of dataset OR the dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer ...].")
            }
            
            // Pass data into [timeseires]
            let str = shapeletInit(cumCount: cumCount, labelset: labelset, valueset: valueset)
            return (cumCount + valueset.count, str)
        } catch let error {
            print("Failed to fetch local data.")
            return (-1, "Failed to fetch local data. \n\(error)")
        }
    }
    
    //
    private func shapeletInit(cumCount: Int, labelset: [Int], valueset: [[Double]]) -> String {
        guard (labelset.count == valueset.count && valueset.count > 0 && valueset.first?.count ?? 0 > 0 && valueset.last?.count ?? 0 > 0)  else {
            print("Failed to load dataset values.")
            return "Failed to load dataset values."
        }
        let shapeletArr = { () -> [Shapelet] in
            var shapeletArr = [Shapelet]()
            for index in 0..<valueset.count {
                let values = valueset[index]
                let label = Label(id: index, value: labelset[index])
                shapeletArr.append(Shapelet(id: index + cumCount, values: values, label: label))
            }
            return shapeletArr
        }()
        
        // Pass data into database
        return Database.shared.shapeletInsert(myAllShapelets: shapeletArr)
    }
}

extension DatabaseManager {
    // Read the weights
    private func readLocalShapeletWeight(fileName: String) -> (String) {
        guard fileName != "file:///" else {
            print("Failed to fetch local path.")
            return "Failed to fetch local path. \n\(fileName)"
        }
        let path = fileName.replacingOccurrences(of: "file://", with: "")
        
        do {
            let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8).trimmingCharacters(in: .whitespaces)
            let lines = data.components(separatedBy: "\n")
            
            // Define a [[Double]] container
            let rowDataset: [[Double]] = {
                var rowDataset = [[Double]]()
                lines.forEach  { line in
                    // Filter the empty trash line
                    if !line.isEmpty {
                        let trimmedLine = line.trimmingCharacters(in: .whitespaces)
                        let strArr = trimmedLine.components(separatedBy: ",")
                        rowDataset.append(strArr.compactMap(Double.init))
                    }
                }
                return rowDataset
            }()
            
            // Define a [Double] container
            let labelset: [Int] = {
                var labelset = [Int]()
                rowDataset.forEach { line in
                    // The first element should be label
                    guard (round(line[0]) == line[0]) else {
                        print("The dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer].")
                        return
                    }
                    labelset.append(Int(line[0]))
                }
                return labelset
            }()
            
            // Check the result
            guard labelset.count == rowDataset.count else {
                print("The dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer].")
                return "The dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer]."
            }
            
            // Define a [[Double]] container
            let valueset: [[Double]] = {
                var dataset = [[Double]]()
                rowDataset.forEach { line in
                    // Drop the first elements in an array
                    var lineSkipped = [Double]()
                    for index in 0..<line.count {
                        if index > 0 {
                            lineSkipped.append(line[index])
                        }
                    }
                    dataset.append(lineSkipped)
                }
                return dataset
            }()
            
            // Check the result
            guard labelset.count == valueset.count && valueset.count == rowDataset.count else {
                print("The number of labels doesn't equal to the number of dataset OR the dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer ...].")
                return "The number of labels doesn't equal to the number of dataset OR the dataset format is wrong [the first element in each rwo should be a label. \nA label should be an integer or a double format integer ...]."
            }
            
            // Pass data into [timeseires]
            let str = shapeletWeightInit(labelset: labelset, valueset: valueset)
            return str
        } catch let error {
            print("Failed to fetch local data.")
            return "Failed to fetch local data. \n\(error)"
        }
    }
    
    //
    private func shapeletWeightInit(labelset: [Int], valueset: [[Double]]) -> String {
        guard (labelset.count == valueset.count && valueset.count > 0 && valueset.first?.count ?? 0 > 0 && valueset.last?.count ?? 0 > 0)  else {
            print("Failed to load dataset values.")
            return "Failed to load dataset values."
        }
        let shapeletWeightArr = { () -> [ShapeletWeight] in
            var shapeletWeightArr = [ShapeletWeight]()
            var count:Int = 0
            for index in 0..<valueset.count {
                let values = valueset[index]
                let label = Label(id: index, value: labelset[index])
                for weight in values {
                    shapeletWeightArr.append(ShapeletWeight(id: count, value: weight, label: label))
                    count += count
                }
            }
            return shapeletWeightArr
        }()
        
        // Pass data into database
        return Database.shared.shapeletWeightInsert(myAllShapeletWeights: shapeletWeightArr)
    }
}

extension DatabaseManager {
    private func getDistance(timeseries: Timeseries, shapelet: Shapelet) -> (Int, Double) {
        guard timeseries.values.count > 0 else {
            return (-1, -1)
        }
        guard timeseries.values.count > 0 else {
            return (-1, -1)
        }
        
        let timeseriesVals: [Double] = timeseries.values
        let shapeletVals: [Double] = shapelet.values
        
        var startPosition = 0
        var distanceBetweenST: Double = 0
        var distanceMin: Double = Double.infinity
        for i in 0..<(timeseriesVals.count-shapeletVals.count) {
            // index in indexthis.aVariables.currentShapelet
            distanceBetweenST = 0;
            for j in 0..<shapeletVals.count {
                // index in indexthis.aVariables.currentShapelet
                distanceBetweenST += pow(timeseriesVals[j+i] - shapeletVals[j], 2.0)
            }
            distanceBetweenST = sqrt(distanceBetweenST)
            //System.out.println("distanceBetweenST "+distanceBetweenST);
            if distanceBetweenST < distanceMin {
                distanceMin = distanceBetweenST
                startPosition = i /*** Interesting **/
            }
        }
        //        System.out.println("From drawShapeletTrace_centerChart() -> startPoint: " + startPosition);
        //        return distanceMin/((this.aVariables.currentSPLet_.size()-1)*1.0);
        return (startPosition, distanceMin*1.0)
    }
    
    public func getDistanceFromMap(timeseries: Timeseries, shapelet: Shapelet) -> (Double, Int) {
        let distanceMap = Database.shared.distanceMap
        let shapeletId = shapelet.id
        let timeseriesId = timeseries.id
        var distanceDetail: DistanceDetail?
        
        distanceMap.forEach { distance in
            if shapeletId == distance.shapeletId {
                distanceDetail = binarySearch(in: distance.distanceDetails, for: timeseriesId)
            }
        }
        if distanceDetail != nil {
            let myDistanceDetail: DistanceDetail = distanceDetail!
            return (myDistanceDetail.distance, myDistanceDetail.startPosition)
        }else{
            return (-1, 0)
        }
    }
    
    public func getTopKTimeseries(defaultTopK: Int, shapelet: Shapelet) -> [Timeseries] {
        let allTimeseries = Database.shared.allTimeseries
        let distanceMap = Database.shared.distanceMap
        let defaultTopK: Int = defaultTopK
        var timeseriesArr = [Timeseries]()
        
        distanceMap.forEach { oneShapeletMap in
            let shapeletId = oneShapeletMap.shapeletId
            
            if shapeletId == shapelet.id {
                for index in 0..<defaultTopK {
                    let eachId = oneShapeletMap.distanceDetails[index].timeseriesId
                    guard let timeseries = binarySearch(in: allTimeseries, for: Int(eachId)) else {
                        return
                    }
                    timeseriesArr.append(timeseries)
                }
                return
            }
        }
        
        return timeseriesArr
    }
    
    public func getUniversalDistances() -> [Distance] {
        var distanceArr = [Distance]()
        let allTimeseries: [Timeseries] = Database.shared.allTimeseries
        let allShapelets: [Shapelet] = Database.shared.allShapelets
        
        allShapelets.forEach { shapelet in
            var distanceDetailArr = [DistanceDetail]()
            
            allTimeseries.forEach { timeseries in
                let distance = getDistance(timeseries: timeseries, shapelet: shapelet)
                /*
                 [
                     [
                        shapeletId: shapelet.id,
                         [
                             [timeseriesId: timeseries.id],
                             [distance: distance],
                             [startPosition: startPosition]
                         ]
                    ]
                 
                    [
                        shapeletId: shapelet.id,
                         [
                             [timeseriesId: timeseries.id],
                             [distance: distance],
                             [startPosition: startPosition]
                        ]
                    ]
                     ... // number of shapelets
                 ]
                 */
                let distanceDetail = DistanceDetail(timeseriesId: timeseries.id, distance: distance.1, startPosition: distance.0)
                distanceDetailArr.append(distanceDetail)
            }
            let distance: Distance = Distance(shapeletId: shapelet.id, distanceDetails: distanceDetailArr)
            distanceArr.append(distance)
        }
        
        /*
         [
             [
                shapeletId: shapelet.id,
                 [
                     [timeseriesId: timeseries.id],
                     [distance: distance],
                     [startPosition: startPosition]
                 ]
            ]
         
            [
                shapeletId: shapelet.id,
                 [
                     [timeseriesId: timeseries.id],
                     [distance: distance],
                     [startPosition: startPosition]
                ]
            ]
             ... // number of shapelets
         ]
         */
        return distanceArr
    }
    
    // Search Timeseries
    public func binarySearch(in numbers: [Timeseries], for id: Int) -> Timeseries? {
        var left = 0
        var right = numbers.count - 1
        
        while left <= right {
            
            let middle = Int(floor(Double(left + right) / 2.0))
            
            if numbers[middle].id < id {
                left = middle + 1
            } else if numbers[middle].id > id {
                right = middle - 1
            } else {
                return numbers[middle]
            }
        }
        
        return nil
    }
    
    // Search Shapelet
    private func binarySearch(in numbers: [Shapelet], for id: Int) -> Shapelet? {
        var left = 0
        var right = numbers.count - 1
        
        while left <= right {
            
            let middle = Int(floor(Double(left + right) / 2.0))
            
            if numbers[middle].id < id {
                left = middle + 1
            } else if numbers[middle].id > id {
                right = middle - 1
            } else {
                return numbers[middle]
            }
        }
        
        return nil
    }
    
    // Search Timeseries Distance
    private func binarySearch(in numbers: [DistanceDetail], for id: Int) -> DistanceDetail? {
        var left = 0
        var right = numbers.count - 1
        
        while left <= right {
            
            let middle = Int(floor(Double(left + right) / 2.0))
            
            if numbers[middle].timeseriesId < id {
                left = middle + 1
            } else if numbers[middle].timeseriesId > id {
                right = middle - 1
            } else {
                return numbers[middle]
            }
        }
        
        return nil
    }
}

extension DatabaseManager {
    public enum DatabaseError: Error {
        case failedToFetch
        
        public var localizedDescription: String {
            switch self {
            case .failedToFetch:
                return "This means blah failed"
            }
        }
    }
}

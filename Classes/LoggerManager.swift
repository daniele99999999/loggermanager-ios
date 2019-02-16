//
//  LoggerManager.swift
//
//
//  Created by Daniele Salvioni on 12/12/2017.
//  Copyright © 2017 Daniele Salvioni. All rights reserved.
//

// VARI LIVELLI DI LOG
//DDLogLevel.Off
//DDLogLevel.Error
//DDLogLevel.Warning
//DDLogLevel.Info
//DDLogLevel.Debug
//DDLogLevel.Verbose
//DDLogLevel.all

import CocoaLumberjack
import Foundation

public enum LoggerManagerLevel: Int
{
    case off
    case error
    case warning
    case info
    case debug
    case verbose
    case all
}

public class LoggerManager
{
    public var logLevel: LoggerManagerLevel = .all
    {
        didSet
        {
            switch logLevel
            {
                case .off:
                    self.internalLogLevel = .off
                case .error:
                    self.internalLogLevel = .error
                case .warning:
                    self.internalLogLevel = .warning
                case .info:
                    self.internalLogLevel = .info
                case .debug:
                    self.internalLogLevel = .debug
                case .verbose:
                    self.internalLogLevel = .verbose
                case .all:
                    self.internalLogLevel = .all
            }
        }
    }
    
    fileprivate var internalLogLevel: DDLogLevel = .all
    
    fileprivate var fileLogger: DDFileLogger?
    
    
    
// MARK: - Initializers (singleton & multiple instances)
    //--------------------------------------------------------------
    public static let shared = LoggerManager()
    
    //--------------------------------------------------------------
    public init()
    {
        // inizializzo il logger di base
        DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
        //DDLog.add(DDOSLogger.sharedInstance) // OSL = Operating System Logs
        
        // inizializzo il fileLogger disabled
        self.enableFileLogger(enable: false)
    }
    
    
    
// MARK: - Configuration
    //--------------------------------------------------------------
    fileprivate func createFileLogger() -> DDFileLogger
    {
        let newFileLogger: DDFileLogger = DDFileLogger()
        newFileLogger.rollingFrequency = TimeInterval(60*60*24)
        newFileLogger.logFileManager.maximumNumberOfLogFiles = 7
        return newFileLogger
    }
    
    //--------------------------------------------------------------
    public func enableFileLogger(enable: Bool)
    {
        if let fileLogger = self.fileLogger
        {
            if (enable == false)
            {
                DDLog.remove(fileLogger)
                self.fileLogger = nil
            }
        }
        else
        {
            if (enable == true)
            {
                let newFileLogger = self.createFileLogger()
                self.fileLogger = newFileLogger
                DDLog.add(newFileLogger)
            }
        }
    }
}



// MARK: - Log Functions

public extension LoggerManager
{
    //--------------------------------------------------------------
    public func logError(_ description: String, tag: String? = nil, asynchronous: Bool = false)
    {
        DDLogError(description, level: self.internalLogLevel, context: 0, tag: tag, asynchronous: asynchronous)
    }
    
    //--------------------------------------------------------------
    public func logWarning(_ description: String, tag: String? = nil, asynchronous: Bool = false)
    {
        DDLogWarn(description, level: self.internalLogLevel, context: 0, tag: tag, asynchronous: asynchronous)
    }
    
    //--------------------------------------------------------------
    public func logInfo(_ description: String, tag: String? = nil, asynchronous: Bool = false)
    {
        DDLogInfo(description, level: self.internalLogLevel, context: 0, tag: tag, asynchronous: asynchronous)
    }
    
    //--------------------------------------------------------------
    public func logDebug(_ description: String, tag: String? = nil, asynchronous: Bool = false)
    {
        DDLogDebug(description, level: self.internalLogLevel, context: 0, tag: tag, asynchronous: asynchronous)
    }
    
    //--------------------------------------------------------------
    public func logVerbose(_ description: String, tag: String? = nil, asynchronous: Bool = false)
    {
        DDLogVerbose(description, level: self.internalLogLevel, context: 0, tag: tag, asynchronous: asynchronous)
    }
}

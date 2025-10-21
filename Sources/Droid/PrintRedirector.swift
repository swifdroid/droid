//
//  PrintRedirector.swift
//
//  Created by Sergey Romanenko (aka purpln) on 29.09.2025.
//  Adopted by Mihael Isaev on 21.10.2025.
//

#if canImport(Android)
@preconcurrency
import Android

/// A class that redirects standard output/error streams to Android's logging system
/// 
/// This class captures stdout and stderr output and redirects it to Android's logcat system,
/// making Swift print statements visible in Android Studio's logcat or adb logcat.
class PrintRedirector: @unchecked Sendable {
    /// Shared singleton instance for convenient access
    static let shared = try! PrintRedirector()
    
    /// Pipe used for inter-process communication between file descriptors
    private let pipe: Pipe
    /// Background task that continuously reads from the pipe and logs to Android system
    private var task: Task<Void, any Error>?
    
    /// Initializes the PrintRedirector and creates the necessary pipe
    /// - Throws: `PrintRedirectorError.pipe` if pipe creation fails
    init() throws(PrintRedirectorError) {
        pipe = try _pipe()
    }
    
    deinit {
        cancel()
    }
    
    /// Redirects a specified stream to Android's logging system
    /// - Parameters:
    ///   - stream: The stream to redirect (stdout or stderr)
    ///   - tag: The log tag to use in Android logcat
    ///   - priority: The log priority level (default: .info)
    /// - Throws: `PrintRedirectorError` if any of the stream operations fail
    private func redirect(_ stream: OpaquePointer, as tag: String, priority: AndroidLogPriority = .info) throws(PrintRedirectorError) {
        // Set line buffering on the source stream
        try _buffer(stream, _IOLBF)
        
        // Redirect the stream to our pipe's write end
        try _duplicate(pipe.write, fileno(stream))
        
        let descriptor = pipe.read
        
        // Create a detached task to continuously read from the pipe
        task = Task.detached {
            let capacity = 8
            var buffer = [UInt8](repeating: 0, count: capacity)
            
            let terminator: UInt8 = 0x0a // Line feed character (\n)
            var logs: [UInt8] = [] // Buffer for incomplete lines
            
            // Continue reading until the task is cancelled
            while !Task.isCancelled {
                // Read data from the pipe into buffer
                let length = read(descriptor, &buffer, capacity)
                
                guard length >= 0 else {
                    if errno != EAGAIN && errno != EWOULDBLOCK {
                        break // Fatal error, exit loop
                    }
                    continue // Non-fatal error, try again
                }
                
                // No data available, continue waiting
                guard length > 0 else { continue }
                
                // Extract the received chunk
                let chunk = buffer[0..<length]
                
                // Split combined buffer by newlines, keeping incomplete lines
                var lines = (logs + chunk).split(separator: terminator, omittingEmptySubsequences: true)
                
                // Handle line completion
                if chunk.last == terminator {
                    // Reset buffer if chunk ends with newline
                    logs = []
                } else {
                    // Save incomplete line for next read cycle
                    logs = Array(lines.removeLast())
                }
                
                // Log each complete line to Android system
                for line in lines {
                    let line = String(decoding: line, as: UTF8.self)
                    android_log(priority: priority, tag: tag, message: line)
                }
            }
        }
    }
    
    /// Stops the redirection and cleans up resources
    private func cancel() {
        task?.cancel()
        try? _close(pipe.read)
        try? _close(pipe.write)
    }
    
    /// Redirects standard output (stdout) to Android logcat with "Swift" tag
    /// - Throws: `PrintRedirectorError` if redirection fails
    func redirectPrint() throws(PrintRedirectorError) {
        try redirect(stdout, as: "Swift")
    }
    
    /// Redirects standard error (stderr) to Android logcat with "Swift" tag and error priority
    /// - Throws: `PrintRedirectorError` if redirection fails
    func redirectError() throws(PrintRedirectorError) {
        try redirect(stderr, as: "Swift", priority: .error)
    }
}

/// Errors that can occur during stream redirection operations
enum PrintRedirectorError: Error {
    case pipe    // Failed to create pipe
    case close   // Failed to close file descriptor
    case buffer  // Failed to set stream buffering
    case duplicate // Failed to duplicate file descriptor
}

// MARK: - Private Typealiases and Helper Functions

/// Represents a pipe with read and write file descriptors
private typealias Pipe = (read: CInt, write: CInt)

/// Creates a new pipe for inter-process communication
/// - Returns: A tuple containing read and write file descriptors
/// - Throws: `PrintRedirectorError.pipe` if pipe creation fails
private func _pipe() throws(PrintRedirectorError) -> Pipe {
    var tunnel: (CInt, CInt) = (-1, -1)
    let result = withUnsafeMutablePointer(to: &tunnel) { pointer in
        pointer.withMemoryRebound(to: CInt.self, capacity: 2) { tunnel in
            pipe(tunnel)
        }
    }
    guard result != -1 else {
        throw .pipe
    }
    return tunnel
}

/// Closes a file descriptor
/// - Parameter descriptor: The file descriptor to close
/// - Throws: `PrintRedirectorError.close` if closing fails
private func _close(_ descriptor: CInt) throws(PrintRedirectorError) {
    guard close(descriptor) != -1 else {
        throw .close
    }
}

/// Duplicates a file descriptor, making the target descriptor refer to the same file as the source
/// - Parameters:
///   - current: The source file descriptor
///   - target: The target file descriptor to be replaced
/// - Throws: `PrintRedirectorError.duplicate` if duplication fails
private func _duplicate(_ current: CInt, _ target: CInt) throws(PrintRedirectorError) {
    guard dup2(current, target) != -1 else {
        throw .duplicate
    }
}

/// Sets the buffering mode for a stream
/// - Parameters:
///   - stream: The stream to configure
///   - type: The buffering type (_IOFBF, _IOLBF, _IONBF)
///   - size: The buffer size (0 for default)
/// - Throws: `PrintRedirectorError.buffer` if buffering configuration fails
private func _buffer(_ stream: OpaquePointer, _ type: CInt, _ size: size_t = 0) throws(PrintRedirectorError) {
    guard setvbuf(stream, nil, type, size) != -1 else {
        throw .buffer
    }
}

func android_log(
    priority: AndroidLogPriority = .info,
    tag: String,
    message: String
) {
    _android_log_print(priority: priority.logPriority, tag: tag, message: message)
}

@_silgen_name("__android_log_print")
private func _android_log_print(
    priority: android_LogPriority,
    tag: UnsafePointer<CChar>,
    message: UnsafePointer<CChar>
)

enum AndroidLogPriority: CInt, Equatable, Hashable, Sendable, Codable {
    case unknown
    case `default`
    case verbose
    case debug
    case info
    case warn
    case error
    case fatal
    case silent
    
    var logPriority: android_LogPriority {
        switch self {
        case .unknown: return ANDROID_LOG_UNKNOWN
        case .default: return ANDROID_LOG_DEFAULT
        case .verbose: return ANDROID_LOG_VERBOSE
        case .debug: return ANDROID_LOG_DEBUG
        case .info: return ANDROID_LOG_INFO
        case .warn: return ANDROID_LOG_WARN
        case .error: return ANDROID_LOG_ERROR
        case .fatal: return ANDROID_LOG_FATAL
        case .silent: return ANDROID_LOG_SILENT
        }
    }
}
#endif
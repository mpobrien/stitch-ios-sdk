import MongoSwift
import Foundation

/**
 * A class providing the core functionality necessary to make authenticated function call requests for a particular
 * Stitch service.
 */
public protocol CoreStitchServiceClient {
    var serviceName: String? { get }

    // Disabled line length rule due to https://github.com/realm/jazzy/issues/896
    // swiftlint:disable line_length

    func callFunction(withName name: String, withArgs args: [BSONValue], withRequestTimeout requestTimeout: TimeInterval?) throws

    func callFunction<T: Decodable>(withName name: String, withArgs args: [BSONValue], withRequestTimeout requestTimeout: TimeInterval?) throws -> T

    func streamFunction(withName name: String,
                        withArgs args: [BSONValue],
                        delegate: SSEStreamDelegate?) throws -> RawSSEStream
}

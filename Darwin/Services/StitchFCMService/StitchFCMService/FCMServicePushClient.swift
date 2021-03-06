import Foundation
import StitchCore
import StitchCoreFCMService

private final class FCMNamedPushClientFactory: NamedPushClientFactory {
    typealias ClientType = FCMServicePushClient

    func client(withPushClient pushClient: StitchPushClient,
                withDispatcher dispatcher: OperationDispatcher) -> ClientType {
        return FCMServicePushClientImpl(
            withServicePushClient: CoreFCMServicePushClient(pushClient: pushClient),
            withDispatcher: OperationDispatcher(withDispatchQueue: DispatchQueue.global())
        )
    }
}

/**
 * Global factory const which can be used to create a `FCMServicePushClient` with a `StitchPush`. Pass into
 * `StitchPush.pushClient(fromFactory:withName)` to get an `FCMServicePushClient.
 */
public let fcmServicePushClientFactory =
    AnyNamedPushClientFactory<FCMServicePushClient>(factory: FCMNamedPushClientFactory())

/**
 * The FCM service push client.
 */
public protocol FCMServicePushClient {

    /**
     * Registers the given FCM registration token with the currently logged in user's device on Stitch.
     *
     * - parameters:
     *     - withRegistrationToken: the registration token to register.
     *     - completionHandler: The completion handler to call when the user is registered or the operation fails.
     *                          This handler is executed on a non-main global `DispatchQueue`.
     */
    func register(withRegistrationToken token: String, _ completionHandler: @escaping (StitchResult<Void>) -> Void)

    /**
     * Deregisters the FCM registration token bound to the currently logged in user's device on Stitch.
     *
     * - parameters:
     *     - completionHandler: The completion handler to call when the user is deregistered or the operation fails.
     *                          This handler is executed on a non-main global `DispatchQueue`.
     */
    func deregister(_ completionHandler: @escaping (StitchResult<Void>) -> Void)
}

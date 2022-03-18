pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract RandomNumber is VRFConsumerBaseV2 {
    VRFCoordinatorV2Interface COORDINATOR;
    LinkTokenInterface LINKTOKEN;

    uint64 subscriptionId;

    // Rinkeby coordinator. For other networks,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    address vrfCoordinator = 0x6168499c0cFfCaCD319c818142124B7A15E857ab;

    // Rinkeby LINK token contract. For other networks,
    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    address link = 0x01BE23585060835E02B77ef475b0Cc51aA1e0709;

    // see https://docs.chain.link/docs/vrf-contracts/#configurations
    bytes32 keyHash =
        0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc;

    uint32 callbackGasLimit = 100000;

    // The default is 3, but you can set this higher.
    uint16 requestConfirmations = 3;

    // For this example, retrieve 2 random values in one request.
    // Cannot exceed VRFCoordinatorV2.MAX_NUM_WORDS.
    uint32 numNumbers = 2;

    uint256[] public randomNumbers;
    uint256 public requestId;
    address owner;

    constructor(uint64 _subscriptionId) VRFConsumerBaseV2(vrfCoordinator) {
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        LINKTOKEN = LinkTokenInterface(link);
        owner = msg.sender;
        subscriptionId = _subscriptionId;
    }

    function getRandomNumbers() public onlyOwner {
        // Will revert if subscription is not set and funded.
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numNumbers
        );
    }

    function fulfillRandomWords(
        uint256, /* requestId */
        uint256[] memory randomWords
    ) internal override {
        randomNumbers = randomWords;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
}

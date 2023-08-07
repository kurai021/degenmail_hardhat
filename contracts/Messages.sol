// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Messages {
    struct Message {
        address sender;
        address receiver;
        string realSender;
        uint256 timestamp;
        string content;
    }

    uint256 private nextMessageId;
    mapping(uint256 => Message) private messages;
    mapping(address => uint256[]) private userMessages;

    event MessageSent(
        uint256 indexed messageId,
        address indexed sender,
        address indexed receiver
    );

    function sendMessage(
        address _receiver,
        string memory _content,
        string memory _realSender
    ) public {
        require(msg.sender != _receiver, "Cannot send message to yourself");

        nextMessageId++;
        messages[nextMessageId] = Message(
            msg.sender,
            _receiver,
            _realSender,
            block.timestamp,
            _content
        );
        userMessages[_receiver].push(nextMessageId);
        emit MessageSent(nextMessageId, msg.sender, _receiver);
    }

    function getMessage(
        uint256 _messageId
    )
        public
        view
        returns (address, address, string memory, uint256, string memory)
    {
        Message memory message = messages[_messageId];
        return (
            message.sender,
            message.receiver,
            message.realSender,
            message.timestamp,
            message.content
        );
    }

    function getUserMessages(
        address _user
    ) public view returns (uint256[] memory) {
        return userMessages[_user];
    }
}

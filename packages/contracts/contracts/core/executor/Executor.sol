/*
 * SPDX-License-Identifier:    MIT
 */

pragma solidity 0.8.10;

import "./../component/Component.sol";

// TODO: Merge with Vault.. cause otherwise executor can't call contract methods that expect eth to be send.
/// @title Implementation of the Executor
/// @author Sarkawt Azad - Aragon Association - 2021
/// @notice This contract represent the execution layer.
contract Executor is Component {
    event Executed(address indexed actor, Action[] indexed actions, bytes[] execResults);
    
    bytes32 public constant EXEC_ROLE = keccak256("EXEC_ROLE");
    
    string private constant ERROR_ACTION_CALL_FAILED = "EXCECUTOR_ACTION_CALL_FAILED";

    struct Action {
        address to; // Address to call.
        uint256 value; // Value to be sent with the call. for example (ETH)
        bytes data;
    }

    /// @notice If called, the list of provided actions will be executed.
    /// @dev It run a loop through the array of acctions and execute one by one.
    /// @dev If one acction fails, all will be reverted.
    /// @param actions The aray of actions
    function execute(Action[] memory actions) external auth(EXEC_ROLE) {
        bytes[] memory execResults = new bytes[](actions.length);

        for (uint256 i = 0; i < actions.length; i++) {
          (bool success, bytes memory response) = actions[i].to.call{ value: actions[i].value }(actions[i].data);

          require(success, ERROR_ACTION_CALL_FAILED);

          execResults[i] = response;
        }

        emit Executed(msg.sender, actions, execResults);
    }
}
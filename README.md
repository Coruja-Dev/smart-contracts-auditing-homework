# Smart Contracts Auditing Homework

Homework assignments for the Smart Contract Audit course. This repository contains security analysis and exploitation of various Capture the Ether challenges.

## Project Overview

This project demonstrates smart contract security analysis using multiple tools and methodologies:
- Static code analysis
- Automated security scanning (Slither, Mythril)
- Manual vulnerability assessment
- Proof-of-concept exploits

## Repository Structure
```
smart-contracts-auditing-homework/
├── challenges/
│   └── 1-Guess-the-number/
│       ├── GuessTheNumber.sol      # Challenge contract
│       ├── deploy.js                # Deployment script
│       ├── test.js                  # Exploit/test script
│       └── README.md                # Full security analysis report
├── hardhat.config.js                # Hardhat configuration
├── package.json                     # Project dependencies
└── .env                             # Environment variables (not tracked)
```

## Challenges Completed

### 1. Guess the Number
- **Category**: Warmup
- **Difficulty**: Beginner
- **Status**: ✅ Completed
- **Report**: [challenges/1-Guess-the-number/README.md](challenges/1-Guess-the-number/README.md)
- **Deployed Contract**: [0xC573eC98d4fB6C4297b69a0957c41163d2b3b335](https://sepolia.etherscan.io/address/0xC573eC98d4fB6C4297b69a0957c41163d2b3b335)
- **Key Vulnerability**: Information disclosure - answer stored in readable storage

## Tools Used

### Development
- **Hardhat** - Ethereum development environment
- **Ethers.js** - Blockchain interaction library
- **Node.js** - JavaScript runtime

### Security Analysis
- **Slither** - Static analysis framework
- **Mythril** - Symbolic execution tool
- **Manual Code Review** - Line-by-line analysis

### Network
- **Sepolia Testnet** - Ethereum test network for deployment

## Setup Instructions

### Prerequisites
```bash
node --version  # v16+ required
npm --version
```

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd smart-contracts-auditing-homework
```

2. Install dependencies:
```bash
npm install
```

3. Configure environment:
```bash
# Create .env file
cp .env.example .env

# Add your configuration:
# SEPOLIA_RPC_URL=https://ethereum-sepolia-rpc.publicnode.com
# PRIVATE_KEY=your_private_key_here
```

4. Get Sepolia testnet ETH:
- [Alchemy Faucet](https://www.alchemy.com/faucets/ethereum-sepolia)
- [Google Cloud Faucet](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)

### Running a Challenge
```bash
# Compile contracts
npx hardhat compile

# Deploy challenge
npx hardhat run challenges/1-Guess-the-number/deploy.js --network sepolia

# Run exploit
npx hardhat run challenges/1-Guess-the-number/test.js --network sepolia
```

## Security Analysis Workflow

For each challenge, the following methodology is applied:

1. **Static Analysis** - Manual code review to identify vulnerabilities
2. **Slither** - Automated detection of common security issues
3. **Mythril** - Symbolic execution to find exploitable paths
4. **Exploitation** - Proof-of-concept attack implementation
5. **Documentation** - Detailed writeup with remediation suggestions

## Key Findings Summary

| Challenge | Severity | Vulnerability | Tools Detected |
|-----------|----------|---------------|----------------|
| Guess the Number | Critical | Information Disclosure | Manual Review, Mythril |

## Learning Outcomes

### Vulnerabilities Explored
- Information disclosure through public storage
- Blockchain transparency misconceptions
- Outdated compiler version risks
- Access control weaknesses

### Tool Insights
- **Slither**: Excellent for code quality and patterns, may miss logic flaws
- **Mythril**: Strong at finding exploitable paths, provides attack traces
- **Manual Review**: Essential for catching design-level vulnerabilities

## References

- [Capture the Ether](https://capturetheether.com/) - Original challenges
- [Solidity Documentation](https://docs.soliditylang.org/)
- [Solidity Bug List](https://docs.soliditylang.org/en/latest/bugs.html)
- [SWC Registry](https://swcregistry.io/) - Smart Contract Weakness Classification
- [Slither Documentation](https://github.com/crytic/slither)
- [Mythril Documentation](https://github.com/ConsenSys/mythril)

## Author

**Student**: LL  
**Course**: Smart Contract Auditing  
**Date**: November 2025

## License

This project is for educational purposes only.

---

**Note**: Never use real funds or mainnet for testing. All contracts are deployed on Sepolia testnet with test ETH only.
```

## Also Create .env.example

Create a `.env.example` file in your project root:
```
SEPOLIA_RPC_URL=https://ethereum-sepolia-rpc.publicnode.com
PRIVATE_KEY=your_private_key_here_without_0x_prefix
```

## Update .gitignore

Make sure your `.gitignore` includes:
```
node_modules
.env
cache
artifacts
coverage
typechain
typechain-types
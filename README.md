# Monetizado version 2

This is a new version built for Polkadot Asset Hub, for the old version, [check here](https://github.com/Monetizado/Contracts)

Monetizado is an on-chain pay-per-view platform that allows you to monetize any web page and static content (if you don't have access to the backend to make changes) through Web3.

With Monetizado, you can implement it on news sites, social networks, exclusive content portals, and more. You could also use it to incentivize users to pay not to see advertising on your sites.

## Demo and other links

- Demo with Polkadot Asset Hub: https://monetizado.github.io/demoassethub/index.html
- Manager (to create and manage contents, withdraw money and check the amount available to withdraw): https://monetizado.github.io/managerassethub/index.html


## Features
Monetizado allows you to:
- Specify content with a specific amount that users must pay to access.
- Review the protected content you have created.
- To your followers/users, pay to see your content.
- Verify if a user has access to your content.
- Withdraw the money collected for your content.

_This version is a simplified version, with less features (not necessaries right now)._

## Use case
You can use monetized to protect pages so that only subscribers can see it, as in:
- News portals.
- Videos.
- Audios.
- Files
- Blogs.
- Social networks.
- And much more.

**You can protect each page individually (each with its own ID, which you will see later in this document) and the user must pay to view each page, or all are classified under the same ID, so the user only pays once to view different pages. It's your decision as a content creator.**

## Limitations
- For now, it only allows you to specify and pay just in WND (the native currency for Polkadot Asset Hub chain).
- You can use Monetizado from the Smart contract or Javascript library.

## Contract Id
Monetizado is implemented in:

- **Polkadot Asset Hub (testnet)**: https://westend-asset-hub-eth-explorer.parity.io/address/0x86f5304600627e7897AaAfAD39853e3D18E71B43


## Use Monetizado
Now we explain how to use Monetizado, both the smart contract (backend) and the Javascript library that you can implement on any Web platform in the frontend:

Now we explain about version 1 of Monetizado, explaining how to implement it in the backend of your platform through smart contracts, or in the frontend directly if you have a static site/content.

### Smart contracts

#### Add Content
Indicates the content to be protected, giving a name and an amount (always in wei format), and returns a content Id (a sequential number associated with the creator's address).
```
function add(string memory name, uint256 cost) public returns (uint256)
```

Having the generated Id, plus the address of the content creator (msg.sender), it can be used in the following methods to view or pay for content.

#### Get Protected Contents For Current User
List all content protected by the content creator calling this method (msg.sender)

```
struct Content {
        string name;
        uint256 cost;
        uint256 sequenceId;
        address creator;
        uint256 amountAvailable;
        uint256 totalAmount;
    }

function getContentsCreator() public view returns (Content[] memory)
```

In _Content_, _cost_ represents the cost (in wei) for the content that must be paid by users, _sequenceId_ is the sequential Id that you must use to distinguish the different contents of a creator, _amountAvailable_ is the amount that the creator has available to withdraw, and _totalAmount_ is the total amount that the creator has obtained for this content.

#### Get Contents For Address and Id
Returns content protected by a specified content creator and Id
```
function getContent(address creator, uint256 sequenceId) public view returns (Content memory)
```

#### Pay for content
A user (msg.sender) pays for the content they want to access, specifying the creator Id (address) and the sequential Id of the content.
```
function pay(address creator, uint256 sequenceId) external payable
```

In the value (msg.value) the exact value of the content must be specified.

#### Current User Has Access
Checks if the current user (msg.sender) has access to a creator's specific content.

```
function hasAccess(address creator, uint256 sequenceId) public view returns(bool)
```


#### Withdraw Money From Content
The content creator can withdraw money from their content, specifying the ID and the amount they wish to withdraw.

```
function withdraw(uint256 sequenceId, uint256 amount) external
```

### Frontend
To use Monetized from the frontend (if you don't have access to the backend or have static content), you can use the available JavaScript library: https://github.com/Monetizado/monetizadojs 



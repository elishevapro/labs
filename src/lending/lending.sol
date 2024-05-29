// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "@openzeppelin/ERC20/ERC20.sol";
import "@openzeppelin/ERC20/IERC20.sol";
import "@openzeppelinAccess/Ownable.sol";
import "@hack/tokens/MyERC20.sol";
//import "";
import "forge-std/console.sol";
import "@hack/math/mathLend.sol";
import "@hack/math/math.sol";
import "@hack/libs/safemath.sol";
// import "./myAAVE.sol";
interface ILendingPool {
    function deposit(
        address asset,
        uint256 amount,
        address onBehalfOf,
        uint16 referralCode
    ) external;

    function withdraw(
        address asset,
        uint256 amount,
        address to
    ) external returns (uint256);
}

interface IWETHGateway {
    function depositETH(
        address lendingPool,
        address onBehalfOf,
        uint16 referralCode
    ) external payable;

    function withdrawETH(
        address lendingPool,
        uint256 amount,
        address onBehalfOf
    ) external;
}
contract Lend is Mathematics, Ownable, DSMath{
    using SafeMath for uint256;
    // address public owner;
    mapping(address=>uint) public userBorrowed;
    mapping(address=>uint) public userCollateral;
    //mapping(address=>uint) public depositDAI;
    // IERC20 public dai;
    MyToken public bond;
    uint256 public totalBorrowed;
    uint256 public totalReserve;
    uint256 public totalDeposit;
    uint256 public maxLTV = 4; // 1 = 20%
    uint256 public ethTreasury;
    uint256 public totalCollateral;
    uint256 public baseRate = 20000000000000000;
    uint256 public fixedAnnuBorrowRate = 300000000000000000;
    ILendingPool public constant aave = ILendingPool(0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD);
    IWETHGateway public constant wethGateway =
        IWETHGateway(0xA61ca04DF33B72b235a8A28CfB535bb7A5271B70);
    IERC20 public constant dai =
        IERC20(0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD);
    IERC20 public constant aDai =
        IERC20(0xdCf0aF9e59C002FA3AA091a46196b37530FD48a8);
    IERC20 public constant aWeth =
        IERC20(0x87b1f4cf9BD63f7BBD3eE1aD04E8F52540349347);
    IERC20 private constant weth =
        IERC20(0xd0A1E359811322d97991E03f863a0C30C2cF029C);

    modifier amountPositive(uint amount){
        require(amount > 0, "Must be bigger than zero");
        _;
    }
    constructor(address _bond, address initialOwner) Ownable(initialOwner){
        bond = MyToken(_bond);
    }
    
    function _sendDaiToAave(uint256 _amount) internal {
        dai.approve(address(aave), _amount);
        aave.deposit(address(dai), _amount, address(this), 0);
    }

    function _withdrawDaiFromAave(uint256 _amount) internal {
        aave.withdraw(address(dai), _amount, msg.sender);
    }

    function _sendWethToAave(uint256 _amount) internal {
        wethGateway.depositETH{value: _amount}(address(aave), address(this), 0);
    }

    function _withdrawWethFromAave(uint256 _amount) internal {
        aWeth.approve(address(wethGateway), _amount);
        wethGateway.withdrawETH(address(aave), _amount, address(this));
    }

    function bondAsset(uint _amount) external amountPositive(_amount){
        dai.transferFrom(msg.sender,address(this), _amount);
        totalDeposit += _amount;
        _sendDaiToAave(_amount);
        uint bondsToMint = getExp(_amount, getExchangeRate());
        bond.mint(msg.sender, bondsToMint);
    } 

    function unbondAsset(uint256 _amount) external {
        require(_amount <= bond.balanceOf(msg.sender), "Not enough bonds!");
        uint256 daiToReceive = mulExp(_amount, getExchangeRate());
        totalDeposit -= daiToReceive;
        bond.burn(msg.sender, _amount);
        _withdrawDaiFromAave(daiToReceive);
    }
    function getExchangeRate() public view returns (uint256) {
        if (bond.totalSupply() == 0) {
            return 1000000000000000000;
        }
        uint256 cash = getCash();
        uint256 num = cash.add(totalBorrowed).add(totalReserve);
        return getExp(num, bond.totalSupply());
    }
    function getCash() public view returns (uint256) {
        return totalDeposit.sub(totalBorrowed);
    }    
}
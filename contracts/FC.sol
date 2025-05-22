// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@prb/math/src/UD60x18.sol";

contract FC is ERC20, Ownable {
    event Pool(
        address indexed sender,
        address indexed to,
        uint usdt,
        uint fc,
        uint pool_usdt,
        uint pool_fc,
        uint rate,
        int8 swap_type
    );
    uint256 public pool_usdt;
    address public constant USDT = 0x55d398326f99059fF775485246999027B3197955;
    constructor(
        address pool
    ) ERC20("Fund Coin", "FC") Ownable(msg.sender) {
        pool_usdt = 7777 ether;
        address sender = msg.sender;
        _mint(sender, 1111_000 ether);
        pool_addr = pool;
        emit Pool(
            sender,
            pool,
            pool_usdt,
            totalSupply(),
            pool_usdt,
            totalSupply(),
            ratio,
            0
        );
    }

    event Ratio(uint old_ratio, uint new_ratio);
    uint public ratio = 7500;
    function setRatio(uint r) external onlyOwner {
        require(r <= 10000 && r >= 5000, "r err");
        emit Ratio(ratio, r);
        ratio = r;
    }

    address public pool_addr;
    function setPool(address addr) external onlyOwner {
        require(pool_addr != address(this), "addr err");
        pool_addr = addr;
    }

    function getRuntimeInfo() external view returns (
        uint pool_usdt_, 
        uint pool_fc_, 
        uint price_, 
        uint ratio_) {
        pool_usdt_ = pool_usdt;
        pool_fc_ = totalSupply();
        price_ = UD60x18.wrap(pool_usdt_).div(UD60x18.wrap(pool_fc_)).unwrap();
        ratio_ = ratio;
    }

    function getMintExactUsdt(uint usdt) public view returns (uint fc) {
        UD60x18 usdt_ = UD60x18.wrap(usdt);
        UD60x18 pool_usdt_ = UD60x18.wrap(pool_usdt);
        UD60x18 totalSupply_ = UD60x18.wrap(totalSupply());
        UD60x18 ratio_ = pool_usdt_.add(usdt_).div(pool_usdt_);
        UD60x18 power_ = ratio_.pow(UD60x18.wrap(ratio * 1e14));
        UD60x18 fc_ = totalSupply_.mul(power_).sub(totalSupply_);
        fc = fc_.unwrap();
    }

    function getMintExactFc(uint fc) public view returns (uint usdt) {
        UD60x18 fc_ = UD60x18.wrap(fc);
        UD60x18 pool_usdt_ = UD60x18.wrap(pool_usdt);
        UD60x18 totalSupply_ = UD60x18.wrap(totalSupply());
        UD60x18 one_ = UD60x18.wrap(1e18);
        UD60x18 exp_ = one_.div(UD60x18.wrap(ratio * 1e14));
        UD60x18 ratio_ = fc_.div(totalSupply_).add(one_);
        UD60x18 usdt_ = pool_usdt_.mul(ratio_.pow(exp_)).sub(pool_usdt_);
        usdt = usdt_.unwrap();
    }

    function getBurnExactFc(uint fc) public view returns (uint usdt) {
        UD60x18 fc_ = UD60x18.wrap(fc);
        UD60x18 pool_usdt_ = UD60x18.wrap(pool_usdt);
        UD60x18 totalSupply_ = UD60x18.wrap(totalSupply());
        UD60x18 ratio_ = totalSupply_.sub(fc_).div(totalSupply_);
        UD60x18 power_ = ratio_.pow(UD60x18.wrap(ratio * 1e14));
        UD60x18 usdt_ = pool_usdt_.sub(pool_usdt_.mul(power_));
        usdt = usdt_.unwrap();
    }

    function getBurnExactUsdt(uint usdt) public view returns (uint fc) {
        UD60x18 usdt_ = UD60x18.wrap(usdt);
        UD60x18 pool_usdt_ = UD60x18.wrap(pool_usdt);
        UD60x18 totalSupply_ = UD60x18.wrap(totalSupply());
        UD60x18 one_ = UD60x18.wrap(1e18);
        UD60x18 exp_ = one_.div(UD60x18.wrap(ratio * 1e14));
        UD60x18 ratio_ = one_.sub(usdt_.div(pool_usdt_));
        UD60x18 fc_ = totalSupply_.sub(totalSupply_.mul(ratio_.pow(exp_)));
        fc = fc_.unwrap();
    }

    function mintExactUsdt(uint usdt, address to) external returns (uint fc) {
        address sender = msg.sender;
        IERC20(USDT).transferFrom(sender, pool_addr, usdt);
        fc = getMintExactUsdt(usdt);
        require(usdt >= 1e18, "err");
        _mint(to, fc);
        pool_usdt += usdt;
        emit Pool(sender, to, usdt, fc, pool_usdt, totalSupply(), ratio, 1);
    }

    function mintExactFc(uint fc, address to) external returns (uint usdt) {
        address sender = msg.sender;
        usdt = getMintExactFc(fc);
        require(usdt >= 1e18, "err");
        IERC20(USDT).transferFrom(sender, pool_addr, usdt);
        _mint(to, fc);
        pool_usdt += usdt;
        emit Pool(sender, to, usdt, fc, pool_usdt, totalSupply(), ratio, 1);
    }

    function burnExactFc(uint fc, address to) external returns (uint usdt) {
        address sender = msg.sender;
        usdt = getBurnExactFc(fc);
        require(usdt >= 1e18, "err");
        _burn(sender, fc);
        IERC20(USDT).transfer(to, usdt);
        pool_usdt -= usdt;
        emit Pool(sender, to, usdt, fc, pool_usdt, totalSupply(), ratio, -1);
    }

    function burnExactUsdt(uint usdt, address to) external returns (uint fc) {
        address sender = msg.sender;
        fc = getBurnExactUsdt(usdt);
        require(usdt >= 1e18, "err");
        _burn(sender, fc);
        IERC20(USDT).transfer(to, usdt);
        pool_usdt -= usdt;
        emit Pool(sender, to, usdt, fc, pool_usdt, totalSupply(), ratio, -1);
    }
}

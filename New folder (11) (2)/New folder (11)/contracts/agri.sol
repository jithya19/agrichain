pragma solidity ^0.8.0;

contract SupplyChain {

    struct Product {
        string name;
        string description;
        uint256 price;
        address owner;
        address[] history;
    }

    mapping (uint256 => Product) public products;

    function addProduct(uint256 _productId, string memory _name, string memory _description, uint256 _price) public {
        products[_productId].name = _name;
        products[_productId].description = _description;
        products[_productId].price = _price;
        products[_productId].owner = msg.sender;
        products[_productId].history.push(msg.sender);
    }

    function transferProduct(uint256 _productId, address _newOwner) public {
        require(products[_productId].owner == msg.sender, "Only the current owner can transfer the product");
        products[_productId].owner = _newOwner;
        products[_productId].history.push(_newOwner);
    }

    function getProductHistory(uint256 _productId) public view returns (address[] memory) {
        return products[_productId].history;
    }
}
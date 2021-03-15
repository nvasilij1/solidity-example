pragma solidity 0.5.12;

contract exampleERC20Test{
    string public constant name = "MyExampleToken";
    string public constant symbol = "MET"; // MyExampleToken
    uint8 public constant decimal = 2; //так то 18 знаков после запятой но для теста 2
    
    uint public totalSupply;
    
    mapping (address => uint) balances;
    
    mapping (address => mapping (address => uint)) allowed; //кто может переводить токены
    
    //события происходящие с токеном записывается
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _from, address indexed _to, uint _value);
    
    
    function mint(address _to, uint _value) public {
        require(totalSupply + _value >= totalSupply && balances[_to] + _value >= balances[_to]); //проверка на переполнение (по хорошему надо библиотеку)
        balances[_to] += _value;
        totalSupply += _value;
    }
    
    //запрос баланса
    function balanceOf(address _owner) public view returns (uint) {
        return balances[_owner];   
    }
    
    //показывает количество токенов, которое разрешено снимать адресу
    function allowance(address _owner, address _spender) public view returns (uint) {
        return allowed[_owner][_spender];
    }
    
    function transfer(address _to, uint _value) public {
        require(balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]); //проверка на переполнение
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
    }
    
    function transferFrom(address _from, address _to, uint _value) public {
        //проверка на переполнение и на разрешение, кто может передавать нужное количество токены
        require(balances[_from] >= _value && balances[_to] + _value >= balances[_to] && allowed[_from][msg.sender] >= _value); 
        balances[_from] -= _value;
        balances[_to] += _value;
        //отнимаем сумму которая переводилась из разрешенных к передаче токенов
        allowed[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
    }
    
    function approve(address _spender, uint _value) public {
        allowed[msg.sender][_spender] = _value; //отправитель разрешает снимать какое то количество токенов
        emit Approval(msg.sender, _spender, _value);
        
    }
}
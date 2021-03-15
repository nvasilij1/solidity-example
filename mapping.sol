pragma solidity 0.5.12;
//Простенький контракт привязывает данные о компании к кошельку, и по привязаному кошельку можно посмотреть данные компании
contract forMappingTest{
    struct Company{
        string name; //Имя компании
        uint age;    //Сколько существует
        uint workers;//Сколько работников
    }
    
    mapping(address => Company) private companies; //привяжем адрес кошелька к компании
    
    function addCompany(string memory name, uint age, uint workers) public {
        address sender = msg.sender; //с message data center возьмет адрес кошелька того, кто инициировал контракт
        
        Company memory newCompany;
        newCompany.name = name;
        newCompany.age = age;
        newCompany.workers = workers;
        
        companies[sender] = newCompany;
    }
    
    function getCompany() public view returns (string memory name, uint age, uint workers){
        address sender = msg.sender;
        return (companies[sender].name, companies[sender].age, companies[sender].workers);
    }
	
}

// указываем версию Solidity, которая будет использована для компиляции контракта
pragma solidity ^0.8.0;

// создаем контракт
contract MyToken {
    // задаем имя и символ токена
    string public name = "My Token";
    string public symbol = "MTK";
    
    // задаем общее количество токенов, которые будут созданы
    uint256 public totalSupply = 1000000 * 10**18; // 1 миллион токенов с 18 десятичными знаками
    
    // создаем маппинг для хранения балансов пользователей
    mapping(address => uint256) public balanceOf;
    
    // создаем конструктор контракта, который будет вызываться при его создании
    constructor() {
        // инициализируем баланс создателя контракта
        balanceOf[msg.sender] = totalSupply;
    }
    
    // создаем функцию для перевода токенов между пользователями
    function transfer(address _to, uint256 _value) public returns (bool success) {
        // проверяем достаточность баланса отправителя транзакции
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        
        // проверяем наличие достаточного количества газа для выполнения транзакции
        require(gasleft() > 21000, "Insufficient gas");
        
        // уменьшаем баланс отправителя транзакции
        balanceOf[msg.sender] -= _value;
        
        // увеличиваем баланс получателя транзакции
        balanceOf[_to] += _value;
        
        // возвращаем успешный результат выполнения функции
        return true;
    }
}

---
title: Calls and Returns
layout: page
categories:
  - ethereum
  - functions
previous:
  - 
  - /pages/fn01.html
next:
  - /pages/introduction/smartcontract.html
  - /pages/fn03.html
difficulty: medium
---

# Calls and Returns

## Calls

During the previous exercises, you've been presented with mutability and visibility of function, but you have never used one. Function are useful to structure your code. In a spaceship, functions would be like buttons. Each one has its own behaviour, you can dive into it or just press it.

And it looks like you haven't been able to press any! Instead of *pressing* a function, you *call* it. It looks like the following
```solidity
uint public fans = 0;

function increment() public pure returns (uint) {
  return 2;
}

function like() public {
  // `increment()` is the function call
  // It will execute increment code and insert its return value in the expression
  fans = fans + increment();
}
```

{% exercise %}
It looks like `SpaceMuffin` had a secret recipe. Expose it to the world!
{% initial %}
pragma solidity ^0.4.24;

contract SpaceMuffin {
  // Secret recipe is here but inaccessible externally
  function superSecretRecipe () private pure returns (string) {
    return "Ingredients: 1L SpaceMilk, 100g SpaceButter and 100g SpaceChocolate. Instructions: Mix, then bake 45min in your SpaceOven";
  }
  
  function contactMe () external pure returns (string) {
    // As a malicious attacker, you want to expose the recipe
    return ;
  }
}
{% solution %}
pragma solidity ^0.4.24;

contract SpaceMuffin {
  function superSecretRecipe () private pure returns (string) {
    // Add some SpaceVanillaSugar to make them taste better
    return "Ingredients: 1L SpaceMilk, 100g SpaceButter and 100g SpaceChocolate. Instructions: Mix, then bake 45min in your SpaceOven";
  }
  
  function contactMe () external pure returns (string) {
    // What a horrible person you are
    // Exposing top secret information
    return superSecretRecipe();
  }
}

{% validation %}
pragma solidity ^0.4.24;

import "Assert.sol";
import "SpaceMuffin.sol";

contract TestSpaceMuffin {
  SpaceMuffin spaceMuffin = SpaceMuffin(__ADDRESS__);
  
  function testContactMe() public {
    string memory result = spaceMuffin.contactMe();
    string memory expected = "Ingredients: 1L SpaceMilk, 100g SpaceButter and 100g SpaceChocolate. Instructions: Mix, then bake 45min in your SpaceOven";
    Assert.equal(result, expected, "The recipe you send is not the one expected");
  }
  
  event TestEvent(bool indexed result, string message);
}

{% endexercise %}

Calling a function is like ringing a phone

## Arguments

Do you remember what a function signature looks like?
```html
function <name> ([arg1, arg2, ...]) <visibility> [mutability] [returns ([ret1, ret2, ...])] ;
```

After the function `name`, comes `([arg1, arg2, ...])`.

It allows you to pass fresh variables to your function.

```solidity
function like() public {
  multiLike(1);
}

function multiLike(uint numberOfLikes) public {
  fans = fans + numberOfLikes;
}
```

{% exercise %}
Cryptadvisor has contacted you because they want to know if your muffin is recommended. You should create an `isRecommended` function that test if the muffin `isBestMuffin` and (`&&`) the number of `fans` is `notZero`
{% initial %}
pragma solidity ^0.4.24;

contract SpaceMuffin {
  uint public fans = 0;

  // Now you know that this function is really simple
  function like() public {
    fans = fans + 1;
  }

  // welcome back, old friend
  function isBestMuffin() public pure returns (bool) {
    return true;
  }
  
  // I've already made this function for you ;)
  function notZero(uint number) internal pure returns (bool) {
    return number != 0;
  }
  
  // This function returns a boolean
  function isRecommended() public view returns (bool) {
    return ;
  }
}

{% solution %}
pragma solidity ^0.4.24;

contract SpaceMuffin {
  uint public fans = 0;

  // I actually need it to check if your code is correct
  function like() public {
    fans = fans + 1;
  }

  // welcome back, old friend
  // good recipe never dies
  function isBestMuffin() public pure returns (bool) {
    return true;
  }
  
  // This function is actually not really necessary, it is just to practise :D
  function notZero(uint number) internal pure returns (bool) {
    return number != 0;
  }
  
  // But what is a return ?
  function isRecommended() public view returns (bool) {
    return isBestMuffin() && notZero(fans);
  }
}

{% validation %}
pragma solidity ^0.4.24;

import "Assert.sol";
import "SpaceMuffin.sol";

contract TestSpaceMuffin {
  SpaceMuffin spaceMuffin = SpaceMuffin(__ADDRESS__);
  
  function testNoFans() public {
    bool result = spaceMuffin.isRecommended();
    bool expect = false;
    Assert.equal(result, expect, "When there is no fans, space muffin is sadly not recommended");
  }
  
  function testWithFans() public {
      spaceMuffin.like();
      bool result = spaceMuffin.isRecommended();
      bool expect = true;
      Assert.equal(result, expect, "There is at least one fan of the space muffin, it should be recommended");
    }
    
  event TestEvent(bool indexed result, string message);
}

{% endexercise %}

## Return

{% exercise %}
The Space Muffin contract is broken 😢 You must make SpaceMuffin great again!

{% initial %}
pragma solidity ^0.4.24;

contract SpaceMuffin {
  uint public fans = 0;

  // This function hasn't the proper return type
  function isBestMuffin() public pure returns (uint) {
    return true;
  }
  
  // This one has, but has another problem
  function getFans() public view returns (uint) {
    return true;
  }
  
  // You can name return variables :D
  function superSecretRecipe() private pure returns (string recipe) {
    recipe = "Ingredients: 1L SpaceMilk, 100g SpaceButter and 100g SpaceChocolate. Instructions: Mix, then bake 45min in your SpaceOven";
  }
}

{% solution %}

pragma solidity ^0.4.24;

contract SpaceMuffin {
  uint public fans = 0;

  // This function hasn't the proper return type
  function isBestMuffin() public pure returns (bool) {
    return true;
  }
  
  // This one has, but has another problem
  function getFans() public view returns (uint) {
    return fans;
  }
  
  // As you might have notice, you don't even need a return
  function superSecretRecipe() private pure returns (string recipe) {
    recipe = "Ingredients: 1L SpaceMilk, 100g SpaceButter and 100g SpaceChocolate. Instructions: Mix, then bake 45min in your SpaceOven";
  }
}

{% validation %}
pragma solidity ^0.4.24;

// I don't want to put any validation here
// It's more solving the compilation problem than executing test onchain

{% endexercise %}

Ok, I haven't written anything but you should have got the point, haven't you?
When called, functions do their internal little tricks and give you back results.
These results are associated with a type, so you can catch them within variables.

If a function `returns` something, there should be at least one `return` statement before it ends.
It acts as a promise. If I promise you a `SpaceMuffin`, I should give you one. ith the same process, if I give you a `SpaceSalad`, you won't be happy either.

> **Amiral tips**:
> Never give the compiler a `bool` when it expects a `uint`. `bool` are like `SpaceSalad`, you like them but not that much

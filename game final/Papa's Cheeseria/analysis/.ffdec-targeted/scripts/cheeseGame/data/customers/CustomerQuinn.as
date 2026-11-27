package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerQuinn extends CustomerDataFile
   {
      
      public function CustomerQuinn()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Quinn";
         this.customerClipName = "Quinn";
         this.isCloser = true;
         this.customerFirstGame = "Papa\'s Taco Mia!";
         this.thumbColor = "purple";
         this.flipdeckNumber = 8;
         this.holidayOutfit = GameData.MONTH_OCTOBER;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc4_:CustomerOrder = null;
         var _loc5_:CustomerOrder = null;
         var _loc6_:CustomerOrder = null;
         var _loc7_:CustomerOrder = null;
         var _loc8_:CustomerOrder = null;
         var _loc9_:CustomerOrder = null;
         var _loc10_:CustomerOrder = null;
         var _loc11_:CustomerOrder = null;
         var _loc12_:CustomerOrder = null;
         var _loc13_:CustomerOrder = null;
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FOCACCIA);
         _loc1_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_BACON,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BALSAMIC);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_FOCACCIA);
         _loc2_.setCheese(FoodData.CHEESE_OAXACA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_BACON,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BALSAMIC);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
         var _loc3_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc3_.setBread(FoodData.BREAD_FOCACCIA);
         _loc3_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc3_.setCookType(FoodData.COOK_MEDIUM);
         _loc3_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_BACON,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_CALYPSO);
         _loc3_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc3_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc3_);
         _loc4_ = new CustomerOrder(GameData.MONTH_JULY);
         _loc4_.setBread(FoodData.BREAD_TEXASTOAST);
         _loc4_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc4_.setCookType(FoodData.COOK_MEDIUM);
         _loc4_.addToppings(FoodData.TOPPING_BEEFBRISKET,FoodData.TOPPING_BACON,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BALSAMIC);
         _loc4_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc4_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc4_);
         _loc5_ = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc5_.setBread(FoodData.BREAD_FOCACCIA);
         _loc5_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc5_.setCookType(FoodData.COOK_MEDIUM);
         _loc5_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_SALAMI,FoodData.TOPPING_MEATBALLS,FoodData.SAUCE_MARINARA);
         _loc5_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc5_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc5_);
         _loc6_ = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc6_.setBread(FoodData.BREAD_CINNAMON);
         _loc6_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc6_.setCookType(FoodData.COOK_MEDIUM);
         _loc6_.addToppings(FoodData.TOPPING_SAUSAGE,FoodData.TOPPING_HAM,FoodData.TOPPING_SAUSAGE,FoodData.SAUCE_MAPLESYRUP);
         _loc6_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc6_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc6_);
         _loc7_ = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc7_.setBread(FoodData.BREAD_ECTOBREAD);
         _loc7_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc7_.setCookType(FoodData.COOK_MEDIUM);
         _loc7_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_SALAMI,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_SPOOKYSLAW,FoodData.SAUCE_BALSAMIC);
         _loc7_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc7_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc7_);
         _loc8_ = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc8_.setBread(FoodData.BREAD_PUMPKIN);
         _loc8_.setCheese(FoodData.CHEESE_CHEESEBALL);
         _loc8_.setCookType(FoodData.COOK_MEDIUM);
         _loc8_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_SALAMI,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BALSAMIC);
         _loc8_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc8_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc8_);
         _loc9_ = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc9_.setBread(FoodData.BREAD_FOCACCIA);
         _loc9_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc9_.setCookType(FoodData.COOK_MEDIUM);
         _loc9_.addToppings(FoodData.TOPPING_GOOSE,FoodData.TOPPING_SALAMI,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_CRANBERRY);
         _loc9_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc9_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc9_);
         _loc10_ = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc10_.setBread(FoodData.BREAD_FOCACCIA);
         _loc10_.setCheese(FoodData.CHEESE_GRUYERE);
         _loc10_.setCookType(FoodData.COOK_MEDIUM);
         _loc10_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_SALAMI,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_MACNCHEESE,FoodData.SAUCE_BALSAMIC);
         _loc10_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc10_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc10_);
         _loc11_ = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc11_.setBread(FoodData.BREAD_BEET);
         _loc11_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc11_.setCookType(FoodData.COOK_MEDIUM);
         _loc11_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_SALAMI,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_STRAWBERRY);
         _loc11_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc11_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc11_);
         _loc12_ = new CustomerOrder(GameData.MONTH_MARCH);
         _loc12_.setBread(FoodData.BREAD_FOCACCIA);
         _loc12_.setCheese(FoodData.CHEESE_SAGEDERBY);
         _loc12_.setCookType(FoodData.COOK_MEDIUM);
         _loc12_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_SALAMI,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_IRISHPARSLEY);
         _loc12_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc12_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc12_);
         _loc13_ = new CustomerOrder(GameData.MONTH_APRIL);
         _loc13_.setBread(FoodData.BREAD_PASKA);
         _loc13_.setCheese(FoodData.CHEESE_SIRECZ);
         _loc13_.setCookType(FoodData.COOK_MEDIUM);
         _loc13_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_SALAMI,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BALSAMIC);
         _loc13_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc13_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc13_);
      }
   }
}


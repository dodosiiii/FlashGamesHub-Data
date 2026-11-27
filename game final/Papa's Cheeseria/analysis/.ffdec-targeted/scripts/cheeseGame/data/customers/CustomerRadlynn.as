package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerRadlynn extends CustomerDataFile
   {
      
      public function CustomerRadlynn()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Radlynn";
         this.customerClipName = "Radlynn";
         this.thumbColor = "deepred";
         this.customerFirstGame = "Papa\'s Hot Doggeria";
         this.flipdeckNumber = 116;
         this.holidayOutfit = GameData.MONTH_OCTOBER;
         this.isCloser = true;
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
         _loc1_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc1_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_TORTILLA);
         _loc2_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_GUACAMOLE);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc2_);
         var _loc3_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc3_.setBread(FoodData.BREAD_HAWAIIAN);
         _loc3_.setCheese(FoodData.CHEESE_MANGO);
         _loc3_.setCookType(FoodData.COOK_MEDIUM);
         _loc3_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_CALYPSO);
         _loc3_.setFries(FoodData.FRIES_WAFFLE);
         _loc3_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc3_);
         _loc4_ = new CustomerOrder(GameData.MONTH_JULY);
         _loc4_.setBread(FoodData.BREAD_TEXASTOAST);
         _loc4_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc4_.setCookType(FoodData.COOK_MEDIUM);
         _loc4_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_PITSAUCE);
         _loc4_.setFries(FoodData.FRIES_WAFFLE);
         _loc4_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc4_);
         _loc5_ = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc5_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc5_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc5_.setCookType(FoodData.COOK_MEDIUM);
         _loc5_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_MEATBALLS,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc5_.setFries(FoodData.FRIES_WAFFLE);
         _loc5_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc5_);
         _loc6_ = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc6_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc6_.setCheese(FoodData.CHEESE_MAPLEJACK);
         _loc6_.setCookType(FoodData.COOK_MEDIUM);
         _loc6_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_SAUSAGE,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc6_.setFries(FoodData.FRIES_WAFFLE);
         _loc6_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc6_);
         _loc7_ = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc7_.setBread(FoodData.BREAD_ECTOBREAD);
         _loc7_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc7_.setCookType(FoodData.COOK_MEDIUM);
         _loc7_.addToppings(FoodData.TOPPING_SPOOKYSLAW,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc7_.setFries(FoodData.FRIES_WAFFLE);
         _loc7_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc7_);
         _loc8_ = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc8_.setBread(FoodData.BREAD_PUMPKIN);
         _loc8_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc8_.setCookType(FoodData.COOK_MEDIUM);
         _loc8_.addToppings(FoodData.TOPPING_STUFFING,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc8_.setFries(FoodData.FRIES_WAFFLE);
         _loc8_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc8_);
         _loc9_ = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc9_.setBread(FoodData.BREAD_FRUITCAKE);
         _loc9_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc9_.setCookType(FoodData.COOK_MEDIUM);
         _loc9_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_GOOSE,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc9_.setFries(FoodData.FRIES_WAFFLE);
         _loc9_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc9_);
         _loc10_ = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc10_.setBread(FoodData.BREAD_CHEDDARSWIRL);
         _loc10_.setCheese(FoodData.CHEESE_GRUYERE);
         _loc10_.setCookType(FoodData.COOK_MEDIUM);
         _loc10_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc10_.setFries(FoodData.FRIES_WAFFLE);
         _loc10_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc10_);
         _loc11_ = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc11_.setBread(FoodData.BREAD_BEET);
         _loc11_.setCheese(FoodData.CHEESE_REDWINDSOR);
         _loc11_.setCookType(FoodData.COOK_MEDIUM);
         _loc11_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_STRAWBERRY);
         _loc11_.setFries(FoodData.FRIES_WAFFLE);
         _loc11_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc11_);
         _loc12_ = new CustomerOrder(GameData.MONTH_MARCH);
         _loc12_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc12_.setCheese(FoodData.CHEESE_SAGEDERBY);
         _loc12_.setCookType(FoodData.COOK_MEDIUM);
         _loc12_.addToppings(FoodData.TOPPING_BEEFHASH,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc12_.setFries(FoodData.FRIES_WAFFLE);
         _loc12_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc12_);
         _loc13_ = new CustomerOrder(GameData.MONTH_APRIL);
         _loc13_.setBread(FoodData.BREAD_PASKA);
         _loc13_.setCheese(FoodData.CHEESE_SIRECZ);
         _loc13_.setCookType(FoodData.COOK_MEDIUM);
         _loc13_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc13_.setFries(FoodData.FRIES_WAFFLE);
         _loc13_.addFryToppings(FoodData.FRYTOPPING_CHIVES,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc13_);
      }
   }
}


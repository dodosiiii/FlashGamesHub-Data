package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerHank extends CustomerDataFile
   {
      
      public function CustomerHank()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Hank";
         this.customerClipName = "Hank";
         this.customerFirstGame = "Papa\'s Pancakeria";
         this.thumbColor = "yelloworange";
         this.holidayOutfit = GameData.MONTH_OCTOBER;
         this.isCloser = true;
         this.flipdeckNumber = 27;
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
         _loc1_.setBread(FoodData.BREAD_RYE);
         _loc1_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_MUSHROOMS);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_RYE);
         _loc2_.setCheese(FoodData.CHEESE_OAXACA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_CHORIZO,FoodData.TOPPING_MUSHROOMS);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc2_);
         var _loc3_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc3_.setBread(FoodData.BREAD_HAWAIIAN);
         _loc3_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc3_.setCookType(FoodData.COOK_MEDIUM);
         _loc3_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_MUSHROOMS);
         _loc3_.setFries(FoodData.FRIES_REGULAR);
         _loc3_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc3_);
         _loc4_ = new CustomerOrder(GameData.MONTH_JULY);
         _loc4_.setBread(FoodData.BREAD_RYE);
         _loc4_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc4_.setCookType(FoodData.COOK_MEDIUM);
         _loc4_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_BEEFBRISKET,FoodData.TOPPING_MUSHROOMS);
         _loc4_.setFries(FoodData.FRIES_REGULAR);
         _loc4_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc4_);
         _loc5_ = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc5_.setBread(FoodData.BREAD_RYE);
         _loc5_.setCheese(FoodData.CHEESE_RICOTTA);
         _loc5_.setCookType(FoodData.COOK_MEDIUM);
         _loc5_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_MUSHROOMS);
         _loc5_.setFries(FoodData.FRIES_REGULAR);
         _loc5_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc5_);
         _loc6_ = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc6_.setBread(FoodData.BREAD_CINNAMON);
         _loc6_.setCheese(FoodData.CHEESE_MAPLEJACK);
         _loc6_.setCookType(FoodData.COOK_MEDIUM);
         _loc6_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_MUSHROOMS);
         _loc6_.setFries(FoodData.FRIES_REGULAR);
         _loc6_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc6_);
         _loc7_ = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc7_.setBread(FoodData.BREAD_RYE);
         _loc7_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc7_.setCookType(FoodData.COOK_MEDIUM);
         _loc7_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_SPOOKYSLAW,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_PHILLYSTEAK,FoodData.SAUCE_JACKOMOLE);
         _loc7_.setFries(FoodData.FRIES_REGULAR);
         _loc7_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc7_);
         _loc8_ = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc8_.setBread(FoodData.BREAD_PUMPKIN);
         _loc8_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc8_.setCookType(FoodData.COOK_MEDIUM);
         _loc8_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_STUFFING);
         _loc8_.setFries(FoodData.FRIES_REGULAR);
         _loc8_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc8_);
         _loc9_ = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc9_.setBread(FoodData.BREAD_RYE);
         _loc9_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc9_.setCookType(FoodData.COOK_MEDIUM);
         _loc9_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_CRANBERRY,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_MUSHROOMS);
         _loc9_.setFries(FoodData.FRIES_REGULAR);
         _loc9_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc9_);
         _loc10_ = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc10_.setBread(FoodData.BREAD_RYE);
         _loc10_.setCheese(FoodData.CHEESE_GRUYERE);
         _loc10_.setCookType(FoodData.COOK_MEDIUM);
         _loc10_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_PARMESAN,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_MUSHROOMS);
         _loc10_.setFries(FoodData.FRIES_REGULAR);
         _loc10_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc10_);
         _loc11_ = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc11_.setBread(FoodData.BREAD_RYE);
         _loc11_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc11_.setCookType(FoodData.COOK_MEDIUM);
         _loc11_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_SUNDRIEDTOMATOES,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_MUSHROOMS);
         _loc11_.setFries(FoodData.FRIES_REGULAR);
         _loc11_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc11_);
         _loc12_ = new CustomerOrder(GameData.MONTH_MARCH);
         _loc12_.setBread(FoodData.BREAD_BARMBRACK);
         _loc12_.setCheese(FoodData.CHEESE_SAGEDERBY);
         _loc12_.setCookType(FoodData.COOK_MEDIUM);
         _loc12_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_MUSHROOMS);
         _loc12_.setFries(FoodData.FRIES_REGULAR);
         _loc12_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc12_);
         _loc13_ = new CustomerOrder(GameData.MONTH_APRIL);
         _loc13_.setBread(FoodData.BREAD_RYE);
         _loc13_.setCheese(FoodData.CHEESE_SIRECZ);
         _loc13_.setCookType(FoodData.COOK_MEDIUM);
         _loc13_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_HOLLANDAISE,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_MUSHROOMS);
         _loc13_.setFries(FoodData.FRIES_REGULAR);
         _loc13_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc13_);
      }
   }
}


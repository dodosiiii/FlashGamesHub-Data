package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerChester extends CustomerDataFile
   {
      
      public function CustomerChester()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Chester";
         this.customerClipName = "Chester";
         this.customerFirstGame = "Papa\'s Cheeseria";
         this.thumbColor = "brown";
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
         _loc1_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc1_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_BACON,FoodData.SAUCE_BBQ,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PEPPERS);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc2_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_CHORIZO,FoodData.SAUCE_BBQ,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PEPPERS);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc2_);
         var _loc3_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc3_.setBread(FoodData.BREAD_HAWAIIAN);
         _loc3_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc3_.setCookType(FoodData.COOK_MEDIUM);
         _loc3_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_BBQ,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PINEAPPLE);
         _loc3_.setFries(FoodData.FRIES_CRINKLE);
         _loc3_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc3_);
         _loc4_ = new CustomerOrder(GameData.MONTH_JULY);
         _loc4_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc4_.setCheese(FoodData.CHEESE_SMOKEDCHEDDAR);
         _loc4_.setCookType(FoodData.COOK_MEDIUM);
         _loc4_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_PITSAUCE,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PEPPERS);
         _loc4_.setFries(FoodData.FRIES_CRINKLE);
         _loc4_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc4_);
         _loc5_ = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc5_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc5_.setCheese(FoodData.CHEESE_RICOTTA);
         _loc5_.setCookType(FoodData.COOK_MEDIUM);
         _loc5_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_MARINARA,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PEPPERS);
         _loc5_.setFries(FoodData.FRIES_CRINKLE);
         _loc5_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc5_);
         _loc6_ = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc6_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc6_.setCheese(FoodData.CHEESE_MAPLEJACK);
         _loc6_.setCookType(FoodData.COOK_MEDIUM);
         _loc6_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_SAUSAGE,FoodData.SAUCE_MAPLESYRUP,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PEPPERS);
         _loc6_.setFries(FoodData.FRIES_CRINKLE);
         _loc6_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc6_);
         _loc7_ = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc7_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc7_.setCheese(FoodData.CHEESE_MUENSTER);
         _loc7_.setCookType(FoodData.COOK_MEDIUM);
         _loc7_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_BBQ,FoodData.TOPPING_TOMATO,FoodData.SAUCE_JACKOMOLE);
         _loc7_.setFries(FoodData.FRIES_CRINKLE);
         _loc7_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc7_);
         _loc8_ = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc8_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc8_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc8_.setCookType(FoodData.COOK_MEDIUM);
         _loc8_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_GRAVY,FoodData.TOPPING_STUFFING,FoodData.TOPPING_PEPPERS);
         _loc8_.setFries(FoodData.FRIES_CRINKLE);
         _loc8_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc8_);
         _loc9_ = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc9_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc9_.setCheese(FoodData.CHEESE_GINGERSPICE);
         _loc9_.setCookType(FoodData.COOK_MEDIUM);
         _loc9_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_CRANBERRY,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PEPPERS);
         _loc9_.setFries(FoodData.FRIES_CRINKLE);
         _loc9_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc9_);
         _loc10_ = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc10_.setBread(FoodData.BREAD_CHEDDARSWIRL);
         _loc10_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc10_.setCookType(FoodData.COOK_MEDIUM);
         _loc10_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_PARMESAN,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PEPPERS);
         _loc10_.setFries(FoodData.FRIES_CRINKLE);
         _loc10_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc10_);
         _loc11_ = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc11_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc11_.setCheese(FoodData.CHEESE_REDWINDSOR);
         _loc11_.setCookType(FoodData.COOK_MEDIUM);
         _loc11_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_BBQ,FoodData.TOPPING_SUNDRIEDTOMATOES,FoodData.TOPPING_PEPPERS);
         _loc11_.setFries(FoodData.FRIES_CRINKLE);
         _loc11_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc11_);
         _loc12_ = new CustomerOrder(GameData.MONTH_MARCH);
         _loc12_.setBread(FoodData.BREAD_BARMBRACK);
         _loc12_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc12_.setCookType(FoodData.COOK_MEDIUM);
         _loc12_.addToppings(FoodData.TOPPING_BEEFHASH,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_BBQ,FoodData.TOPPING_PEPPERS,FoodData.SAUCE_IRISHPARSLEY);
         _loc12_.setFries(FoodData.FRIES_CRINKLE);
         _loc12_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc12_);
         _loc13_ = new CustomerOrder(GameData.MONTH_APRIL);
         _loc13_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc13_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc13_.setCookType(FoodData.COOK_MEDIUM);
         _loc13_.addToppings(FoodData.TOPPING_PICKLEDEGGS,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_BBQ,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PEPPERS);
         _loc13_.setFries(FoodData.FRIES_CRINKLE);
         _loc13_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc13_);
      }
   }
}


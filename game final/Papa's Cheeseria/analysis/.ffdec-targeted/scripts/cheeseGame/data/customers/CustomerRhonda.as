package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerRhonda extends CustomerDataFile
   {
      
      public function CustomerRhonda()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Rhonda";
         this.customerClipName = "Rhonda";
         this.customerFirstGame = "Papa\'s Cheeseria";
         this.thumbColor = "dustyblue";
         this.holidayOutfit = GameData.MONTH_OCTOBER;
         this.isCloser = true;
         this.isHuge = true;
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
         _loc1_.setBread(FoodData.BREAD_CIABATTA);
         _loc1_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_OLIVES,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_MUSTARD,FoodData.TOPPING_TOMATO);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_TORTILLA);
         _loc2_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_OLIVES,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_MUSTARD,FoodData.TOPPING_TOMATO,FoodData.SAUCE_GUACAMOLE);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
         var _loc3_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc3_.setBread(FoodData.BREAD_CIABATTA);
         _loc3_.setCheese(FoodData.CHEESE_MANGO);
         _loc3_.setCookType(FoodData.COOK_MEDIUM);
         _loc3_.addToppings(FoodData.TOPPING_PINEAPPLE,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_MUSTARD,FoodData.TOPPING_TOMATO);
         _loc3_.setFries(FoodData.FRIES_CURLY);
         _loc3_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc3_);
         _loc4_ = new CustomerOrder(GameData.MONTH_JULY);
         _loc4_.setBread(FoodData.BREAD_CIABATTA);
         _loc4_.setCheese(FoodData.CHEESE_SMOKEDCHEDDAR);
         _loc4_.setCookType(FoodData.COOK_MEDIUM);
         _loc4_.addToppings(FoodData.TOPPING_OLIVES,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_MUSTARD,FoodData.TOPPING_TOMATO,FoodData.SAUCE_PITSAUCE);
         _loc4_.setFries(FoodData.FRIES_CURLY);
         _loc4_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc4_);
         _loc5_ = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc5_.setBread(FoodData.BREAD_PEPPERONI);
         _loc5_.setCheese(FoodData.CHEESE_RICOTTA);
         _loc5_.setCookType(FoodData.COOK_MEDIUM);
         _loc5_.addToppings(FoodData.TOPPING_OLIVES,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_MARINARA,FoodData.TOPPING_TOMATO);
         _loc5_.setFries(FoodData.FRIES_CURLY);
         _loc5_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc5_);
         _loc6_ = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc6_.setBread(FoodData.BREAD_CIABATTA);
         _loc6_.setCheese(FoodData.CHEESE_MAPLEJACK);
         _loc6_.setCookType(FoodData.COOK_MEDIUM);
         _loc6_.addToppings(FoodData.TOPPING_OLIVES,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_MUSTARD,FoodData.TOPPING_TOMATO);
         _loc6_.setFries(FoodData.FRIES_CURLY);
         _loc6_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc6_);
         _loc7_ = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc7_.setBread(FoodData.BREAD_ECTOBREAD);
         _loc7_.setCheese(FoodData.CHEESE_MUENSTER);
         _loc7_.setCookType(FoodData.COOK_MEDIUM);
         _loc7_.addToppings(FoodData.TOPPING_OLIVES,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_MUSTARD,FoodData.TOPPING_TOMATO,FoodData.TOPPING_SPOOKYSLAW);
         _loc7_.setFries(FoodData.FRIES_CURLY);
         _loc7_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc7_);
         _loc8_ = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc8_.setBread(FoodData.BREAD_CIABATTA);
         _loc8_.setCheese(FoodData.CHEESE_CHEESEBALL);
         _loc8_.setCookType(FoodData.COOK_MEDIUM);
         _loc8_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.TOPPING_STUFFING,FoodData.SAUCE_GRAVY,FoodData.TOPPING_TOMATO);
         _loc8_.setFries(FoodData.FRIES_CURLY);
         _loc8_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc8_);
         _loc9_ = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc9_.setBread(FoodData.BREAD_CIABATTA);
         _loc9_.setCheese(FoodData.CHEESE_GINGERSPICE);
         _loc9_.setCookType(FoodData.COOK_MEDIUM);
         _loc9_.addToppings(FoodData.TOPPING_OLIVES,FoodData.TOPPING_GOOSE,FoodData.SAUCE_MUSTARD,FoodData.TOPPING_TOMATO);
         _loc9_.setFries(FoodData.FRIES_CURLY);
         _loc9_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc9_);
         _loc10_ = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc10_.setBread(FoodData.BREAD_CHEDDARSWIRL);
         _loc10_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc10_.setCookType(FoodData.COOK_MEDIUM);
         _loc10_.addToppings(FoodData.TOPPING_MACNCHEESE,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_HONEYMUSTARD,FoodData.TOPPING_TOMATO);
         _loc10_.setFries(FoodData.FRIES_CURLY);
         _loc10_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc10_);
         _loc11_ = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc11_.setBread(FoodData.BREAD_BEET);
         _loc11_.setCheese(FoodData.CHEESE_REDWINDSOR);
         _loc11_.setCookType(FoodData.COOK_MEDIUM);
         _loc11_.addToppings(FoodData.TOPPING_OLIVES,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_HONEYMUSTARD,FoodData.TOPPING_SUNDRIEDTOMATOES);
         _loc11_.setFries(FoodData.FRIES_CURLY);
         _loc11_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc11_);
         _loc12_ = new CustomerOrder(GameData.MONTH_MARCH);
         _loc12_.setBread(FoodData.BREAD_CIABATTA);
         _loc12_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc12_.setCookType(FoodData.COOK_MEDIUM);
         _loc12_.addToppings(FoodData.TOPPING_BEEFHASH,FoodData.SAUCE_IRISHPARSLEY,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_HONEYMUSTARD,FoodData.TOPPING_TOMATO);
         _loc12_.setFries(FoodData.FRIES_CURLY);
         _loc12_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc12_);
         _loc13_ = new CustomerOrder(GameData.MONTH_APRIL);
         _loc13_.setBread(FoodData.BREAD_CIABATTA);
         _loc13_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc13_.setCookType(FoodData.COOK_MEDIUM);
         _loc13_.addToppings(FoodData.TOPPING_OLIVES,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_HONEYMUSTARD,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PICKLEDEGGS);
         _loc13_.setFries(FoodData.FRIES_CURLY);
         _loc13_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc13_);
      }
   }
}


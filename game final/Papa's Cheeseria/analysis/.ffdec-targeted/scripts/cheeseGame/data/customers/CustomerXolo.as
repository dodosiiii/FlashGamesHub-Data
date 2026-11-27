package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerXolo extends CustomerDataFile
   {
      
      public function CustomerXolo()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Xolo";
         this.customerClipName = "Xolo";
         this.customerFirstGame = "Papa\'s Wingeria";
         this.thumbColor = "pink";
         this.isCloser = true;
         this.holidayOutfit = GameData.MONTH_OCTOBER;
         this.setupOrder();
         this.isHuge = true;
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
         _loc1_.setBread(FoodData.BREAD_THREECHEESE);
         _loc1_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.SAUCE_RANCH,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_BACON,FoodData.TOPPING_PICKLES,FoodData.SAUCE_KETCHUP);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_TORTILLA);
         _loc2_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.SAUCE_RANCH,FoodData.TOPPING_CHORIZO,FoodData.TOPPING_BACON,FoodData.SAUCE_GUACAMOLE,FoodData.SAUCE_KETCHUP);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc2_);
         var _loc3_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc3_.setBread(FoodData.BREAD_THREECHEESE);
         _loc3_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc3_.setCookType(FoodData.COOK_MEDIUM);
         _loc3_.addToppings(FoodData.SAUCE_RANCH,FoodData.TOPPING_PINEAPPLE,FoodData.TOPPING_BACON,FoodData.TOPPING_PICKLES,FoodData.SAUCE_CALYPSO);
         _loc3_.setFries(FoodData.FRIES_CURLY);
         _loc3_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc3_);
         _loc4_ = new CustomerOrder(GameData.MONTH_JULY);
         _loc4_.setBread(FoodData.BREAD_THREECHEESE);
         _loc4_.setCheese(FoodData.CHEESE_SMOKEDCHEDDAR);
         _loc4_.setCookType(FoodData.COOK_MEDIUM);
         _loc4_.addToppings(FoodData.SAUCE_RANCH,FoodData.TOPPING_BACON,FoodData.TOPPING_PICKLES,FoodData.SAUCE_PITSAUCE);
         _loc4_.setFries(FoodData.FRIES_CURLY);
         _loc4_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc4_);
         _loc5_ = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc5_.setBread(FoodData.BREAD_PEPPERONI);
         _loc5_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc5_.setCookType(FoodData.COOK_MEDIUM);
         _loc5_.addToppings(FoodData.SAUCE_RANCH,FoodData.TOPPING_MEATBALLS,FoodData.TOPPING_BACON,FoodData.SAUCE_MARINARA);
         _loc5_.setFries(FoodData.FRIES_CURLY);
         _loc5_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc5_);
         _loc6_ = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc6_.setBread(FoodData.BREAD_THREECHEESE);
         _loc6_.setCheese(FoodData.CHEESE_MAPLEJACK);
         _loc6_.setCookType(FoodData.COOK_MEDIUM);
         _loc6_.addToppings(FoodData.SAUCE_RANCH,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_BACON,FoodData.TOPPING_PICKLES,FoodData.SAUCE_KETCHUP);
         _loc6_.setFries(FoodData.FRIES_CURLY);
         _loc6_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc6_);
         _loc7_ = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc7_.setBread(FoodData.BREAD_THREECHEESE);
         _loc7_.setCheese(FoodData.CHEESE_MUENSTER);
         _loc7_.setCookType(FoodData.COOK_MEDIUM);
         _loc7_.addToppings(FoodData.SAUCE_RANCH,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_BACON,FoodData.TOPPING_PICKLES,FoodData.SAUCE_JACKOMOLE);
         _loc7_.setFries(FoodData.FRIES_CURLY);
         _loc7_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc7_);
         _loc8_ = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc8_.setBread(FoodData.BREAD_THREECHEESE);
         _loc8_.setCheese(FoodData.CHEESE_CHEESEBALL);
         _loc8_.setCookType(FoodData.COOK_MEDIUM);
         _loc8_.addToppings(FoodData.SAUCE_RANCH,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_BACON,FoodData.SAUCE_GRAVY);
         _loc8_.setFries(FoodData.FRIES_CURLY);
         _loc8_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc8_);
         _loc9_ = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc9_.setBread(FoodData.BREAD_FRUITCAKE);
         _loc9_.setCheese(FoodData.CHEESE_GINGERSPICE);
         _loc9_.setCookType(FoodData.COOK_MEDIUM);
         _loc9_.addToppings(FoodData.SAUCE_RANCH,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_BACON,FoodData.TOPPING_PICKLES,FoodData.SAUCE_KETCHUP);
         _loc9_.setFries(FoodData.FRIES_CURLY);
         _loc9_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc9_);
         _loc10_ = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc10_.setBread(FoodData.BREAD_THREECHEESE);
         _loc10_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc10_.setCookType(FoodData.COOK_MEDIUM);
         _loc10_.addToppings(FoodData.TOPPING_MACNCHEESE,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_BACON,FoodData.TOPPING_PICKLES,FoodData.SAUCE_KETCHUP);
         _loc10_.setFries(FoodData.FRIES_CURLY);
         _loc10_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc10_);
         _loc11_ = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc11_.setBread(FoodData.BREAD_THREECHEESE);
         _loc11_.setCheese(FoodData.CHEESE_REDWINDSOR);
         _loc11_.setCookType(FoodData.COOK_MEDIUM);
         _loc11_.addToppings(FoodData.SAUCE_RANCH,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_BACON,FoodData.TOPPING_PICKLES,FoodData.SAUCE_KETCHUP);
         _loc11_.setFries(FoodData.FRIES_CURLY);
         _loc11_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc11_);
         _loc12_ = new CustomerOrder(GameData.MONTH_MARCH);
         _loc12_.setBread(FoodData.BREAD_BARMBRACK);
         _loc12_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc12_.setCookType(FoodData.COOK_MEDIUM);
         _loc12_.addToppings(FoodData.SAUCE_IRISHPARSLEY,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_BACON,FoodData.TOPPING_PICKLES,FoodData.SAUCE_KETCHUP);
         _loc12_.setFries(FoodData.FRIES_CURLY);
         _loc12_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc12_);
         _loc13_ = new CustomerOrder(GameData.MONTH_APRIL);
         _loc13_.setBread(FoodData.BREAD_PASKA);
         _loc13_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc13_.setCookType(FoodData.COOK_MEDIUM);
         _loc13_.addToppings(FoodData.SAUCE_RANCH,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_BACON,FoodData.TOPPING_PICKLES,FoodData.SAUCE_HOLLANDAISE);
         _loc13_.setFries(FoodData.FRIES_CURLY);
         _loc13_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc13_);
      }
   }
}


package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerMindy extends CustomerDataFile
   {
      
      public function CustomerMindy()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Mindy";
         this.customerClipName = "Mindy";
         this.thumbColor = "seafoam";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 42;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_CIABATTA);
         _loc1_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_MUSHROOMS,FoodData.SAUCE_BALSAMIC,FoodData.TOPPING_PICKLES);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_APRIL);
         _loc2_.setBread(FoodData.BREAD_CIABATTA);
         _loc2_.setCheese(FoodData.CHEESE_SIRECZ);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_MUSHROOMS,FoodData.SAUCE_HOLLANDAISE,FoodData.TOPPING_PICKLES);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc2_);
      }
   }
}


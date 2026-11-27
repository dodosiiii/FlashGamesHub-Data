package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerGremmie extends CustomerDataFile
   {
      
      public function CustomerGremmie()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Gremmie";
         this.customerClipName = "Gremmie";
         this.customerFirstGame = "Papa\'s Freezeria";
         this.thumbColor = "yelloworange";
         this.flipdeckNumber = 123;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHEAT);
         _loc1_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_LOBSTER,FoodData.TOPPING_TOMATO,FoodData.TOPPING_LOBSTER);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc2_.setBread(FoodData.BREAD_WHEAT);
         _loc2_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_LOBSTER,FoodData.TOPPING_SPOOKYSLAW,FoodData.TOPPING_LOBSTER);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
      }
   }
}


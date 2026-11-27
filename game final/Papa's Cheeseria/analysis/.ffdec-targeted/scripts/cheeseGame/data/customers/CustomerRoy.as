package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerRoy extends CustomerDataFile
   {
      
      public function CustomerRoy()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Roy";
         this.customerClipName = "Roy";
         this.thumbColor = "lightred";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 16;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc1_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_TURKEY,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.SAUCE_RANCH);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JULY);
         _loc2_.setBread(FoodData.BREAD_TEXASTOAST);
         _loc2_.setCheese(FoodData.CHEESE_SMOKEDCHEDDAR);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_TURKEY,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.SAUCE_PITSAUCE);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


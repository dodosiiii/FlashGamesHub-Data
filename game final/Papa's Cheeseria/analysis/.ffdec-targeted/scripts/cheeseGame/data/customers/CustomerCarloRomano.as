package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerCarloRomano extends CustomerDataFile
   {
      
      public function CustomerCarloRomano()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Carlo Romano";
         this.customerClipName = "CarloRomano";
         this.thumbColor = "deepred";
         this.flipdeckNumber = 53;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FOCACCIA);
         _loc1_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_SALAMI,FoodData.TOPPING_HAM,FoodData.TOPPING_TOMATO,FoodData.SAUCE_RANCH);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc2_.setBread(FoodData.BREAD_FOCACCIA);
         _loc2_.setCheese(FoodData.CHEESE_RICOTTA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_SALAMI,FoodData.TOPPING_HAM,FoodData.TOPPING_TOMATO,FoodData.SAUCE_RANCH);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
      }
   }
}


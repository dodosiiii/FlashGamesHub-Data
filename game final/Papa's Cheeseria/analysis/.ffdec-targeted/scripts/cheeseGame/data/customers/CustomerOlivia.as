package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerOlivia extends CustomerDataFile
   {
      
      public function CustomerOlivia()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Olivia";
         this.customerClipName = "Olivia";
         this.thumbColor = "lime";
         this.customerFirstGame = "Papa\'s Pastaria";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PRETZEL);
         _loc1_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_TOMATO,FoodData.TOPPING_OLIVES,FoodData.SAUCE_RANCH);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.SAUCE_RANCH,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_APRIL);
         _loc2_.setBread(FoodData.BREAD_PRETZEL);
         _loc2_.setCheese(FoodData.CHEESE_SIRECZ);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_TOMATO,FoodData.TOPPING_OLIVES,FoodData.SAUCE_RANCH);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.SAUCE_RANCH,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc2_);
      }
   }
}


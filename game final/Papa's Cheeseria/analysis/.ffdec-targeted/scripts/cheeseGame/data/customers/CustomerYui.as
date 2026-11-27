package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerYui extends CustomerDataFile
   {
      
      public function CustomerYui()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Yui";
         this.customerClipName = "Yui";
         this.customerFirstGame = "Papa Louie 3";
         this.thumbColor = "brown";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_RYE);
         _loc1_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_HAM,FoodData.TOPPING_BACON);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_BACON,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc2_.setBread(FoodData.BREAD_RYE);
         _loc2_.setCheese(FoodData.CHEESE_MUENSTER);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_HAM,FoodData.TOPPING_BACON,FoodData.SAUCE_JACKOMOLE);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_BACON,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
      }
   }
}


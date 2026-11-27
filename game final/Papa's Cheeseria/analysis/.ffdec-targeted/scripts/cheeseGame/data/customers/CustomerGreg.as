package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerGreg extends CustomerDataFile
   {
      
      public function CustomerGreg()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Greg";
         this.customerClipName = "Greg";
         this.customerFirstGame = "Papa Louie";
         this.thumbColor = "lime";
         this.flipdeckNumber = 23;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHITE);
         _loc1_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_TOMATO,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_TOMATO,FoodData.SAUCE_KETCHUP);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.SAUCE_KETCHUP);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc2_.setBread(FoodData.BREAD_BEET);
         _loc2_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_SUNDRIEDTOMATOES,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_TOMATO,FoodData.SAUCE_KETCHUP,FoodData.TOPPING_SUNDRIEDTOMATOES);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.SAUCE_KETCHUP);
         this.addCustomerOrder(_loc2_);
      }
   }
}


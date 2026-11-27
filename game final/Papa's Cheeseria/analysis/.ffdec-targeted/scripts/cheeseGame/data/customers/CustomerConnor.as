package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerConnor extends CustomerDataFile
   {
      
      public function CustomerConnor()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Connor";
         this.customerClipName = "Connor";
         this.customerFirstGame = "Papa\'s Burgeria";
         this.thumbColor = "skyblue";
         this.flipdeckNumber = 69;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PRETZEL);
         _loc1_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.TOPPING_JALAPENOS,FoodData.SAUCE_AWESOME);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.TOPPING_JALAPENOS,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc2_.setBread(FoodData.BREAD_PEPPERONI);
         _loc2_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.TOPPING_JALAPENOS,FoodData.SAUCE_MARINARA);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.TOPPING_JALAPENOS,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc2_);
      }
   }
}


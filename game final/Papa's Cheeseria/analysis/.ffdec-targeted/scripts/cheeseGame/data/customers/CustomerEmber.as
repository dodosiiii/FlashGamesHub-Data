package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerEmber extends CustomerDataFile
   {
      
      public function CustomerEmber()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Ember";
         this.customerClipName = "Ember";
         this.customerFirstGame = "Papa\'s Donuteria";
         this.thumbColor = "fire";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHEAT);
         _loc1_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_TOMATO);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JULY);
         _loc2_.setBread(FoodData.BREAD_WHEAT);
         _loc2_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_BEEFBRISKET,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_TOMATO);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc2_);
      }
   }
}


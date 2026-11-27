package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerCrystal extends CustomerDataFile
   {
      
      public function CustomerCrystal()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Crystal";
         this.customerClipName = "Crystal";
         this.thumbColor = "midred";
         this.customerFirstGame = "Papa\'s Pastaria";
         this.flipdeckNumber = 121;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_THREECHEESE);
         _loc1_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.SAUCE_WILDONION,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_TOMATO,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc2_.setBread(FoodData.BREAD_THREECHEESE);
         _loc2_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.SAUCE_WILDONION,FoodData.TOPPING_GOOSE,FoodData.TOPPING_TOMATO,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


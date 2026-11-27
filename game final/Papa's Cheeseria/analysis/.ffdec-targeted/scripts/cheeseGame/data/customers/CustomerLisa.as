package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerLisa extends CustomerDataFile
   {
      
      public function CustomerLisa()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Lisa";
         this.customerClipName = "Lisa";
         this.customerFirstGame = "Papa\'s Burgeria";
         this.thumbColor = "lime";
         this.flipdeckNumber = 125;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc1_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BBQ);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JULY);
         _loc2_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc2_.setCheese(FoodData.CHEESE_SMOKEDCHEDDAR);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_PITSAUCE);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


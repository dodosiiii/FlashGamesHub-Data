package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerAustin extends CustomerDataFile
   {
      
      public function CustomerAustin()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Austin";
         this.customerClipName = "Austin";
         this.customerFirstGame = "Papa\'s Cheeseria";
         this.thumbColor = "yelloworange";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHITE);
         _loc1_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.SAUCE_AWESOME);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.SAUCE_AWESOME,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc2_.setBread(FoodData.BREAD_WHITE);
         _loc2_.setCheese(FoodData.CHEESE_CHEESEBALL);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.SAUCE_AWESOME);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.SAUCE_AWESOME,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


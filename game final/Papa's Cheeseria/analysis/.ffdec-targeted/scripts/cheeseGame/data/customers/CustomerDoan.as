package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerDoan extends CustomerDataFile
   {
      
      public function CustomerDoan()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Doan";
         this.customerClipName = "Doan";
         this.customerFirstGame = "Papa\'s Burgeria";
         this.thumbColor = "midblue";
         this.flipdeckNumber = 37;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc1_.setCheese(FoodData.CHEESE_SWISS);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.TOPPING_TOMATO,FoodData.SAUCE_RANCH);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc2_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc2_.setCheese(FoodData.CHEESE_RICOTTA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.SAUCE_MARINARA,FoodData.TOPPING_MEATBALLS,FoodData.TOPPING_TOMATO,FoodData.SAUCE_RANCH);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
      }
   }
}


package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerMarty extends CustomerDataFile
   {
      
      public function CustomerMarty()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Marty";
         this.customerClipName = "Marty";
         this.thumbColor = "midred";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 25;
         this.holidayOutfit = GameData.MONTH_JULY;
         this.holidayHandExtra = "spatula";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHITE);
         _loc1_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_TOMATO,FoodData.TOPPING_BACON);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JULY);
         _loc2_.setBread(FoodData.BREAD_TEXASTOAST);
         _loc2_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_TOMATO,FoodData.TOPPING_BEEFBRISKET);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc2_);
      }
   }
}


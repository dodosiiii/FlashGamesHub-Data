package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerMary extends CustomerDataFile
   {
      
      public function CustomerMary()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Mary";
         this.customerClipName = "Mary";
         this.thumbColor = "seafoam";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 131;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_RYE);
         _loc1_.setCheese(FoodData.CHEESE_COLBY);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_TOMATO,FoodData.SAUCE_WILDONION);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.SAUCE_KETCHUP);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc2_.setBread(FoodData.BREAD_PUMPKIN);
         _loc2_.setCheese(FoodData.CHEESE_COLBY);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_TOMATO,FoodData.SAUCE_WILDONION);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.SAUCE_KETCHUP);
         this.addCustomerOrder(_loc2_);
      }
   }
}


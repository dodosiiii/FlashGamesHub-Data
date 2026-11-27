package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerVicky extends CustomerDataFile
   {
      
      public function CustomerVicky()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Vicky";
         this.customerClipName = "Vicky";
         this.customerFirstGame = "Papa\'s Burgeria";
         this.thumbColor = "skyblue";
         this.flipdeckNumber = 102;
         this.setupOrder();
         this.isHuge = true;
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc1_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_SALAMI,FoodData.TOPPING_HAM,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_TOMATO,FoodData.SAUCE_WILDONION);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_APRIL);
         _loc2_.setBread(FoodData.BREAD_PASKA);
         _loc2_.setCheese(FoodData.CHEESE_SIRECZ);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_SALAMI,FoodData.TOPPING_HAM,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_TOMATO,FoodData.SAUCE_WILDONION);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


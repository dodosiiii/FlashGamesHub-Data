package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerKahuna extends CustomerDataFile
   {
      
      public function CustomerKahuna()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Kahuna";
         this.customerClipName = "Kahuna";
         this.customerFirstGame = "Papa\'s Freezeria";
         this.thumbColor = "yelloworange";
         this.flipdeckNumber = 36;
         this.setupOrder();
         this.isHuge = true;
         this.holidayOutfit = GameData.MONTH_JUNE;
         this.holidayHandExtra = "ukelele";
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHITE);
         _loc1_.setCheese(FoodData.CHEESE_COLBY);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_TOMATO,FoodData.TOPPING_HAM,FoodData.TOPPING_TOMATO);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc2_.setBread(FoodData.BREAD_HAWAIIAN);
         _loc2_.setCheese(FoodData.CHEESE_COLBY);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_PINEAPPLE,FoodData.TOPPING_HAM,FoodData.TOPPING_PINEAPPLE);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc2_);
      }
   }
}


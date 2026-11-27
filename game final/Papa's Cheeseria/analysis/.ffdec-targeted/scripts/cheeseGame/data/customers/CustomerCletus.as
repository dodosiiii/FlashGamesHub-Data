package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerCletus extends CustomerDataFile
   {
      
      public function CustomerCletus()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Cletus";
         this.customerClipName = "Cletus";
         this.customerFirstGame = "Papa\'s Burgeria";
         this.thumbColor = "brown";
         this.flipdeckNumber = 118;
         this.holidayOutfit = GameData.MONTH_APRIL;
         this.hasHolidayHands = true;
         this.holidayHandExtra = "carrot";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FOCACCIA);
         _loc1_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_ONIONS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BALSAMIC);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_POUTINE,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_APRIL);
         _loc2_.setBread(FoodData.BREAD_PASKA);
         _loc2_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_ONIONS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BALSAMIC);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_POUTINE,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


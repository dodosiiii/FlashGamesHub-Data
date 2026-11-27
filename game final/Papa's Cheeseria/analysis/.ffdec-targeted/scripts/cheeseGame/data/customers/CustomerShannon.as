package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerShannon extends CustomerDataFile
   {
      
      public function CustomerShannon()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Shannon";
         this.customerClipName = "Shannon";
         this.thumbColor = "skyblue";
         this.customerFirstGame = "Papa\'s Hot Doggeria";
         this.flipdeckNumber = 77;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PRETZEL);
         _loc1_.setCheese(FoodData.CHEESE_COLBY);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_SAUERKRAUT,FoodData.TOPPING_CORNEDBEEF,FoodData.SAUCE_AWESOME,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_ONIONS);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHILI);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MARCH);
         _loc2_.setBread(FoodData.BREAD_PRETZEL);
         _loc2_.setCheese(FoodData.CHEESE_COLBY);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_SAUERKRAUT,FoodData.TOPPING_BEEFHASH,FoodData.SAUCE_AWESOME,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_ONIONS);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHILI);
         this.addCustomerOrder(_loc2_);
      }
   }
}


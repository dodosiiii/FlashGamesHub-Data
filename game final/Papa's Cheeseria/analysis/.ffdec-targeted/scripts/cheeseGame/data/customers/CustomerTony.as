package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerTony extends CustomerDataFile
   {
      
      public function CustomerTony()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Tony";
         this.customerClipName = "Tony";
         this.customerFirstGame = "Papa\'s Burgeria";
         this.thumbColor = "flipline";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_RYE);
         _loc1_.setCheese(FoodData.CHEESE_SWISS);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_SAUERKRAUT,FoodData.TOPPING_CORNEDBEEF,FoodData.SAUCE_AWESOME);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MARCH);
         _loc2_.setBread(FoodData.BREAD_RYE);
         _loc2_.setCheese(FoodData.CHEESE_SWISS);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_BEEFHASH,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_SAUERKRAUT,FoodData.TOPPING_CORNEDBEEF,FoodData.SAUCE_IRISHPARSLEY);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc2_);
      }
   }
}


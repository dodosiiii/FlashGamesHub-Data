package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerZoe extends CustomerDataFile
   {
      
      public function CustomerZoe()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Zoe";
         this.customerClipName = "Zoe";
         this.customerFirstGame = "Papa\'s Taco Mia!";
         this.thumbColor = "yellow";
         this.flipdeckNumber = 65;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FLATBREAD);
         _loc1_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_SOUTHWEST);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc2_.setBread(FoodData.BREAD_FLATBREAD);
         _loc2_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.TOPPING_SAUSAGE,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_SOUTHWEST);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY);
         this.addCustomerOrder(_loc2_);
      }
   }
}


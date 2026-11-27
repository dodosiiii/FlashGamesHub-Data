package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerIvy extends CustomerDataFile
   {
      
      public function CustomerIvy()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Ivy";
         this.customerClipName = "Ivy";
         this.customerFirstGame = "Papa\'s Freezeria";
         this.thumbColor = "yelloworange";
         this.flipdeckNumber = 129;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_RYE);
         _loc1_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_TOMATO,FoodData.TOPPING_BACON);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_BACON,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_TORTILLA);
         _loc2_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_PEPPERS,FoodData.SAUCE_GUACAMOLE,FoodData.TOPPING_TOMATO,FoodData.TOPPING_BACON);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_BACON,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc2_);
      }
   }
}


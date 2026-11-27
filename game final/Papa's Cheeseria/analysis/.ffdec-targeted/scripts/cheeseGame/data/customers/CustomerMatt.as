package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerMatt extends CustomerDataFile
   {
      
      public function CustomerMatt()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Matt";
         this.customerClipName = "Matt";
         this.customerFirstGame = "Papa\'s Burgeria";
         this.thumbColor = "flipline";
         this.flipdeckNumber = 84;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc1_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_BBQ,FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_ONIONS,FoodData.TOPPING_JALAPENOS);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JULY);
         _loc2_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc2_.setCheese(FoodData.CHEESE_SMOKEDCHEDDAR);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_BEEFBRISKET,FoodData.SAUCE_PITSAUCE,FoodData.TOPPING_BEEFBRISKET,FoodData.TOPPING_ONIONS,FoodData.TOPPING_JALAPENOS);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc2_);
      }
   }
}


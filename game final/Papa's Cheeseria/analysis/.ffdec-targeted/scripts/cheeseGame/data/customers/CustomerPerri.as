package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerPerri extends CustomerDataFile
   {
      
      public function CustomerPerri()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Perri";
         this.customerClipName = "Perri";
         this.customerFirstGame = "Papa\'s Cheeseria";
         this.thumbColor = "seafoam";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_CIABATTA);
         _loc1_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_LOBSTER,FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.SAUCE_SOUTHWEST);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHILI);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc2_.setBread(FoodData.BREAD_CIABATTA);
         _loc2_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_LOBSTER,FoodData.TOPPING_MACNCHEESE,FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_SOUTHWEST);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_CHILI);
         this.addCustomerOrder(_loc2_);
      }
   }
}


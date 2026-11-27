package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerWillow extends CustomerDataFile
   {
      
      public function CustomerWillow()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Willow";
         this.customerClipName = "Willow";
         this.thumbColor = "seafoam";
         this.customerFirstGame = "Papa\'s Hot Doggeria";
         this.flipdeckNumber = 108;
         this.setupOrder();
         this.holidayOutfit = GameData.MONTH_OCTOBER;
         this.hasHolidayMouth = true;
         this.holidayHandExtra = "skullpail";
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_RYE);
         _loc1_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_OLIVES,FoodData.TOPPING_BACON,FoodData.SAUCE_KETCHUP,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_LOBSTER);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc2_.setBread(FoodData.BREAD_ECTOBREAD);
         _loc2_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_SPOOKYSLAW,FoodData.TOPPING_BACON,FoodData.SAUCE_KETCHUP,FoodData.TOPPING_SPOOKYSLAW,FoodData.TOPPING_LOBSTER);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
      }
   }
}


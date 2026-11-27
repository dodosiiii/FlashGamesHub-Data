package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerJulep extends CustomerDataFile
   {
      
      public function CustomerJulep()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Julep";
         this.customerClipName = "Julep";
         this.customerFirstGame = "Papa\'s Donuteria";
         this.thumbColor = "seafoam";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc1_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.TOPPING_OLIVES,FoodData.TOPPING_PICKLES);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MARCH);
         _loc2_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc2_.setCheese(FoodData.CHEESE_SAGEDERBY);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.TOPPING_OLIVES,FoodData.TOPPING_BEEFHASH);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc2_);
      }
   }
}


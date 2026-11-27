package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerClover extends CustomerDataFile
   {
      
      public function CustomerClover()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Clover";
         this.customerClipName = "Clover";
         this.thumbColor = "seafoam";
         this.flipdeckNumber = 57;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_RYE);
         _loc1_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.SAUCE_HONEYMUSTARD,FoodData.TOPPING_BACON,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BALSAMIC);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc2_.setBread(FoodData.BREAD_FRUITCAKE);
         _loc2_.setCheese(FoodData.CHEESE_GINGERSPICE);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.SAUCE_CRANBERRY,FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_CRANBERRY);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc2_);
      }
   }
}


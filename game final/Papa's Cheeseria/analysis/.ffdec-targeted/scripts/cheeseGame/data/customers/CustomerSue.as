package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerSue extends CustomerDataFile
   {
      
      public function CustomerSue()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Sue";
         this.customerClipName = "Sue";
         this.thumbColor = "dustyblue";
         this.customerFirstGame = "Papa Louie";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FLATBREAD);
         _loc1_.setCheese(FoodData.CHEESE_COLBY);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_TOMATO,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BALSAMIC);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.SAUCE_BBQ);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc2_.setBread(FoodData.BREAD_FLATBREAD);
         _loc2_.setCheese(FoodData.CHEESE_REDWINDSOR);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_SUNDRIEDTOMATOES,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_STRAWBERRY);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.SAUCE_BBQ);
         this.addCustomerOrder(_loc2_);
      }
   }
}


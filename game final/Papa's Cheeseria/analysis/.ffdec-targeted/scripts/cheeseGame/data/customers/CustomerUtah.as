package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerUtah extends CustomerDataFile
   {
      
      public function CustomerUtah()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Utah";
         this.customerClipName = "Utah";
         this.customerFirstGame = "Papa\'s Freezeria";
         this.thumbColor = "yelloworange";
         this.flipdeckNumber = 71;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc1_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_BACON,FoodData.SAUCE_BALSAMIC,FoodData.TOPPING_TOMATO,FoodData.TOPPING_LOBSTER);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc2_.setBread(FoodData.BREAD_BEET);
         _loc2_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_BACON,FoodData.SAUCE_BALSAMIC,FoodData.TOPPING_SUNDRIEDTOMATOES,FoodData.TOPPING_LOBSTER);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc2_);
      }
   }
}


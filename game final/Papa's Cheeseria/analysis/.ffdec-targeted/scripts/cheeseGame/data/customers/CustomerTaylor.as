package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerTaylor extends CustomerDataFile
   {
      
      public function CustomerTaylor()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Taylor";
         this.customerClipName = "Taylor";
         this.thumbColor = "midred";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 92;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FOCACCIA);
         _loc1_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_TURKEY,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_BACON,FoodData.SAUCE_MUSTARD,FoodData.TOPPING_MUSHROOMS);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc2_.setBread(FoodData.BREAD_FOCACCIA);
         _loc2_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_TURKEY,FoodData.TOPPING_STUFFING,FoodData.TOPPING_BACON,FoodData.TOPPING_MUSHROOMS);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


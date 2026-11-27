package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerRita extends CustomerDataFile
   {
      
      public function CustomerRita()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Rita";
         this.customerClipName = "Rita";
         this.thumbColor = "lime";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 75;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FLATBREAD);
         _loc1_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BUFFALO);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc2_.setBread(FoodData.BREAD_BEET);
         _loc2_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_STRAWBERRY);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


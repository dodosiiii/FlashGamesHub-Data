package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerIggy extends CustomerDataFile
   {
      
      public function CustomerIggy()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Iggy";
         this.customerClipName = "Iggy";
         this.customerFirstGame = "Papa\'s Donuteria";
         this.thumbColor = "purple";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_THREECHEESE);
         _loc1_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_SALAMI,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_OLIVES,FoodData.SAUCE_WILDONION);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.SAUCE_AWESOME,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc2_.setBread(FoodData.BREAD_THREECHEESE);
         _loc2_.setCheese(FoodData.CHEESE_GRUYERE);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_SALAMI,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_OLIVES,FoodData.SAUCE_PARMESAN);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.SAUCE_AWESOME,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc2_);
      }
   }
}


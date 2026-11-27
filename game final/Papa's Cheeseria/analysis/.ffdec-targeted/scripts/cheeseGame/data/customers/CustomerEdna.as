package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerEdna extends CustomerDataFile
   {
      
      public function CustomerEdna()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Edna";
         this.customerClipName = "Edna";
         this.customerFirstGame = "Papa\'s Burgeria";
         this.thumbColor = "fire";
         this.flipdeckNumber = 100;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHEAT);
         _loc1_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_ONIONS,FoodData.TOPPING_PULLEDPORK);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc2_.setBread(FoodData.BREAD_WHEAT);
         _loc2_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_ONIONS,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_GRAVY);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc2_);
      }
   }
}


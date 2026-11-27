package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerWally extends CustomerDataFile
   {
      
      public function CustomerWally()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Wally";
         this.customerClipName = "Wally";
         this.thumbColor = "brown";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 2;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc1_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_ONIONS,FoodData.TOPPING_CORNEDBEEF);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.SAUCE_RANCH,FoodData.FRYSAUCE_SOURCREAM);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc2_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc2_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_ONIONS,FoodData.TOPPING_CORNEDBEEF,FoodData.SAUCE_CRANBERRY);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.SAUCE_RANCH,FoodData.FRYSAUCE_SOURCREAM);
         this.addCustomerOrder(_loc2_);
      }
   }
}


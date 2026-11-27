package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerNinjoy extends CustomerDataFile
   {
      
      public function CustomerNinjoy()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Ninjoy";
         this.customerClipName = "Ninjoy";
         this.customerFirstGame = "Papa\'s Freezeria";
         this.thumbColor = "yelloworange";
         this.flipdeckNumber = 120;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc1_.setCheese(FoodData.CHEESE_SWISS);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_ONIONS,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_LOBSTER,FoodData.SAUCE_RANCH);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_SOURCREAM,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc2_.setBread(FoodData.BREAD_ECTOBREAD);
         _loc2_.setCheese(FoodData.CHEESE_SWISS);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_ONIONS,FoodData.TOPPING_SPOOKYSLAW,FoodData.TOPPING_LOBSTER,FoodData.SAUCE_JACKOMOLE);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_SOURCREAM,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


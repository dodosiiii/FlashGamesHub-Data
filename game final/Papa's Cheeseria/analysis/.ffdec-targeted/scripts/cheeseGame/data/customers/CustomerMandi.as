package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerMandi extends CustomerDataFile
   {
      
      public function CustomerMandi()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Mandi";
         this.customerClipName = "Mandi";
         this.thumbColor = "pink";
         this.customerFirstGame = "Papa\'s Pizzeria";
         this.flipdeckNumber = 110;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FLATBREAD);
         _loc1_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_ONIONS,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PICKLES,FoodData.SAUCE_SOUTHWEST);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.SAUCE_RANCH,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc2_.setBread(FoodData.BREAD_FLATBREAD);
         _loc2_.setCheese(FoodData.CHEESE_MUENSTER);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_ONIONS,FoodData.TOPPING_TOMATO,FoodData.TOPPING_SPOOKYSLAW,FoodData.SAUCE_SOUTHWEST);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.SAUCE_RANCH,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc2_);
      }
   }
}


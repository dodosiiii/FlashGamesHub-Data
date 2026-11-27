package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerHackyZak extends CustomerDataFile
   {
      
      public function CustomerHackyZak()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Hacky Zak";
         this.customerClipName = "HackyZak";
         this.customerFirstGame = "Papa\'s Donuteria";
         this.thumbColor = "lime";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FLATBREAD);
         _loc1_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.SAUCE_HONEYMUSTARD,FoodData.TOPPING_BACON);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc2_.setBread(FoodData.BREAD_FLATBREAD);
         _loc2_.setCheese(FoodData.CHEESE_MANGO);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.SAUCE_CALYPSO,FoodData.TOPPING_BACON,FoodData.TOPPING_PINEAPPLE);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


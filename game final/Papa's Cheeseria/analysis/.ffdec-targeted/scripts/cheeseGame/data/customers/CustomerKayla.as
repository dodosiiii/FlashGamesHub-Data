package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerKayla extends CustomerDataFile
   {
      
      public function CustomerKayla()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Kayla";
         this.customerClipName = "Kayla";
         this.customerFirstGame = "Papa\'s Burgeria";
         this.thumbColor = "yelloworange";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FOCACCIA);
         _loc1_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_LOBSTER,FoodData.SAUCE_RANCH,FoodData.TOPPING_LOBSTER);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc2_.setBread(FoodData.BREAD_FOCACCIA);
         _loc2_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_LOBSTER,FoodData.SAUCE_PARMESAN,FoodData.TOPPING_MACNCHEESE,FoodData.TOPPING_LOBSTER);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc2_);
      }
   }
}


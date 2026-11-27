package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerAkari extends CustomerDataFile
   {
      
      public function CustomerAkari()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Akari";
         this.customerClipName = "Akari";
         this.customerFirstGame = "Papa\'s Burgeria";
         this.thumbColor = "yellow";
         this.flipdeckNumber = 50;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc1_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_TOMATO,FoodData.SAUCE_RANCH);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MARCH);
         _loc2_.setBread(FoodData.BREAD_BARMBRACK);
         _loc2_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.SAUCE_IRISHPARSLEY,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_TOMATO,FoodData.SAUCE_RANCH);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
      }
   }
}


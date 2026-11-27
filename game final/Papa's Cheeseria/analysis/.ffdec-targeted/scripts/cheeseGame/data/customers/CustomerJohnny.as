package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerJohnny extends CustomerDataFile
   {
      
      public function CustomerJohnny()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Johnny";
         this.customerClipName = "Johnny";
         this.customerFirstGame = "Papa\'s Pancakeria";
         this.thumbColor = "dustyblue";
         this.flipdeckNumber = 55;
         this.holidayOutfit = GameData.MONTH_SEPTEMBER;
         this.holidayHandExtra = "bacon";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHEAT);
         _loc1_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_SALAMI,FoodData.TOPPING_BACON,FoodData.TOPPING_SAUERKRAUT,FoodData.SAUCE_MUSTARD);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc2_.setBread(FoodData.BREAD_WHEAT);
         _loc2_.setCheese(FoodData.CHEESE_MAPLEJACK);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_SAUSAGE,FoodData.TOPPING_BACON,FoodData.SAUCE_MAPLESYRUP);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


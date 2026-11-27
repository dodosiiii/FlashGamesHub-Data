package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerBoomer extends CustomerDataFile
   {
      
      public function CustomerBoomer()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Boomer";
         this.customerClipName = "Boomer";
         this.thumbColor = "lightred";
         this.customerFirstGame = "Papa\'s Wingeria";
         this.flipdeckNumber = 44;
         this.holidayOutfit = GameData.MONTH_JULY;
         this.holidayHandExtra = "sparkler";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_RYE);
         _loc1_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.SAUCE_BBQ,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_BBQ);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JULY);
         _loc2_.setBread(FoodData.BREAD_RYE);
         _loc2_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.SAUCE_PITSAUCE,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_PITSAUCE);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


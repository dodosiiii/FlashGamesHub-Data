package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerGeorgito extends CustomerDataFile
   {
      
      public function CustomerGeorgito()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Georgito";
         this.customerClipName = "Georgito";
         this.customerFirstGame = "Papa\'s Taco Mia!";
         this.thumbColor = "emerald";
         this.flipdeckNumber = 40;
         this.holidayOutfit = GameData.MONTH_MARCH;
         this.holidayHandExtra = "horseshoe";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc1_.setCheese(FoodData.CHEESE_SWISS);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_SAUERKRAUT,FoodData.TOPPING_CORNEDBEEF,FoodData.SAUCE_MUSTARD);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.SAUCE_AWESOME,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MARCH);
         _loc2_.setBread(FoodData.BREAD_BARMBRACK);
         _loc2_.setCheese(FoodData.CHEESE_SWISS);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_BEEFHASH,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_SAUERKRAUT,FoodData.SAUCE_MUSTARD);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.SAUCE_AWESOME,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc2_);
      }
   }
}


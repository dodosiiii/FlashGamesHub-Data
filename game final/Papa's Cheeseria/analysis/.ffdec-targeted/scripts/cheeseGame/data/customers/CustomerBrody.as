package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerBrody extends CustomerDataFile
   {
      
      public function CustomerBrody()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Brody";
         this.customerClipName = "Brody";
         this.customerFirstGame = "Papa\'s Cheeseria";
         this.thumbColor = "seafoam";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHITE);
         _loc1_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.SAUCE_KETCHUP,FoodData.TOPPING_FRIEDEGG);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc2_.setBread(FoodData.BREAD_CINNAMON);
         _loc2_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.SAUCE_MAPLESYRUP,FoodData.TOPPING_FRIEDEGG);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerCaptainCori extends CustomerDataFile
   {
      
      public function CustomerCaptainCori()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Captain Cori";
         this.customerClipName = "CaptainCori";
         this.customerFirstGame = "Papa\'s Freezeria";
         this.thumbColor = "yelloworange";
         this.flipdeckNumber = 17;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc1_.setCheese(FoodData.CHEESE_SWISS);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_PEPPERS,FoodData.SAUCE_RANCH);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.SAUCE_RANCH,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc2_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc2_.setCheese(FoodData.CHEESE_SWISS);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_CALYPSO,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_PEPPERS,FoodData.SAUCE_RANCH);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.SAUCE_RANCH,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


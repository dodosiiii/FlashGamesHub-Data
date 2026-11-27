package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerChuck extends CustomerDataFile
   {
      
      public function CustomerChuck()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Chuck";
         this.customerClipName = "Chuck";
         this.thumbColor = "yellow";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 112;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHITE);
         _loc1_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_BBQ,FoodData.TOPPING_BACON);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc2_.setBread(FoodData.BREAD_HAWAIIAN);
         _loc2_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.SAUCE_BBQ,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_BBQ,FoodData.TOPPING_BACON,FoodData.TOPPING_PINEAPPLE);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.SAUCE_BBQ,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


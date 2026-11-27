package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerYippy extends CustomerDataFile
   {
      
      public function CustomerYippy()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Yippy";
         this.customerClipName = "Yippy";
         this.thumbColor = "lime";
         this.customerFirstGame = "Papa\'s Pancakeria";
         this.flipdeckNumber = 34;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHITE);
         _loc1_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.SAUCE_HONEYMUSTARD,FoodData.TOPPING_PICKLES);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.SAUCE_KETCHUP);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc2_.setBread(FoodData.BREAD_BEET);
         _loc2_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.SAUCE_HONEYMUSTARD,FoodData.TOPPING_PICKLES);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.SAUCE_KETCHUP);
         this.addCustomerOrder(_loc2_);
      }
   }
}


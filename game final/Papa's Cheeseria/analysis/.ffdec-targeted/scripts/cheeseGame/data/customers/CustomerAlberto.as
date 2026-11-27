package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerAlberto extends CustomerDataFile
   {
      
      public function CustomerAlberto()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Alberto";
         this.customerClipName = "Alberto";
         this.thumbColor = "lime";
         this.customerFirstGame = "Papa\'s Burgeria";
         this.flipdeckNumber = 88;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_THREECHEESE);
         _loc1_.setCheese(FoodData.CHEESE_COLBY);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_BBQ,FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.SAUCE_BBQ);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc2_.setBread(FoodData.BREAD_HAWAIIAN);
         _loc2_.setCheese(FoodData.CHEESE_COLBY);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_CALYPSO,FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.SAUCE_BBQ);
         this.addCustomerOrder(_loc2_);
      }
   }
}


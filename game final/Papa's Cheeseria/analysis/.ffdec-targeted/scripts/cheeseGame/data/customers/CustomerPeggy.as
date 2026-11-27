package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerPeggy extends CustomerDataFile
   {
      
      public function CustomerPeggy()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Peggy";
         this.customerClipName = "Peggy";
         this.thumbColor = "skyblue";
         this.flipdeckNumber = 90;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FLATBREAD);
         _loc1_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_LETTUCE);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_FLATBREAD);
         _loc2_.setCheese(FoodData.CHEESE_OAXACA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_LETTUCE);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc2_);
      }
   }
}


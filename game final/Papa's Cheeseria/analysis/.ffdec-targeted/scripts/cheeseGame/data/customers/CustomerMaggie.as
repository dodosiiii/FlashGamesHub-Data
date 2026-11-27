package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerMaggie extends CustomerDataFile
   {
      
      public function CustomerMaggie()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Maggie";
         this.customerClipName = "Maggie";
         this.thumbColor = "yelloworange";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 104;
         this.holidayOutfit = GameData.MONTH_MAY;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FLATBREAD);
         _loc1_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_TOMATO,FoodData.SAUCE_BBQ);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_TORTILLA);
         _loc2_.setCheese(FoodData.CHEESE_PEPPERJACK);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_CHORIZO,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_TOMATO,FoodData.SAUCE_BBQ);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc2_);
      }
   }
}


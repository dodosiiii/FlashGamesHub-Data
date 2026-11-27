package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerSasha extends CustomerDataFile
   {
      
      public function CustomerSasha()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Sasha";
         this.customerClipName = "Sasha";
         this.thumbColor = "yelloworange";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_THREECHEESE);
         _loc1_.setCheese(FoodData.CHEESE_COLBY);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_TURKEY,FoodData.TOPPING_TOMATO,FoodData.SAUCE_MUSTARD);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc2_.setBread(FoodData.BREAD_CHEDDARSWIRL);
         _loc2_.setCheese(FoodData.CHEESE_COLBY);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_TURKEY,FoodData.TOPPING_TOMATO,FoodData.TOPPING_MACNCHEESE,FoodData.SAUCE_PARMESAN);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc2_);
      }
   }
}


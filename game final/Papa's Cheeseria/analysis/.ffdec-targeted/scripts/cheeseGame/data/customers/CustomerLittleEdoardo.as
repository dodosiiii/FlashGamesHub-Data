package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerLittleEdoardo extends CustomerDataFile
   {
      
      public function CustomerLittleEdoardo()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Little Edoardo";
         this.customerClipName = "LittleEdoardo";
         this.thumbColor = "deepred";
         this.flipdeckNumber = 14;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FOCACCIA);
         _loc1_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_SALAMI,FoodData.TOPPING_ONIONS,FoodData.TOPPING_SAUERKRAUT,FoodData.SAUCE_MUSTARD,FoodData.TOPPING_PICKLES);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_SOURCREAM,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_APRIL);
         _loc2_.setBread(FoodData.BREAD_PASKA);
         _loc2_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_SALAMI,FoodData.TOPPING_ONIONS,FoodData.TOPPING_SAUERKRAUT,FoodData.SAUCE_MUSTARD,FoodData.TOPPING_PICKLEDEGGS);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_SOURCREAM,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc2_);
      }
   }
}


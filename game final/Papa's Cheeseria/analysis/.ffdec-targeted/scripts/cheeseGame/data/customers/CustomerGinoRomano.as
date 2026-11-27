package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerGinoRomano extends CustomerDataFile
   {
      
      public function CustomerGinoRomano()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Gino Romano";
         this.customerClipName = "GinoRomano";
         this.thumbColor = "deepred";
         this.flipdeckNumber = 19;
         this.setupOrder();
         this.isHuge = true;
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_CIABATTA);
         _loc1_.setCheese(FoodData.CHEESE_SWISS);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_SAUERKRAUT,FoodData.SAUCE_AWESOME);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.SAUCE_AWESOME,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MARCH);
         _loc2_.setBread(FoodData.BREAD_CIABATTA);
         _loc2_.setCheese(FoodData.CHEESE_SWISS);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.SAUCE_IRISHPARSLEY,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_SAUERKRAUT,FoodData.SAUCE_AWESOME);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.SAUCE_AWESOME,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc2_);
      }
   }
}

